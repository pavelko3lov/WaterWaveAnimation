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
    
    private var tintColour = UIColor.white
    func setTintColour(_ tintColour: UIColor) {
        self.tintColour = tintColour
        imageView.tintColor = tintColour
        bottomLabel.textColor = tintColour
    }
    
    class func instanceFromNib() -> InvertView {
        return UINib(nibName: "InvertView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! InvertView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = UIImage(named: "iconError2")?.withRenderingMode(.alwaysTemplate)
    }
    
    func updateLabelText(_ string: String) {
        bottomLabel.text = string
    }
}
