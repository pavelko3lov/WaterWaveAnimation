<<<<<<< HEAD
# WaterWaveAnimation
=======
# LxWaveLayer-swift
    Easily add wave animation.

### Installation
    You only need drag LxWaveLayer.swift to your project.

### Support
    Minimum support iOS version: iOS 6.0

### Usage
```swift
    //  setup
    _waveLayer = LxWaveLayer()
    _waveLayer.deployOnView(SUPER_VIEW)

    //  begin animation
    _waveLayer.beginWaveAnimation()

    //  stop animation
    [_waveLayer stopWaveAnimation];

    //  adjust property
    _waveLayer.fillColor = WAVE_COLOR.CGColor
    _waveLayer.waveHeight = 180
    _waveLayer.waveAmplitude = 6
    _waveLayer.wavePeriod = 270
    _waveLayer.waveSpeed = 240
    _waveLayer.wavePhase = 80

```

### License
    LxWaveLayer-swift is available under the MIT License. See the LICENSE file for more info.
>>>>>>> init
