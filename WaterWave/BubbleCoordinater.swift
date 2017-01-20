//
//  BubbleCoordinater.swift
//  WaterWave
//
//  Created by Pavel Kozlov on 20/01/2017.
//  Copyright © 2017 DeveloperLx. All rights reserved.
//

import Foundation
import UIKit

class BubbleCoordinater {
    
    var tintColor = UIColor.white
    private var maxBubbles = 30
    private var rect: CGSize = CGSize.zero
    var bubbles = [UIView]()
    
    init(_ rect: CGSize) {
        bubbles.removeAll()
        self.rect = rect
        
        for _ in 0..<maxBubbles {
            bubbles.append(createBubble())
        }
    }
    
    
    func createBubble() -> UIView {
        let radius: CGFloat = CGFloat(Int(Float(arc4random()) / Float(UINT32_MAX) * 3) + 2)
        let bubble = UIView(frame: CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2))
        bubble.layer.cornerRadius = radius
        bubble.layer.masksToBounds = true
        bubble.layer.borderColor = tintColor.cgColor
        bubble.layer.borderWidth = 1
        bubble.backgroundColor = UIColor.clear
        
        bubble.frame.origin = CGPoint(x: CGFloat(arc4random()) / CGFloat(UINT32_MAX) * rect.width, y: rect.height)
        
        
        let duration = TimeInterval(radius) * 4.0
        let delay: TimeInterval = TimeInterval(Double(arc4random()) / Double(UINT32_MAX) * 4)
        
        UIView.animate(withDuration: 2.0, delay: delay, options: [.repeat, .autoreverse], animations: {
            bubble.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: nil)
        
        
        let xAnimation = CABasicAnimation(keyPath: "position.x")
        xAnimation.duration = 2.0
        xAnimation.timeOffset = delay
        xAnimation.repeatCount = Float.infinity
        xAnimation.autoreverses = true
        xAnimation.fromValue = bubble.center.x - radius * 2
        xAnimation.toValue = bubble.center.x + radius * 2
        bubble.layer.add(xAnimation, forKey: nil)
        
        UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseIn, .repeat], animations: {
            bubble.frame.origin = CGPoint(x: bubble.frame.origin.x + 50.0, y: 0.0 - bubble.frame.size.height / 2)
        }, completion: nil)
        
        return bubble
    }
}
