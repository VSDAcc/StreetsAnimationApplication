//
//  File.swift
//  WorkingWithAnimations
//
//  Created by warSong on 1/23/17.
//  Copyright © 2017 VS. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol Animatable {
    var startAnimations: Bool {get set}
    var curveAnimations: String {get set}
    var animateForm: Bool {get set}
    var nameAnimations: String {get set}
    var x: CGFloat {get set}
    var y: CGFloat {get set}
    var scaleX: CGFloat {get set}
    var scaleY: CGFloat {get set}
    var transformScaleX: CGFloat {get set}
    var transformScaleY: CGFloat {get set}
    var shakeX: CGFloat {get set}
    var shakeY: CGFloat {get set}
    var force: CGFloat {get set}
    var opacity: CGFloat {get set}
    var duration: CGFloat {get set}
    var delay: CGFloat {get set}
    var damping: CGFloat {get set}
    var velocity: CGFloat {get set}
    var repeatCount: CGFloat {get set}
    
    // UIView:
    var transform: CGAffineTransform {get set}
    var alpha: CGFloat {get set}
    var layer: CALayer {get}
    
    
    func animateObject()
}
