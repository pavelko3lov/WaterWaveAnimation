//
//  WaveView.swift
//  WaveView

import UIKit

open class WaveView: UIView {
    /// wave timmer
    fileprivate var timer: CADisplayLink?
    /// real aave
    fileprivate var realWaveLayer :CAShapeLayer = CAShapeLayer()
    /// mask wave
    fileprivate var maskWaveLayer :CAShapeLayer = CAShapeLayer()
    
    fileprivate var imageWaveLayer :CAShapeLayer = CAShapeLayer()
    /// offset
    fileprivate var offset :CGFloat = 0
    
    fileprivate var starting: Bool = false
    fileprivate var stoping: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        realWaveLayer.frame = CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: 0)
        maskWaveLayer.frame = CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: 0)
        self.backgroundColor = UIColor.clear
    }
    
    var contentImageLayer = CALayer()
    let invertView = InvertView.instanceFromNib()
    let maskImageLayer = CAShapeLayer()
    
    public convenience init(frame: CGRect, color:UIColor) {
        self.init(frame: frame)
        
        realWaveLayer.fillColor = color.withAlphaComponent(0.4).cgColor
        maskWaveLayer.fillColor = color.withAlphaComponent(0.4).cgColor
        
        layer.addSublayer(realWaveLayer)
        layer.addSublayer(maskWaveLayer)        
        
        invertView.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        invertView.setTintColour(UIColor.white)
        invertView.center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        addSubview(invertView)
        
        maskImageLayer.frame = invertView.bounds
        invertView.layer.mask = maskImageLayer
        
        phase = CGFloat(arc4random_uniform(3)) + 3.1
        waveHeight = CGFloat(arc4random_uniform(3)) + 3.1
        waveSpeed = CGFloat(arc4random_uniform(2)) + 3.6
        waveLength = CGFloat(arc4random_uniform(3)) + 3.1
    }
    
    open func start(_ withStarting: Bool=true) {
        if !starting {
            stop()
            starting = withStarting

            timer = CADisplayLink(target: self, selector: #selector(wave(_:)))
            timer?.frameInterval = 2
            timer?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        }
    }

    open func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    var fullness: CGFloat = 0
    var vHeight: CGFloat = 0
    
    var phase: CGFloat = 5.3
    var waveHeight: CGFloat = 3.3
    var waveSpeed: CGFloat = 3.73
    var waveLength: CGFloat = 3.9
    
    var phaseDirect: CGFloat = 1
    var waveHeightDirect: CGFloat = 1
    var waveSpeedDirect: CGFloat = 1
    var waveLengthDirect: CGFloat = 1
    
    let phaseKoef: CGFloat = 0.009
    let waveHeightKoef: CGFloat = 0.047
    let waveSpeedKoef: CGFloat = 0.33
    let waveLengthKoef: CGFloat = 0.007
    
    func randomWave() {
        if !(phase >= 0.1 && phase <= 10.0) {
            phaseDirect *= -1
        }
        phase = phase + phaseKoef * phaseDirect
        
        if !(waveHeight >= 3.0 && waveHeight <= 8.0) {
            waveHeightDirect *= -1
        }
        waveHeight = waveHeight + waveHeightKoef * waveHeightDirect
        
        if !(waveSpeed >= 3.5 && waveSpeed <= 5.0) {
            waveSpeedDirect *= -1
        }
        waveSpeed = waveSpeed + waveSpeedKoef * waveSpeedDirect
        
        if !(waveLength >= 3.0 && waveLength <= 6.0) {
            waveLengthDirect *= -1
        }
        waveLength = waveLength + waveLengthKoef * waveLengthDirect
    }

    func wave(_ displayLink: CADisplayLink?) {
        randomWave()
        
        if starting {
            if vHeight < frame.size.height * fullness {
                vHeight += frame.size.height / 100
            } else {
                starting = false
            }
        } else {
            vHeight = self.frame.size.height * fullness
        }
        setWaterHeight()
        
        offset += waveSpeed
        if offset > 32000 { offset = 1000 }
        
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: waveHeight))
        let maskpath = CGMutablePath()
        maskpath.move(to: CGPoint(x: 0, y: waveHeight))
        
        let maskImagePath = UIBezierPath()
        maskImagePath.move(to: convert(CGPoint(x: 0, y: frame.size.height - vHeight + waveHeight), to: invertView))
        
        let offset_f: Float = Float(offset * 0.045)
        let waveCurvature_f = Float(0.01 * waveLength)
        
        for x in 0...Int(frame.width) {
            let realY: CGFloat = waveHeight * CGFloat(sinf(waveCurvature_f * Float(x) + offset_f))
            path.addLine(to: CGPoint(x: CGFloat(x), y: realY - waveHeight))
            
            let maskY = waveHeight * CGFloat(sinf(waveCurvature_f * Float(x) + offset_f + Float(phase) * Float(2 * M_PI)))
            maskpath.addLine(to: CGPoint(x: CGFloat(x), y: maskY - waveHeight))
            
            let commonWave = max(realY, maskY) - waveHeight
            let imagePoint = convert(CGPoint(x: CGFloat(x), y: frame.size.height - vHeight + commonWave), to: invertView)
            if imagePoint.x >= 0 && imagePoint.x <= invertView.bounds.size.width {
                maskImagePath.addLine(to: imagePoint)
            }
        }
        
        path.addLine(to: CGPoint(x: frame.width, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.size.height))

        path.closeSubpath()
        self.realWaveLayer.path = path
        
        maskpath.addLine(to: CGPoint(x: frame.width, y: self.frame.size.height))
        maskpath.addLine(to: CGPoint(x: 0, y: self.frame.size.height))
        
        maskpath.closeSubpath()
        self.maskWaveLayer.path = maskpath
        
        maskImagePath.addLine(to: CGPoint(x: invertView.frame.size.width, y: invertView.frame.size.height))
        maskImagePath.addLine(to: CGPoint(x: 0, y: invertView.frame.size.height))
        maskImagePath.close()
        
        maskImageLayer.path = maskImagePath.cgPath
    }
    
    private func setWaterHeight() {
        maskWaveLayer.frame.origin.y = self.frame.size.height - vHeight
        realWaveLayer.frame.origin.y = self.frame.size.height - vHeight
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
