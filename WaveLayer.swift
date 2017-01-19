//
//  LxWaveLayer.swift
//  LxWaveLayerDemo
//
//  Created by DeveloperLx on 15/12/12.
//  Copyright © 2015年 DeveloperLx. All rights reserved.
//

import UIKit

public let DEFAULT_WAVE_COLOR = UIColor(red: 0.098, green: 0.651, blue: 0.996, alpha: 1)
private let DEFAULT_WAVE_HEIGHT: CGFloat = 180.0
private let DEFAULT_WAVE_AMPLITUDE: CGFloat = 6.0
private let DEFAULT_WAVE_SPEED: CGFloat = 270.0
private let DEFAULT_WAVE_PHASE: CGFloat = 0.0
private let DEFAULT_WAVE_PERIOD = 240.0

public class LxWaveLayer: CAShapeLayer {

    public var waveHeight = DEFAULT_WAVE_HEIGHT
    public var waveAmplitude = DEFAULT_WAVE_AMPLITUDE
    public var wavePeriod = DEFAULT_WAVE_PERIOD
    public var waveSpeed = DEFAULT_WAVE_SPEED
    public var wavePhase = DEFAULT_WAVE_PHASE
    
    private var shift: CGFloat = 0.0
    private var fColor: UIColor = DEFAULT_WAVE_COLOR
    
    private var _displayLink: CADisplayLink?
    
    convenience init(_ shift: CGFloat, fillColor: UIColor) {
        self.init()
        
        self.shift = shift
        self.fillColor = fillColor.cgColor
    }
    
    override init() {
        super.init()
//        addObserver(self, forKeyPath: "bounds", options: .new, context: nil)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        print(layer)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        
//        if keyPath == "bounds" {
//            let newBounds = change!["new"]!.CGRectValue
//            if newBounds.width > 0 && newBounds.height > 0 {
//                
//                updateBoundary()
//            }
//        }
//    }
    
    
    
    var wavePeriodCount: CGFloat = 240
    var vector: CGFloat = 1.0
    var timeToChange: Int = 0
    
    func updateBoundary(_ displayLink: CADisplayLink?=nil) {
        
        
        let boundaryPath = UIBezierPath()
        
        let layerWidth = self.bounds.width
        let layerHeight = self.bounds.height
        
        print("CGPoint(x: 0, y: layerHeight)", CGPoint(x: 0, y: layerHeight))
        
        boundaryPath.move(to: CGPoint(x: 0, y: layerHeight))
        boundaryPath.addLine(to: CGPoint(x: 0, y: layerHeight - waveHeight))
        
        var x: CGFloat = 0
        
//        var oldWavePeriod = wavePeriodCount
//        if timeToChange > 50 {
//            
//            if wavePeriodCount <= 720 && wavePeriodCount >= 180 {
//                wavePeriodCount = wavePeriodCount + vector
//            } else {
//                if vector > 0 {
//                    wavePeriodCount = 720
//                } else {
//                    wavePeriodCount = 180
//                }
//                vector = -vector
//            }
//            print("wavePeriodCount", wavePeriodCount)
//            
//            timeToChange = 0
//        } else {
//            timeToChange += 1
//        }
        
        
        while x <= layerWidth {
            x += 1.0
//            print(displayLink?.timestamp)
            if let displayLink = displayLink {
                let sinParameterValue = 2 * CGFloat(M_PI)/CGFloat(wavePeriod) * (x + shift + CGFloat(displayLink.timestamp) * waveSpeed)
                let y = waveAmplitude * sin(sinParameterValue) + layerHeight - waveHeight
                boundaryPath.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        boundaryPath.addLine(to: CGPoint(x: layerWidth, y: layerHeight))
        boundaryPath.close()
        
        path = boundaryPath.cgPath
        
        print("CGPoint(x: layerWidth, y: layerHeight)", CGPoint(x: layerWidth, y: layerHeight))
    }
    
    func deployOnView(view: UIView) {
    
        bounds = view.bounds
        anchorPoint = CGPoint.zero
        view.layer.addSublayer(self)
    }
    
    func beginWaveAnimation() {
    
        _displayLink = CADisplayLink(target: self, selector: #selector(LxWaveLayer.updateBoundary(_:)))
        _displayLink?.frameInterval = 1
        _displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
    }
    
    func stopWaveAnimation() {
     
        _displayLink?.invalidate()
        _displayLink = nil
    }
}
