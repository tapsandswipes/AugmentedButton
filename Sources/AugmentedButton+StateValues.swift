//
//  AugmentedButton+CustomValues.swift
//  AugmentedButton
//
//  Created by Antonio Cabezuelo Vivo on 14/8/16.
//  Copyright © 2016 Antonio Cabezuelo Vivo. All rights reserved.
//

import UIKit


extension AugmentedButton {
    
    open
    func setBackgroundColor(_ color: UIColor?, for state: UIControlState) {
        try! setValue(color, forKey: "backgroundColor", for: state)
    }
    
    open
    func setTintColor(_ color: UIColor?, for state: UIControlState) {
        try! setValue(color, forKey: "tintColor", for: state)
    }
    
    open
    func setBorderColor(_ color: UIColor?, for state: UIControlState) {
        try! setValue(color, forKey: "borderColor", for: state)
    }
    
    open
    func setBorderWidth(_ width: CGFloat, for state: UIControlState) {
        try! setValue(width, forKey: "borderWidth", for: state)
    }
    
    open
    func setCornerRadius(_ radius: CGFloat, for state: UIControlState) {
        try! setValue(radius, forKey: "cornerRadius", for: state)
    }
    
    open
    func backgroundColor(for state: UIControlState) -> UIColor? {
        return try! valueForKey("backgroundColor", for: state) as? UIColor
    }
    
    open
    func tintColor(for state: UIControlState) -> UIColor? {
        return try! valueForKey("tintColor", for: state) as? UIColor
    }
    
    open
    func borderColor(for state: UIControlState) -> UIColor? {
        return try! valueForKey("borderColor", for: state) as? UIColor
    }
    
    open
    func borderWidth(for state: UIControlState) -> CGFloat {
        return (try! valueForKey("borderWidth", for: state) as? CGFloat) ?? 0
    }
    
    open
    func cornerRadius(for state: UIControlState) -> CGFloat {
        return (try! valueForKey("cornerRadius", for: state) as? CGFloat) ?? 0
    }
    
    open
    func currentBackgroundColor() -> UIColor? {
        return try! currentValueForKey("backgroundColor") as? UIColor
    }
    
    open
    func currentTintColor() -> UIColor? {
        return try! currentValueForKey("tintColor") as? UIColor
    }
    
    open
    func currentBorderColor() -> UIColor? {
        return try! currentValueForKey("borderColor") as? UIColor
    }
    
    open
    func currentBorderWidth() -> CGFloat {
        return (try! currentValueForKey("borderWidth") as? CGFloat) ?? 0
    }

    open
    func currentCornerRadius() -> CGFloat {
        return (try! currentValueForKey("cornerRadius") as? CGFloat) ?? 0
    }
    
}

