//
//  ViewController.swift
//  WaterWave
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var _waveContainerView: UIView!
    
    var waveView: WaveView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let a = _waveContainerView.bounds.size.width
                
        let fram = CGRect(x: 30, y: _waveContainerView.bounds.size.height - _waveContainerView.bounds.size.width + 50, width: a, height: a)
        
        let image = UIImage(named: "iconError2")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
        imageView.tintColor = UIColor.black
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)

        
        waveView = WaveView(frame: fram, color: UIColor(red: 0.098, green: 0.651, blue: 0.996, alpha: 1))
        waveView.layer.cornerRadius = _waveContainerView.bounds.size.width / 2
        waveView.layer.masksToBounds = true
        waveView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        view.addSubview(waveView)
        waveView.fullness = 0.5
        waveHeight.value = Float(waveView.fullness)
        waveView.start()
        
        imageView.center = waveView.center
    }
    
    @IBOutlet weak var waveHeight: UISlider!
    
    @IBAction func heightSliderValueChanged(_ sender: UISlider) {
        print(#function, CGFloat(sender.value))
        waveView.fullness = CGFloat(sender.value)
    }

    @IBAction func amplitideSliderValueChanged(_ sender: UISlider) {
        print(#function, CGFloat(sender.value))
        waveView.waveHeight = CGFloat(sender.value)
    }

    @IBAction func periodSliderValueChanged(_ sender: UISlider) {
        print(#function, CGFloat(sender.value))
        waveView.waveLength = CGFloat(sender.value)
    }
    
    @IBAction func speedSliderValueChanged(_ sender: UISlider) {
        print(#function, CGFloat(sender.value))
        waveView.waveSpeed = CGFloat(sender.value)
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

