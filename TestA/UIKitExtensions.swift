//
//  UIKitExtensions.swift
//  TestA
//
//  Created by Tancrède on 9/16/16.
//  Copyright © 2016 William Vasconcelos. All rights reserved.
//
import UIKit



// Draw round corner to UIViews

extension UIView{
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
}


