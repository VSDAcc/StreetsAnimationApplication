//
//  MainViewController.swift
//  StreetsApplication
//
//  Created by warSong on 1/21/17.
//  Copyright © 2017 VS. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UIGestureRecognizerDelegate {
    
    
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var topBarImageView: UIImageView!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var bottomBarImageView: UIImageView!
    
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userButtonImageView: UIImageView!
    @IBOutlet weak var dialogView: DesignView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var bottomBarLabel: UILabel!
    
    @IBOutlet weak var sharePopoverView: AnimationView!
    @IBOutlet weak var shareButton: AnimationButton!
    @IBOutlet weak var twitterButton: AnimationButton!
    @IBOutlet weak var faceBookButton: AnimationButton!
    @IBOutlet weak var twittterLabel: AnimationLabel!
    @IBOutlet weak var faceBookLabel: AnimationLabel!
    @IBOutlet weak var maskButton: AnimationButton!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var animator: UIDynamicAnimator!
    var attachmentBahavior: UIAttachmentBehavior!
    var snapBehaviorDialogView: UISnapBehavior!
    var snapBehaviorUserView: UISnapBehavior!
    var collisionBahavior: UICollisionBehavior!
    var userViewItemBehavior: UIDynamicItemBehavior!
    var centerDialogView: CGPoint!
    var centerUserView: CGPoint!
    var visualEffectView: UIVisualEffectView!
    
    var imageData = changeDataForImageView()
    var countImage = 1
    
//MARK: -Actions
    
    @IBAction func actionMaskButton(_ sender: Any) {
        
        if !sharePopoverView.isHidden {
            sharePopoverView.isHidden = true
            self.addAnimationToAnimatableObject(animateView: sharePopoverView, nameAnimation: AnimationType.ZoomIn.rawValue, curveAnimation: AnimationCurveType.EasyInEasyOut.rawValue, damping: 1, duration: 1, force: 1, delay: 0)
            
           showMask(isHidden: true, nameAnimation: AnimationType.CAScaleY.rawValue,alpha:0)
           self.addAnimationToObject(view: dialogView, duration: 1, delay: 0, options: AnimationCurveType.EasyInEasyOut.rawValue,scaleX: 1, scaleY:1)
        }
        self.changeBackgroundImageView()
    }
    
    @IBAction func actionShareButton(_ sender: Any) {
        
        if sharePopoverView.isHidden {
            
            self.addAnimationToAnimatableObject(animateView: shareButton, nameAnimation: AnimationType.CAShakeX.rawValue, curveAnimation: AnimationCurveType.EaseInOutQuint.rawValue, damping: 0.9, duration: 0.5, force: 1, delay: 0)
            
            self.addAnimationToAnimatableObject(animateView: twitterButton, nameAnimation: AnimationType.SlideUp.rawValue, curveAnimation: AnimationCurveType.EaseInOutQuint.rawValue, damping: 0.9, duration: 1, force: 1, delay: 0.4)
            self.addAnimationToAnimatableObject(animateView: faceBookButton, nameAnimation: AnimationType.SlideUp.rawValue, curveAnimation: AnimationCurveType.EaseInOutQuint.rawValue, damping: 0.9, duration: 1, force: 1, delay: 0.5)
            self.addAnimationToAnimatableObject(animateView: twittterLabel, nameAnimation: AnimationType.SlideUp.rawValue, curveAnimation: AnimationCurveType.EaseInOutQuint.rawValue, damping: 0.9, duration: 1, force: 1, delay: 0.6)
            self.addAnimationToAnimatableObject(animateView: faceBookLabel, nameAnimation: AnimationType.SlideUp.rawValue, curveAnimation: AnimationCurveType.EaseInOutQuint.rawValue, damping: 0.9, duration: 1, force: 1, delay: 0.7)

            sharePopoverView.isHidden = false
            self.addAnimationToAnimatableObject(animateView: sharePopoverView, nameAnimation: AnimationType.ZoomIn.rawValue, curveAnimation: AnimationCurveType.EasyInEasyOut.rawValue, damping: 1, duration: 1, force: 1, delay: 0)
            
        showMask(isHidden: false, nameAnimation:AnimationType.CAScaleX.rawValue,alpha: 1)
        self.addAnimationToObject(view: dialogView, duration: 1, delay: 0, options: AnimationCurveType.EasyInEasyOut.rawValue,scaleX: 0.8,scaleY:0.8)
        }
        self.animator.addBehavior(self.snapBehaviorUserView)
        self.animator.removeBehavior(self.userViewItemBehavior)
        self.animator.removeBehavior(self.snapBehaviorDialogView)
        self.refreshCountImage()
}
    
    func addAnimationToAnimatableObject(animateView:Animatable, nameAnimation:AnimationType.RawValue,curveAnimation:AnimationCurveType.RawValue, damping:CGFloat,duration:CGFloat,force:CGFloat,delay:CGFloat) {
        let view = animateView
        view.nameAnimations = nameAnimation
        view.curveAnimations = curveAnimation
        view.damping = damping
        view.duration = duration
        view.shakeX = 7
        view.shakeY = 7
        view.force = force
        view.delay = delay
        view.animateObject()
    }
    func showMask(isHidden:Bool,nameAnimation:String, alpha:CGFloat) {
        maskButton.isHidden = isHidden
        maskButton.nameAnimations = nameAnimation
        maskButton.transformScaleX = 0.7
        maskButton.transformScaleY = 0.7
        maskButton.force = 0
        maskButton.damping = 1
        maskButton.duration = 1
        maskButton.curveAnimations = AnimationCurveType.EaseOutCirc.rawValue
        maskButton.alpha = alpha
        maskButton.animateObject()
    }

    @IBAction func actionDialogViewPanGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        let tempDialogView = dialogView
        let location = sender.location(in: view)
        let boxLocation = sender.location(in: dialogView)

            switch sender.state {
             case UIGestureRecognizerState.began:
                self.animator.removeBehavior(self.snapBehaviorDialogView)
                self.animator.removeBehavior(self.collisionBahavior)
                let centerOffset = UIOffsetMake(boxLocation.x - tempDialogView!.bounds.midX,
                                                boxLocation.y - tempDialogView!.bounds.midY)
                self.attachmentBahavior = UIAttachmentBehavior(item: tempDialogView!,
                                                   offsetFromCenter: centerOffset,
                                                   attachedToAnchor: location)
                self.attachmentBahavior.frequency = 0
                self.attachmentBahavior.length = 25
                self.attachmentBahavior.damping = 0.1
                self.userViewItemBehavior = self.addUserViewItemBehavior(itemsArray:[tempDialogView!,self.userView])
                self.animator.addBehavior(self.snapBehaviorUserView)
                self.animator.addBehavior(self.attachmentBahavior)
                self.animator.addBehavior(self.userViewItemBehavior)
             case UIGestureRecognizerState.changed:
                self.attachmentBahavior.anchorPoint = location
             case UIGestureRecognizerState.ended:
                self.animator.removeBehavior(self.attachmentBahavior)
                self.animator.removeBehavior(self.snapBehaviorUserView)
                self.snapBehaviorDialogView = UISnapBehavior(item: tempDialogView!, snapTo: self.centerDialogView)
                self.collisionBahavior = self.addCollisionBahavior(itemsArray:[tempDialogView!,self.userView])
                self.animator.addBehavior(self.collisionBahavior)
                self.animator.addBehavior(self.snapBehaviorDialogView)
            default:break
        }
    }
//MARK: -UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
//MARK: -Loading
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dialogView.transform = CGAffineTransform(translationX: 50, y: -500).scaledBy(x: 0.5, y: 0.5)
        self.userView.transform = CGAffineTransform(translationX: 50, y: 200).scaledBy(x: 0.5, y: 0.5)
        UIView.animate(withDuration: 2.0, animations: {
        self.dialogView.transform = CGAffineTransform(translationX: 0, y: 0).scaledBy(x: 1, y: 1)
        self.userView.transform = CGAffineTransform(translationX: 0, y: 0).scaledBy(x: 1, y: 1)
        })
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        avatarImageView.layoutIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: view)
        centerDialogView = dialogView.center
        centerUserView = userView.center
        snapBehaviorDialogView = UISnapBehavior(item: dialogView, snapTo: centerDialogView)
        snapBehaviorUserView = UISnapBehavior(item: userView, snapTo: centerUserView)
        collisionBahavior = self.addCollisionBahavior(itemsArray:[userView,dialogView])
        userViewItemBehavior = self.addUserViewItemBehavior(itemsArray:[userView,dialogView])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return.lightContent
    }
    
//MARK: -Helped Methods
    func addCollisionBahavior(itemsArray:Array<UIDynamicItem>) -> UICollisionBehavior {
       let collisionBahavior = UICollisionBehavior(items: itemsArray)
        collisionBahavior.collisionMode = UICollisionBehaviorMode.everything
        collisionBahavior.translatesReferenceBoundsIntoBoundary = true
        collisionBahavior.collisionDelegate = nil
        return collisionBahavior
    }
    func addUserViewItemBehavior(itemsArray:Array<UIDynamicItem>) -> UIDynamicItemBehavior {
        let userViewItemBehavior = UIDynamicItemBehavior(items: itemsArray)
        userViewItemBehavior.elasticity = 0.8
        userViewItemBehavior.angularResistance = 0.5
        userViewItemBehavior.density = 0.5
        userViewItemBehavior.friction = 0.3
        userViewItemBehavior.resistance = 3.0
        return userViewItemBehavior
    }
    func makeBlurEffectToView(view:UIView, effectStule:UIBlurEffectStyle) {
        view.backgroundColor = UIColor.clear
        let blurEffect:UIBlurEffect = UIBlurEffect(style: effectStule)
        let visualEffectView:UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = view.bounds
        view.insertSubview(visualEffectView, at: 0)
        self.visualEffectView = visualEffectView
    }
    
    func addAnimationToObject(view:Animatable, duration:CFTimeInterval, delay:Float, options:AnimationCurveType.RawValue,scaleX:CGFloat,scaleY:CGFloat) {
        let homeView = AnimationObject(view)
        let optionConfig = homeView.animateCurveViewOptions(animationCurve: options)
        UIView.animate(withDuration:duration,
                       delay:TimeInterval(delay),
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: optionConfig,
                       animations: { () -> Void in
                    view.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        }, completion: nil )
    }
    
    func changeBackgroundImageView()  {
        self.view.alpha = 0.5
        
        UIView.animate(withDuration: 1, animations: {
            
            let background = UIImage(named:self.imageData[self.countImage]["image"]!)
            let avatar = UIImage(named:self.imageData[self.countImage]["avatar"]!)
            self.backgroundImageView.image = background
            self.avatarImageView.image = avatar
            
            if self.backgroundImageView.image != UIImage(named:"street") {
                self.topBarImageView.image = nil
                self.bottomBarImageView.image = nil
                self.userButtonImageView.image = nil
                self.removeAllVusualEffectFromView(firstView: self.topBarImageView, secondView: self.bottomBarImageView, thirdView: self.userButtonImageView)
                self.makeBlurEffectToView(view: self.topBarImageView, effectStule: UIBlurEffectStyle.light)
                self.makeBlurEffectToView(view: self.bottomBarImageView, effectStule: UIBlurEffectStyle.light)
                self.makeBlurEffectToView(view: self.userButtonImageView, effectStule: UIBlurEffectStyle.light)
                self.topBarImageView.layer.cornerRadius = 12
                self.bottomBarImageView.layer.cornerRadius = 12
                self.userButtonImageView.layer.cornerRadius = 30
        
            }else {
                self.topBarImageView.image = UIImage(named:"top board Home")
                self.bottomBarImageView.image = UIImage(named:"bottom board Home")
                self.userButtonImageView.image = UIImage(named:"Button Home")
                self.removeAllVusualEffectFromView(firstView: self.topBarImageView, secondView: self.bottomBarImageView, thirdView: self.userButtonImageView)
            }
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.view.alpha = 1
        })
        self.countImage += 1
    }
    func removeAllVusualEffectFromView(firstView:UIView,secondView:UIView, thirdView:UIView)  {
        var viewsArray = [UIView]()
        viewsArray = firstView.subviews + secondView.subviews + thirdView.subviews
        for subview in viewsArray {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }

    func refreshCountImage() {
        if self.countImage > 2 {
            self.countImage = 0
        }
    }
}

