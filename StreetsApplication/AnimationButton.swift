//
//  AnimationButton.swift
//  StreetsApplication
//
//  Created by warSong on 1/27/17.
//  Copyright © 2017 VS. All rights reserved.
//

import UIKit

public class AnimationButton: UIButton,Animatable {
    
    @IBInspectable public var startAnimations: Bool = false
    @IBInspectable public var nameAnimations: String = ""
    @IBInspectable public var curveAnimations: String = ""
    @IBInspectable public var x: CGFloat = 0.0
    @IBInspectable public var y: CGFloat = 0.0
    @IBInspectable public var scaleX: CGFloat = 1
    @IBInspectable public var scaleY: CGFloat = 1
    @IBInspectable public var shakeX: CGFloat = 0
    @IBInspectable public var shakeY: CGFloat = 0
    @IBInspectable public var transformScaleX: CGFloat = 0
    @IBInspectable public var transformScaleY: CGFloat = 0
    @IBInspectable public var force: CGFloat = 1.0
    @IBInspectable public var duration: CGFloat = 2
    @IBInspectable public var delay: CGFloat = 0
    @IBInspectable public var damping: CGFloat = 1
    @IBInspectable public var velocity: CGFloat = 0.7
    @IBInspectable public var repeatCount: CGFloat = 1
    
    public var animateForm: Bool = false
    public var opacity: CGFloat = 1
    
    lazy private var anim:AnimationObject = AnimationObject(self)
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        self.anim.customDidMovetoWindow()
    }
    public func animateObject() {
        self.anim.animateObject()
    }
}
