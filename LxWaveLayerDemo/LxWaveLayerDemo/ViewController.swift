//
//  ViewController.swift
//  LxWaveLayerDemo
//
//  Created by DeveloperLx on 15/12/12.
//  Copyright © 2015年 DeveloperLx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var _waveContainerView: UIView!
    
    var waveView: YXWaveView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let a = _waveContainerView.bounds.size.width
                
        let fram = CGRect(x: 30, y: _waveContainerView.bounds.size.height - _waveContainerView.bounds.size.width + 50, width: a, height: a)
        
        waveView = YXWaveView(frame: fram, color: DEFAULT_WAVE_COLOR)
        waveView.layer.cornerRadius = _waveContainerView.bounds.size.width / 2
        waveView.layer.masksToBounds = true
        waveView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        view.addSubview(waveView)
        waveView.start()
    }
    
    @IBAction func heightSliderValueChanged(_ sender: UISlider) {
        print(#function, CGFloat(sender.value))
        waveView.vHeight = CGFloat(sender.value)
    }

    @IBAction func amplitideSliderValueChanged(_ sender: UISlider) {
        print(#function, CGFloat(sender.value))
        waveView._waveHeight = CGFloat(sender.value)
    }

    @IBAction func periodSliderValueChanged(_ sender: UISlider) {
        print(#function, CGFloat(sender.value))
        waveView._waveCurvature = CGFloat(sender.value)
    }
    
    @IBAction func speedSliderValueChanged(_ sender: UISlider) {
        print(#function, CGFloat(sender.value))
        waveView._waveSpeed = CGFloat(sender.value)
    }
    
    @IBAction func phaseValueChanged(_ sender: UISlider) {
        print(#function, CGFloat(sender.value))
        waveView.phase = CGFloat(sender.value)
    }

    @IBAction func startOrStopSwitchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            waveView.start()
        } else {
            waveView.stop()
        }
    }
}

