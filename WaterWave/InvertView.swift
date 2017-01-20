//
//  InvertView.swift
//  WaterWave
//
//  Created by Pavel Kozlov on 20/01/2017.
//  Copyright © 2017 DeveloperLx. All rights reserved.
//

import UIKit

class InvertView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomLabel: UILabel!
    
    class func instanceFromNib() -> InvertView {
        return UINib(nibName: "InvertView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! InvertView
    }

}
