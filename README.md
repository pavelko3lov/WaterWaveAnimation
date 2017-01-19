# WaterWaveAnimation
=======
# WaterWave-swift
    Easily add wave animation, with invertion background

### Installation
    You only need drag WaterWave.swift to your project.

### Support
    Minimum support iOS version: iOS 8.0

### Usage
```swift
    //  setup
    waveView = WaveView(frame: fram, color: UIColor(red: 0.098, green: 0.651, blue: 0.996, alpha: 1))
    waveView.layer.cornerRadius = _waveContainerView.bounds.size.width / 2
    waveView.layer.masksToBounds = true
    view.addSubview(waveView)

    //  begin animation
    waveView.start()

    //  stop animation
    waveView.stop()

    //  adjust property
    waveView.fullness = 0.5

```

### License
    WaterWave-swift is available under the MIT License. See the LICENSE file for more info.
