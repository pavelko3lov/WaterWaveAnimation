//
//  WaterWaveCoordinator.swift
//  WaterWave
//
//  Created by Pavel Kozlov on 20/01/2017.
//  Copyright © 2017 DeveloperLx. All rights reserved.
//

import Foundation
import UIKit

class WaterWaveCoordinator: TimerCounterDelegate {
    
    var waveView: WaveView!
    let invertView = InvertView.instanceFromNib()
    
    init(_ container: UIView) {
        let a = container.bounds.size.width
        let fram = CGRect(x: 0, y: container.bounds.size.height - a, width: a, height: a)
        
        invertView.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        invertView.setTintColour(UIColor.black)
        container.addSubview(invertView)
        
        waveView = WaveView(frame: fram, color: UIColor(red: 0.098, green: 0.651, blue: 0.996, alpha: 1))
        waveView.layer.cornerRadius = container.bounds.size.width / 2
        waveView.layer.masksToBounds = true
        waveView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        container.addSubview(waveView)
        
        invertView.center = waveView.center
    }
    
    
    private var counter = 0
    
    func beginTimer(_ counter: Int) {
        self.counter = counter
        
        waveView.fullness = 1.0
        waveView.start(false)
        
        let timerCounter = TimerCounter(self)
        timerCounter.setLabels([invertView.bottomLabel, waveView.invertView.bottomLabel])
        timerCounter.setCounterValue(counter)
        timerCounter.start()
    }
    
    func timerFireDelegate(_ counter: Int) {
        if self.counter != 0 {
            waveView.fullness = CGFloat(counter) / CGFloat(self.counter)
        }
    }
}
