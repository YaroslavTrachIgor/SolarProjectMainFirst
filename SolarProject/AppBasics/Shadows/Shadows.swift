//
//  Shadows.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 12/22/18.
//  Copyright © 2018 Yaroslav. All rights reserved.
//

import UIKit
import WebKit

//MARK: - ShadowSetupProtocol protocol
protocol ShadowSetupProtocol {
    func viewShadows(opacity: Float, color: CGColor, radius: CGFloat, offset: CGSize)
    func viewShadows()
}



//MARK: - UIView
extension UIView: ShadowSetupProtocol {
    
    //MARK: ShadowSetupProtocol func
    public func viewShadows(opacity: Float, color: CGColor, radius: CGFloat, offset: CGSize) {
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowColor = color
    }
    
    public func viewShadows() {
        viewShadows(opacity: 1, color: UIColor(red: 223/255, green: 228/255, blue: 238/255, alpha: 0.5).cgColor, radius: 8, offset: CGSize(width: 0, height: 0.45))
    }
}



//MARK: - UISlider
extension UISlider {
    public func sliderShadow() {
        viewShadows(opacity: 0.7, color: BasicProperties.color.cgColor, radius: 4, offset: CGSize.zero)
    }
}



//MARK: - UIActivityIndicatorView
extension UIActivityIndicatorView {
    public func activityIndicatorViewShadow() {
        viewShadows(opacity: 0.8, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), radius: 11, offset: CGSize.zero)
    }
}



//MARK: - UIButton
extension UIButton {
    public func buttonsShadows() {
        viewShadows(opacity: 1, color: BasicProperties.color.cgColor, radius: 3.5, offset: CGSize(width: 0, height: 0.5))
    }
    
    public func testButtonsShadows() {
        viewShadows(opacity: 3, color: BasicProperties.color.cgColor, radius: 2.2, offset: CGSize.zero)
    }
    
    public func testFalseButtonsShadows() {
        viewShadows(opacity: 3, color: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), radius: 4, offset: CGSize.zero)
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
        viewShadows(opacity: 0.8, color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), radius: 5, offset: CGSize.zero)
    }
}



//MARK: - UIPickerView
extension UIPickerView {
    public func pickerViewShadow() {
        viewShadows(opacity: 0.5, color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), radius: 3, offset: CGSize.zero)
    }
}



//MARK: - UIDatePicker
extension UIDatePicker {
    public func datePickerShadow() {
        viewShadows(opacity: 0.5, color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), radius: 3, offset: CGSize.zero)
    }
}



//MARK: - UISegmentedControl
extension UISegmentedControl {
    public func segmentedControlShadow() {
        viewShadows(opacity: 0.5, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), radius: 3, offset: CGSize.zero)
    }
}



//MARK: - UIStepper
extension UIStepper {
    public func stepperShadow() {
        viewShadows(opacity: 0.9, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), radius: 4, offset: CGSize.zero)
    }
}



//MARK: - UISwitch
extension UISwitch {
    public func switchShadow() {
        viewShadows(opacity: 0.7, color: BasicProperties.color.cgColor, radius: 4, offset: CGSize.zero)
    }
}



//MARK: - UITextView
extension UITextView {
    public func textViewShadow() {
        viewShadows(opacity: 0.7, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), radius: 9, offset: CGSize.zero)
    }
}



//MARK: - UIImageView
extension UIImageView {
    public func imageViewShadow() {
        viewShadows(opacity: 0.5, color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), radius: 9, offset: CGSize.zero)
    }
}



//MARK: - UILabel
extension UILabel {
    public func labelShadow() {
        viewShadows(opacity: 0.5, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), radius: 6, offset: CGSize.zero)
    }
}
