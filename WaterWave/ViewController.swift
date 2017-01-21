//
//  ViewController.swift
//  WaterWave
//

import UIKit

extension UIImage {
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var waveContainerView: UIView!
    
    @IBOutlet weak var tileView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var waterWaveCoordinator: WaterWaveCoordinator?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        waterWaveCoordinator = WaterWaveCoordinator(waveContainerView)
////        waterWaveCoordinator?.beginTimer(60)
//        waterWaveCoordinator?.waveView.fullness = 1.0
//        waterWaveCoordinator?.waveView.start(false)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeTileBackground(UIImage(named: "loyalty"))
//        makeTileBackground(UIImage(named: "iconNotification"))
//        makeTileBackground(UIImage(named: "miles"))
    }
    
    func makeTileBackground(_ image: UIImage?) {
        //add transparent space arround
        let spacedImage = addSpaceToImage(image, scale: 1.5)
        //colorize image to certain color
        let colorSpacedImage = spacedImage?.maskWithColor(color: UIColor(red: 53/255, green: 150/255, blue: 189/255, alpha: 1.0))
        //descrease common image size to certain
        var newSize: CGSize
        if let size = colorSpacedImage?.size {
            newSize = CGSize(width: size.width * 0.2, height: size.height * 0.2)
        } else {
            newSize = CGSize(width: 40, height: 40)
        }
        let resizeColorSpacedImage = resizeImage(colorSpacedImage, targetSize: newSize)
        tileView.backgroundColor = resizeColorSpacedImage != nil ? UIColor(patternImage: resizeColorSpacedImage!): UIColor.clear
        tileView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 8))
        
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.white
    }
    
    func addSpaceToImage(_ image: UIImage?, scale: CGFloat) -> UIImage? {
        guard let image = image else { return nil }
        
        let width = image.size.width * scale
        let height = image.size.height * scale
        
        let origin = CGPoint(x: (width - image.size.width) / 2, y: (height - image.size.height) / 2)
        
        // Now we can draw anything we want into this new context.
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0.0)
        image.draw(at: origin)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func resizeImage(_ image: UIImage?, targetSize: CGSize) -> UIImage? {
        guard let image = image else { return nil }
        
        let size = image.size
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    @IBOutlet weak var waveHeight: UISlider!
    
    @IBAction func heightSliderValueChanged(_ sender: UISlider) {
        print(#function, CGFloat(sender.value))
        waterWaveCoordinator?.waveView.fullness = CGFloat(sender.value)
    }

    @IBAction func amplitideSliderValueChanged(_ sender: UISlider) {
        print(#function, CGFloat(sender.value))
        waterWaveCoordinator?.waveView.waveHeight = CGFloat(sender.value)
    }

    @IBAction func periodSliderValueChanged(_ sender: UISlider) {
        print(#function, CGFloat(sender.value))
        waterWaveCoordinator?.waveView.waveLength = CGFloat(sender.value)
    }
    
    @IBAction func speedSliderValueChanged(_ sender: UISlider) {
        print(#function, CGFloat(sender.value))
        waterWaveCoordinator?.waveView.waveSpeed = CGFloat(sender.value)
    }
    
    @IBAction func phaseValueChanged(_ sender: UISlider) {
        print(#function, CGFloat(sender.value))
        waterWaveCoordinator?.waveView.phase = CGFloat(sender.value)
    }

    @IBAction func startOrStopSwitchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            waterWaveCoordinator?.waveView.start()
        } else {
            waterWaveCoordinator?.waveView.stop()
        }
    }
}

