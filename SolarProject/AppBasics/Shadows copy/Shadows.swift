//
//  Shadows.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 12/22/18.
//  Copyright © 2018 Yaroslav. All rights reserved.
//

import UIKit
import WebKit

//MARK: - UISlider
extension UISlider {
    public func sliderShadow() {
        layer.shadowOpacity = 0.7
        layer.shadowColor   = BasicProperties.color.cgColor
        layer.shadowRadius  = 4
        layer.shadowOffset  = CGSize(width: 0, height: 0)
    }
}



//MARK: - UIActivityIndicatorView
extension UIActivityIndicatorView {
    public func activityIndicatorViewShadow() {
        layer.shadowOpacity = 0.8
        layer.shadowColor   = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.shadowRadius  = 11
        layer.shadowOffset  = CGSize(width: 0, height: 0)
    }
}



//MARK: - UIButton
extension UIButton {
    public func buttonsShadows() {
        layer.shadowOpacity = 1
        layer.shadowColor  = BasicProperties.color.cgColor
        layer.shadowRadius = 3.5
        layer.shadowOffset  = CGSize(width: 0, height: 0.5)
    }
    
    public func testButtonsShadows() {
        layer.shadowOpacity = 3
        layer.shadowColor   = BasicProperties.color.cgColor
        layer.shadowRadius  = 2.2
        layer.shadowOffset  = CGSize(width: 0, height: 0)
    }
    
    public func testFalseButtonsShadows() {
        layer.shadowOpacity = 3
        layer.shadowColor   = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        layer.shadowRadius  = 4
        layer.shadowOffset  = CGSize(width: 0, height: 0)
    }
}



//MARK: - UIView
extension UIView {
    public func viewShadows() {
        addNeomorphicOneSideShadowColor()
    }
}



//MARK: UIView Neomorphic shadows setup
public extension UIView {
    func addSoftUIEffectForView(cornerRadius: CGFloat = 15.0, themeColor: UIColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize( width: 2, height: 2)
        self.layer.shadowColor = UIColor(red: 223/255, green: 228/255, blue: 238/255, alpha: 1.0).cgColor
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds
        shadowLayer.shadowColor = UIColor.white.cgColor
        shadowLayer.cornerRadius = cornerRadius
        shadowLayer.shadowOffset = CGSize(width: -2.0, height: -2.0)
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 8
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func addNeomorphicOneSideShadowColor() {
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0.45)
        self.layer.shadowColor = UIColor(red: 223/255, green: 228/255, blue: 238/255, alpha: 0.5).cgColor
    }
}



//MARK: - UIButton neomorphic shadows setup
extension UIButton {
    
    //MARK: Overrides
    override open var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                 setState()
            } else {
                 resetState()
            }
        }
    }
    
    override open var isEnabled: Bool {
        didSet{
            if isEnabled == false {
                setState()
            } else {
                resetState()
            }
        }
    }
    
    //MARK: Public
    public func setState(){
        self.layer.shadowOffset = CGSize(width: -2, height: -2)
        self.layer.sublayers?[0].shadowOffset = CGSize(width: 2, height: 2)
        self.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 0)
    }
    
    public func resetState(){
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.sublayers?[0].shadowOffset = CGSize(width: -2, height: -2)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 2)
    }
    
    public func addSoftUIEffectForButton(cornerRadius: CGFloat = 15.0, themeColor: UIColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)) {
        
        ///Setup first shadow
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize( width: 2, height: 2)
        self.layer.shadowColor = UIColor(red: 223/255, green: 228/255, blue: 238/255, alpha: 1.0).cgColor
        
        ///Setup second shadow
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds
        shadowLayer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        shadowLayer.cornerRadius = cornerRadius
        shadowLayer.shadowOffset = CGSize(width: -3.0, height: -3.0)
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 6
        self.layer.insertSublayer(shadowLayer, below: self.imageView?.layer)
    }
}




//MARK: - WKWebView
extension WKWebView {
    public func webViewShadow() {
        layer.shadowOpacity = 0.8
        layer.shadowColor   = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.shadowRadius  = 5
        layer.shadowOffset  = CGSize(width: 0, height: 0)
    }
}



//MARK: - UIPickerView
extension UIPickerView {
    public func pickerViewShadow() {
        layer.shadowOpacity = 0.5
        layer.shadowColor   = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.shadowRadius  = 3
        layer.shadowOffset  = CGSize(width: 0, height: 0)
    }
}



//MARK: - UIDatePicker
extension UIDatePicker {
    public func datePickerShadow() {
        layer.shadowOpacity = 0.5
        layer.shadowColor   = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.shadowRadius  = 3
        layer.shadowOffset  = CGSize(width: 0, height: 0)
    }
}



//MARK: - UISegmentedControl
extension UISegmentedControl {
    public func segmentedControlShadow() {
        layer.shadowOpacity = 0.5
        layer.shadowColor   = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.shadowRadius  = 3
        layer.shadowOffset  = CGSize(width: 0, height: 0)
    }
}



//MARK: - UIStepper
extension UIStepper {
    public func stepperShadow() {
        layer.shadowOpacity = 0.9
        layer.shadowColor   = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.shadowRadius  = 4
        layer.shadowOffset  = CGSize(width: 0, height: 0)
    }
}



//MARK: - UISwitch
extension UISwitch {
    public func switchShadow() {
        layer.shadowOpacity = 0.7
        layer.shadowColor   = UIColor.orange.cgColor
        layer.shadowRadius  = 4
        layer.shadowOffset  = CGSize(width: 0, height: 0)
    }
}



//MARK: - UITextView
extension UITextView {
    public func textViewShadow() {
        layer.shadowOpacity = 0.7
        layer.shadowColor   = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.shadowRadius  = 9
        layer.shadowOffset  = CGSize(width: 0, height: 0)
    }
}



//MARK: - UIImageView
extension UIImageView {
    public func imageViewShadow() {
        layer.shadowOpacity = 0.5
        layer.shadowColor   = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.shadowRadius  = 9
        layer.shadowOffset  = CGSize(width: 0, height: 0)
    }
}



//MARK: - UILabel
extension UILabel {
    public func labelShadow() {
        layer.shadowOpacity = 0.5
        layer.shadowColor   = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.shadowRadius  = 6
        layer.shadowOffset  = CGSize(width: 0, height: 0)
    }
}
