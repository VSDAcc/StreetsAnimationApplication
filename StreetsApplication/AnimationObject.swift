//
//  AnimationObject.swift
//  WorkingWithAnimations
//
//  Created by warSong on 1/23/17.
//  Copyright © 2017 VS. All rights reserved.
//

import UIKit

enum AnimationType: String {
    case SlideLeft = "slideLeft"
    case SlideRight = "slideRight"
    case SlideUp = "slideUp"
    case SlideDown = "slideDown"
    case ZoomIn = "zoomIn"
    case ZoomOut = "zoomOut"
    case SqueezyLeft = "squeezyLeft"
    case SqueezyRight = "squeezyRight"
    case CAShakeX = "CAShakeX"
    case CAShakeY = "CAShakeY"
    case CAScaleX = "CAScaleX"
    case CAScaleY = "CAScaleY"
    case CAScaleXScaleY = "CAScaleXScaleY"
    case CAShakeXShakeY = "CAShakeXShakeY"
}
enum AnimationCurveType: String {
    case EasyIn = "easyIn"
    case EasyOut = "easyOut"
    case Linear = "linear"
    case EasyInEasyOut = "easyInEasyOut"
    case EaseInOutQuart = "easeInOutQuart"//0.77, 0, 0.175, 1
    case EaseInOutQuint = "easeInOutQuint" //0.86, 0, 0.07, 1
    case EaseOutCirc = "easeOutCirc" //0.075, 0.82, 0.165, 1
    case EaseInOutBack = "easeInOutBack" //0.68, -0.55, 0.265, 1.55
}

public class AnimationObject: NSObject {
    
    private unowned var view: Animatable
    private var shouldAnimateAfterActive = false
    public var defaultPosition = 0
    public var middlePosition = 0.7
    
    init(_ view:Animatable) {
        self.view = view
        super.init()
        generalInit()
    }
    public func animateObject() {
        animateForm = true
        animatePreset()
        configureView()
    }
    public func customDidMovetoWindow() {
        if startAnimations {
            if UIApplication.shared.applicationState != .active {
                shouldAnimateAfterActive = true
                return
            }else {
                alpha = 0
                animateObject()
            }
        }
    }
    
   private var startAnimations: Bool {
        get { return self.view.startAnimations }
        set { return self.view.startAnimations = newValue }
    }
   private var nameAnimations: String {
        get { return self.view.nameAnimations }
        set { return self.view.nameAnimations = newValue }
    }
   private var curveAnimations: String {
        get { return self.view.curveAnimations }
        set { return self.view.curveAnimations = newValue }
    }
   private var x: CGFloat {
        get { return self.view.x }
        set { return self.view.x = newValue }
    }
   private var y: CGFloat {
        get { return self.view.y }
        set { return self.view.y = newValue }
    }
   private var scaleX: CGFloat {
        get { return self.view.scaleX }
        set { return self.view.scaleX = newValue }
    }
   private var scaleY: CGFloat {
        get { return self.view.scaleY }
        set { return self.view.scaleY = newValue }
    }
   private var transformScaleX: CGFloat {
        get { return self.view.transformScaleX }
        set { return self.view.transformScaleX = newValue }
    }
   private var transformScaleY: CGFloat {
        get { return self.view.transformScaleY }
        set { return self.view.transformScaleY = newValue }
    }
   private var shakeX: CGFloat {
        get { return self.view.shakeX }
        set { return self.view.shakeX = newValue }
    }
   private var shakeY: CGFloat {
        get { return self.view.shakeY }
        set { return self.view.shakeY = newValue }
    }
   private var force: CGFloat {
        get { return self.view.force }
        set { return self.view.force = newValue }
    }
   private var opacity: CGFloat {
        get { return self.view.opacity }
        set { return self.view.opacity = newValue }
    }
   private var alpha: CGFloat {
        get { return self.view.alpha }
        set { return self.view.alpha = newValue }
    }
   private var repeatCount: CGFloat {
        get { return self.view.repeatCount }
        set { return self.view.repeatCount = newValue }
    }
   private var animateForm: Bool {
        get { return self.view.animateForm }
        set { return self.view.animateForm = newValue }
    }
   private var transform: CGAffineTransform {
        get { return self.view.transform }
        set { return self.view.transform = newValue }
    }
   private var layer: CALayer {
        get { return self.view.layer }
    }
   private var duration: CGFloat {
        get { return self.view.duration }
        set { return self.view.duration = newValue }
    }
   private var delay: CGFloat {
        get { return self.view.delay }
        set { return self.view.delay = newValue }
    }
   private var damping: CGFloat {
        get { return self.view.damping }
        set { return self.view.damping = newValue }
    }
   private var velocity: CGFloat {
        get { return self.view.velocity }
        set { return self.view.velocity = newValue }
    }

// MARK: Notifications
    func generalInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActiveNotification(_ :)), name:NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    func didBecomeActiveNotification(_ notification: NotificationCenter) {
        if shouldAnimateAfterActive {
            animateObject()
            shouldAnimateAfterActive = false
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
// MARK: Helped Methods
    
    public func animatePreset()  {
        alpha = 1.0
        if let animation = AnimationType(rawValue: nameAnimations) {
            switch animation {
            case .SlideLeft: x = 300 * force
            case .SlideRight: x = -300 * force
            case .SlideUp: y = 300 * force
            case .SlideDown: y = -300 * force
            case .ZoomIn: scaleX = 2 * force; scaleY = 2 * force; opacity = 0
            case .ZoomOut: scaleX = 0.1 * force; scaleY = 0.1 * force; opacity = 0
            case .SqueezyLeft: x = 300 * force; scaleX = 3 * force; opacity = 0
            case .SqueezyRight: x = -300 * force; scaleX = 3 * force; opacity = 0
            case .CAShakeX:
                self.makeCoreAnimationWithKeyPath(keyPath: "position.x", animationKey: "CAShakeX",itsX:true, value: shakeX)
            case .CAShakeY:
                self.makeCoreAnimationWithKeyPath(keyPath: "position.y", animationKey: "CAShakeY",itsX:false, value: shakeY)
            case .CAScaleX:
                self.makeCoreAnimationWithKeyPath(keyPath: "transform.scale.x", animationKey: "CAScaleX",itsX:true, value: transformScaleX)
            case .CAScaleY:
                self.makeCoreAnimationWithKeyPath(keyPath: "transform.scale.y", animationKey: "CAScaleY",itsX:false, value: transformScaleY)
            case .CAScaleXScaleY:
                self.makeCoreAnimationWithKeyPath(keyPath: "transform.scale.x", animationKey: "CAScaleX",itsX:true, value: transformScaleX)
                self.makeCoreAnimationWithKeyPath(keyPath: "transform.scale.y", animationKey: "CAScaleY",itsX:false, value: transformScaleY)
            case .CAShakeXShakeY:
                self.makeCoreAnimationWithKeyPath(keyPath: "position.x", animationKey: "CAShakeX", itsX:true, value: shakeX)
                self.makeCoreAnimationWithKeyPath(keyPath: "position.y", animationKey: "CAShakeY", itsX:false, value: shakeY)
            }
        }
    }
    
    func makeCoreAnimationWithKeyPath(keyPath:String,animationKey:String, itsX: Bool, value: CGFloat) {
        layer.add(self.coreAnimationSettings(keyPath: keyPath,
                                             value: self.animationValueXorY(itsX: itsX, value: value),
                                             timingFunction:self.animateCurveCAMediaTimingFunction(animationCurve: curveAnimations),
                                             duration: CFTimeInterval(duration),
                                             repeatCount:Float(repeatCount)),
                                             forKey: animationKey)
    }
    func animationValueXorY(itsX:Bool,value:CGFloat) -> [Any] {
        let valueXorY: [Any]
        if itsX {
            valueXorY = [defaultPosition, value * force,middlePosition, -value * force, defaultPosition]
        }else {
            valueXorY = [defaultPosition, middlePosition, value * force, -middlePosition, defaultPosition]
        }
        return valueXorY
    }
    func coreAnimationSettings(keyPath: String, value: [Any],timingFunction:CAMediaTimingFunction,duration:CFTimeInterval,repeatCount:Float) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.values = value
        animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        animation.timingFunction = timingFunction
        animation.isAdditive = true
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
        return animation
    }
    func animateCurveCAMediaTimingFunction(animationCurve: String) -> CAMediaTimingFunction {
        if let curve = AnimationCurveType(rawValue: animationCurve) {
            switch curve {
            case .EasyIn: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            case .EasyOut: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            case .EasyInEasyOut: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            case .Linear: return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            case .EaseInOutQuart: return CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
            case .EaseInOutQuint: return CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1)
            case .EaseOutCirc: return CAMediaTimingFunction(controlPoints: 0.075, 0.82, 0.165, 1)
            case .EaseInOutBack: return CAMediaTimingFunction(controlPoints: 0.68, -0.55, 0.265, 1.55)
            }
        }
        return CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
    }
    func animateCurveViewOptions(animationCurve: String) -> UIViewAnimationOptions {
        if let curve = AnimationCurveType(rawValue: animationCurve) {
            switch curve {
            case .EasyIn: return UIViewAnimationOptions.curveEaseIn
            case .EasyOut: return UIViewAnimationOptions.curveEaseOut
            case .EasyInEasyOut: return UIViewAnimationOptions.curveEaseInOut
            case .Linear: return UIViewAnimationOptions.curveLinear
            default: return UIViewAnimationOptions.curveLinear
            }
        }
        return UIViewAnimationOptions.curveLinear
    }
    
    func configureView() {
        if animateForm {
            let transform = CGAffineTransform(translationX: self.x, y: self.y).scaledBy(x: scaleX, y: scaleY)
            self.transform = transform
            self.alpha = self.opacity
        }
            UIView.animate(withDuration: TimeInterval(self.duration),
                           delay:TimeInterval(self.delay) ,
                           usingSpringWithDamping: self.damping,
                           initialSpringVelocity: self.velocity,
                           options: self.animateCurveViewOptions(animationCurve: curveAnimations),
                           animations: { [weak self] in
                            if let _self = self {
                                if _self.animateForm {
                                    _self.transform = CGAffineTransform.identity
                                    _self.alpha = 1.0
                                }else {
                                    let transform = CGAffineTransform(translationX: _self.x, y: _self.y).scaledBy(x: _self.scaleX, y: _self.scaleY)
                                    _self.transform = transform
                                    _self.alpha = _self.opacity
                                }
                            }
                            },completion: { [weak self] (finished) in
                            if finished {
                               if let _self = self {
                                      _self.resetAllStats()
                                    }
                                }
            })
    }

    func resetAllStats()   {
        startAnimations = false
        nameAnimations = ""
        scaleX = 0.0
        scaleY = 0.0
        shakeX = 0.0
        shakeY = 0.0
        transformScaleX = 0.0
        transformScaleY = 0.0
        force = 1
        duration = 1.5
        delay = 0
        damping = 1
        velocity = 0.7
        repeatCount = 1
    }  
}
