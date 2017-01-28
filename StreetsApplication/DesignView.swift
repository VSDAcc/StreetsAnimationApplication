//
//  DesignView.swift
//  WorkingWithAnimations
//
//  Created by warSong on 1/25/17.
//  Copyright © 2017 VS. All rights reserved.
//

import UIKit

@IBDesignable public class DesignView: AnimationView {

    @IBInspectable public var cornerRadius:CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable public var borderWidth:CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable public var borderColor:UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
}
