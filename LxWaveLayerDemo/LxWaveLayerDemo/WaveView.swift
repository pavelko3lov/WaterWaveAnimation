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
    
//    var maskLayer: CAShapeLayer = CAShapeLayer()
    var contentImageLayer = CALayer()
    let imageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
    let maskImageLayer = CAShapeLayer()
    
    public convenience init(frame: CGRect, color:UIColor) {
        self.init(frame: frame)
        
        realWaveLayer.fillColor = color.withAlphaComponent(0.4).cgColor
        maskWaveLayer.fillColor = color.withAlphaComponent(0.4).cgColor
        
        self.layer.addSublayer(self.realWaveLayer)
        self.layer.addSublayer(self.maskWaveLayer)
        
        
        
        
        
        
//        contentImageLayer.contents = UIImage(named: "iconError2")?.cgImage
//        contentImageLayer.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
//        contentImageLayer.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
//        layer.addSublayer(contentImageLayer)
        
        let image = UIImage(named: "iconError2")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.white
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        imageView.clipsToBounds = true
        self.addSubview(imageView)
//        imageView.backgroundColor = UIColor.yellow
        
//        maskImageLayer.frame = imageView.bounds
//        imageView.layer.mask = maskImageLayer
        
//        print("imageView", imageView.frame, maskImage.frame)
//        let rect = CGRect(x: 50, y: 50, width: 400, height: 400)
//        let path = UIBezierPath(rect: rect)
//        maskLayer.path = path.cgPath
//        
//        maskLayer.bounds = rect
//        maskWaveLayer.mask = maskLayer
//        maskWaveLayer.masksToBounds = true
//        addSubview(imageView)
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
        
//        if starting {
//        
//            if vHeight < frame.size.height * fullness {
//                vHeight += frame.size.height / 100
//            } else {
//                starting = false
//            }
//        } else {
            vHeight = self.frame.size.height * fullness
//        }
        setWaterHeight()
        
        offset += waveSpeed
        if offset > 32000 { offset = 1000 }
        
        let height = CGFloat(waveHeight)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: height))
        let maskpath = CGMutablePath()
        maskpath.move(to: CGPoint(x: 0, y: height))
        
        let maskImagePath = UIBezierPath()
        maskImagePath.move(to: CGPoint(x: 0, y: imageView.frame.size.height / 2))
//        maskImagePath.move(to: imageView.convert(CGPoint(x: 0, y: vHeight), from: imageView.superview))
//        print("imageView.convert(CGPoint(x: 0, y: height), from: imageView.superview)", imageView.convert(CGPoint(x: 0, y: vHeight + waveHeight * 20), from: imageView.superview))
//        print("111", CGPoint(x: 0, y: imageView.frame.size.height / 2))
        
        let offset_f: Float = Float(offset * 0.045)
        let waveCurvature_f = Float(0.01 * waveLength)
        
        for x in 0...Int(frame.width) {
            var y: CGFloat = height * CGFloat(sinf(waveCurvature_f * Float(x) + offset_f))
            path.addLine(to: CGPoint(x: CGFloat(x), y: y - waveHeight))
            
            y = height * CGFloat(sinf(waveCurvature_f * Float(x) + offset_f + Float(phase) * Float(2 * M_PI)))
            maskpath.addLine(to: CGPoint(x: CGFloat(x), y: y - waveHeight))
            
            
            
//            print(CGPoint(x: CGFloat(x), y: y - waveHeight), imageView.convert(CGPoint(x: CGFloat(x), y: y - waveHeight), from: imageView.superview))
//            maskImagePath.addLine(to: imageView.convert(CGPoint(x: CGFloat(x), y: y - waveHeight), from: imageView.superview))
        }
        
        
        for x in 0...Int(imageView.frame.width) {
            let y: CGFloat = height * CGFloat(sinf(waveCurvature_f * Float(x) + offset_f)) + imageView.frame.size.height / 2
            maskImagePath.addLine(to: CGPoint(x: CGFloat(x), y: y - waveHeight / 2))
        }
        
//        maskImagePath.addLine(to: CGPoint(x: imageView.frame.size.width, y: imageView.frame.size.height / 2))
//        print("waveHeight * 4", waveHeight * 4)
        
        path.addLine(to: CGPoint(x: frame.width, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.size.height))

        path.closeSubpath()
        self.realWaveLayer.path = path
        
        maskpath.addLine(to: CGPoint(x: frame.width, y: self.frame.size.height))
        maskpath.addLine(to: CGPoint(x: 0, y: self.frame.size.height))
        
        maskpath.closeSubpath()
        self.maskWaveLayer.path = maskpath
        
        
        maskImagePath.addLine(to: CGPoint(x: imageView.frame.size.width, y: imageView.frame.size.height))
        maskImagePath.addLine(to: CGPoint(x: 0, y: imageView.frame.size.height))
//        maskImagePath.addLine(to: imageView.convert(CGPoint(x: frame.width, y: self.frame.size.height), from: imageView.superview))
//            print(">>>", imageView.convert(CGPoint(x: frame.width, y: self.frame.size.height), from: imageView.superview))
//        maskImagePath.addLine(to: imageView.convert(CGPoint(x: 0, y: self.frame.size.height), from: imageView.superview))

        
        maskImagePath.close()
        
        let maskImageLayer2 = CAShapeLayer()
        maskImageLayer2.frame = imageView.bounds
        maskImageLayer2.path = maskImagePath.cgPath
        imageView.layer.mask = maskImageLayer2
//        updateMasks(maskImagePath)
        
        
//        if (overView != nil) {
//            let centX = self.bounds.size.width/2
//            let centY = height * CGFloat(sinf(waveCurvature_f * Float(centX)  + offset_f))
//            let center = CGPoint(x: centX , y: centY + self.bounds.size.height - overView!.bounds.size.height/2 - _waveHeight - 1 )
//            overView?.center = center
//        }
    }
    
    var oldPath: UIBezierPath?
    func updateMasks(_ path: UIBezierPath) {
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0
        
        // Your new shape here
        animation.fromValue = oldPath?.cgPath
        animation.toValue = path.cgPath
        
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        // The next two line preserves the final shape of animation,
        // if you remove it the shape will return to the original shape after the animation finished
//        animation.fillMode = kCAFillModeForwards
//        animation.isRemovedOnCompletion = false
        
//        shapeLayer.addAnimation(animation, forKey: nil)
        animation.duration = 0.0
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        imageView.layer.mask?.add(animation, forKey: "morph shape back and forth")
        imageView.layer.mask?.speed = 0
        
        oldPath = path
        // update the mask
//        maskImage.frame = imageView.bounds
        
        // if the bounds change happens within an animation, also animate the mask path
//        if boundsAnimation == nil {
//            self.maskImage.path = path.cgPath
//        } else if let boundsAnimation = boundsAnimation {
//            // copying the original animation allows us to keep all animation settings
//            let animation: CABasicAnimation = boundsAnimation
//            animation.keyPath = "path"
//            
////            CGPathRef newPath = [self createMaskPath];
//            animation.fromValue = maskImage.path
//            animation.toValue = path.cgPath
//            
//            maskImage.path = path.cgPath
//            
//            maskImage.add(animation, forKey: "path")
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
