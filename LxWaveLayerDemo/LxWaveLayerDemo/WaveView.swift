//
//  WaveView.swift
//  WaveView

import UIKit

open class WaveView: UIView {

    /// float over View
    open var overView: UIView?
    /// wave timmer
    fileprivate var timer: CADisplayLink?
    /// real aave
    fileprivate var realWaveLayer :CAShapeLayer = CAShapeLayer()
    /// mask wave
    fileprivate var maskWaveLayer :CAShapeLayer = CAShapeLayer()
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
    
    public convenience init(frame: CGRect, color:UIColor) {
        self.init(frame: frame)
        
        realWaveLayer.fillColor = color.withAlphaComponent(0.4).cgColor
        maskWaveLayer.fillColor = color.withAlphaComponent(0.4).cgColor
        
        self.layer.addSublayer(self.realWaveLayer)
        self.layer.addSublayer(self.maskWaveLayer)
    }
    
    open func start() {
        if !starting {
            stop()
            starting = true
            stoping = false

            timer = CADisplayLink(target: self, selector: #selector(wave(_:)))
            timer?.frameInterval = 2
            timer?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        }
    }

    open func stop() {
        if (timer != nil) {
            timer?.invalidate()
            timer = nil
        }
        if !stoping {
            starting = false
            stoping = true
        }
    }
    
    var fullness: CGFloat = 0
    var vHeight: CGFloat = 0
    
    var waveLength: CGFloat = 1.1
    var waveSpeed: CGFloat = 0.6
    var waveHeight: CGFloat = 4.0
    var phase: CGFloat = 0.2
    
    var phaseDirect: CGFloat = 1
    var waveHeightDirect: CGFloat = 1
    var waveSpeedDirect: CGFloat = 1
    var waveLengthDirect: CGFloat = 1
    
    let phaseKoef: CGFloat = 0.01
    let waveHeightKoef: CGFloat = 0.05
    let waveSpeedKoef: CGFloat = 0.01
    let waveLengthKoef: CGFloat = 0.01
    
    func randomWave() {
        if !(phase >= 0.1 && phase <= 10.0) {
            phaseDirect *= -1
        }
        phase = phase + phaseKoef * phaseDirect
        
        if !(waveHeight >= 3.0 && waveHeight <= 9.0) {
            waveHeightDirect *= -1
        }
        waveHeight = waveHeight + waveHeightKoef * waveHeightDirect
        
        if !(waveSpeed >= 0.5 && waveSpeed <= 1.25) {
            waveSpeedDirect *= -1
        }
        waveSpeed = waveSpeed + waveSpeedKoef * waveSpeedDirect
        
        if !(waveLength >= 1.0 && waveLength <= 2.0) {
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
        
        let width = frame.width
        let height = CGFloat(waveHeight)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: height))
        let maskpath = CGMutablePath()
        maskpath.move(to: CGPoint(x: 0, y: height))
        
        let offset_f: Float = Float(offset * 0.045)
        let waveCurvature_f = Float(0.01 * waveLength)
        
        for x in 0...Int(width) {
            var y: CGFloat = height * CGFloat(sinf(waveCurvature_f * Float(x) + offset_f))
            path.addLine(to: CGPoint(x: CGFloat(x), y: y - waveHeight))
            
            y = height * CGFloat(sinf(waveCurvature_f * Float(x) + offset_f + Float(phase) * Float(2 * M_PI)))
            maskpath.addLine(to: CGPoint(x: CGFloat(x), y: y - waveHeight))
        }
        
        path.addLine(to: CGPoint(x: width, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.size.height))

        path.closeSubpath()
        self.realWaveLayer.path = path
        
        maskpath.addLine(to: CGPoint(x: width, y: self.frame.size.height))
        maskpath.addLine(to: CGPoint(x: 0, y: self.frame.size.height))

        maskpath.closeSubpath()
        self.maskWaveLayer.path = maskpath
        
//        if (overView != nil) {
//            let centX = self.bounds.size.width/2
//            let centY = height * CGFloat(sinf(waveCurvature_f * Float(centX)  + offset_f))
//            let center = CGPoint(x: centX , y: centY + self.bounds.size.height - overView!.bounds.size.height/2 - _waveHeight - 1 )
//            overView?.center = center
//        }
    }
    
    func setWaterHeight() {
        maskWaveLayer.frame.origin.y = self.frame.size.height - vHeight
        realWaveLayer.frame.origin.y = self.frame.size.height - vHeight
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open func addOverView(_ view: UIView) {
        overView = view
        overView?.center = self.center
        overView?.frame.origin.y = self.frame.height - (overView?.frame.height)!
        self.addSubview(overView!)
    }
}
