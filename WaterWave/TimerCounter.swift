//
//  TimerCounter.swift
//  WaterWave
//
//  Created by Pavel Kozlov on 20/01/2017.
//  Copyright © 2017 DeveloperLx. All rights reserved.
//

import Foundation
import UIKit

protocol TimerCounterDelegate: class {
    func timerFireDelegate(_ counter: Int)
}

class TimerCounter {
    
    static var shared = TimerCounter()
    
    var updateLabels = [UILabel]()
    var timer: Timer?
    
    private weak var delegate: TimerCounterDelegate?
    init(_ delegate: TimerCounterDelegate?=nil) {
        self.delegate = delegate
    }
    
    func setLabels(_ updateLabels: [UILabel]) {
        self.updateLabels = updateLabels
    }
    
    private var counter = 60
    func setCounterValue(_ counter: Int) {
        self.counter = counter
    }
    func start() {
        counter = 60
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(TimerCounter.timerFire(_:)), userInfo: nil, repeats: true)
        timer?.tolerance = 0.2
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    @objc func timerFire(_ timer: Timer?) {
        counter -= 1
        
        for label in updateLabels {
            label.text = "\(counter)"
        }
        delegate?.timerFireDelegate(counter)
        
        if counter <= 0 {
            stop()
        }
    }
    
    func stop() {
        counter = 0
        timer?.invalidate()
        timer = nil
    }
}
