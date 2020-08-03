//
//  ButtonsAnimations.swift
//  GoodBiology
//
//  Created by Yaroslav on 11/23/18.
//  Copyright © 2018 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

//MARK: Setup UIButton pulsate animations
public extension UIButton {
    func pulsate(duration: Float) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration             = CFTimeInterval(duration)
        pulse.fromValue            = 0.95
        pulse.toValue              = 0.97
        pulse.autoreverses         = true
        pulse.repeatCount          = 1
        pulse.initialVelocity      = 0.6
        pulse.damping              = 0.1
        
        layer.add(pulse, forKey: nil)
        
        //MARK: Animation for articels buttons
    }
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        
        pulse.duration             = 0.3
        pulse.fromValue            = 0.95
        pulse.toValue              = 1.0
        pulse.autoreverses         = true
        pulse.repeatCount          = 2
        pulse.initialVelocity      = 0.6
        pulse.damping              = 1.0
        
        layer.add(pulse, forKey: nil)
        
        //MARK: Animation for articels buttons
    }
}



//MARK: Pulsing animation for notificationButtons
class Pulsing: CALayer {

    //MARK: CAAnimationGroup
    var animationGroup = CAAnimationGroup()
    
    
    //MARK: Properties
    var initialPulseScale: Float = 0
    var nextPulseAfter: TimeInterval = 0
    var animationDuration: TimeInterval = 1.5
    var radius: CGFloat = 200
    var numberOfPulses: Float = Float.infinity
    
    
    //MARK: Overrides
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    
    //MARK: Inits
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init (numberOfPulses: Float = Float.infinity, radius: CGFloat, position: CGPoint) {
        super.init()
        
        self.backgroundColor = UIColor.black.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.position = position
        self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        self.cornerRadius = radius
        
        ///Start Animation
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.setupAnimationGroup()
            
            DispatchQueue.main.async {
                 self.add(self.animationGroup, forKey: "pulse")
            }
            self.radius = radius
            self.numberOfPulses = numberOfPulses
        }
        
        ///Clear Animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            ///Setup clear animation
            self.animationDuration = 0
            self.radius = 0
            
            self.backgroundColor = UIColor.clear.cgColor
            
            ///Return from finction
            return
        }
    }
}



//MARK: Main Methods
extension Pulsing {
    private func createScaleAnimation () -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: initialPulseScale)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = animationDuration
        
        return scaleAnimation
    }
    
    private func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [0.4, 0.8, 0]
        opacityAnimation.keyTimes = [0, 0.2, 1]
        
        return opacityAnimation
    }
    
    private func setupAnimationGroup() {
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = animationDuration + nextPulseAfter
        self.animationGroup.repeatCount = numberOfPulses
        
        let defaultCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        self.animationGroup.timingFunction = defaultCurve
        
        self.animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
    }
}
