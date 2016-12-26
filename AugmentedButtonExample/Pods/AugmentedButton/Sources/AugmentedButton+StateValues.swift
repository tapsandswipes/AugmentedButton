//
//  AugmentedButton+CustomValues.swift
//  Prime
//
//  Created by Antonio Cabezuelo Vivo on 14/8/16.
//  Copyright © 2016 Antonio Cabezuelo Vivo. All rights reserved.
//

import UIKit


extension AugmentedButton {
    
    public
    func setBackgroundColor(_ color: UIColor?, forState state: UIControlState) {
        try! setValue(color, forKey: "backgroundColor", forState: state)
    }
    
    public
    func setTintColor(_ color: UIColor?, forState state: UIControlState) {
        try! setValue(color, forKey: "tintColor", forState: state)
    }
    
    public
    func setBorderColor(_ color: UIColor?, forState state: UIControlState) {
        setActions( { $0.borderColor = color }, named: "borderColor", forState: state)
    }
    
    public
    func setBorderWidth(_ width: CGFloat, forState state: UIControlState) {
        setActions( { $0.borderWidth = width }, named: "borderWidth", forState: state)
    }
    
    public
    func setCornerRadius(_ radius: CGFloat, forState state: UIControlState) {
        setActions( { $0.cornerRadius = radius }, named: "cornerRadius", forState: state)
    }
    
    public
    func backgroundColorForState(_ state: UIControlState) -> UIColor? {
        return try! valueForKey("backgroundColor", forState: state) as? UIColor
    }
    
    public
    func tintColorForState(_ state: UIControlState) -> UIColor? {
        return try! valueForKey("tintColor", forState: state) as? UIColor
    }
    
    public
    func borderColorForState(_ state: UIControlState) -> UIColor? {
        return try! valueForKey("borderColor", forState: state) as? UIColor
    }
    
    public
    func borderWidthForState(_ state: UIControlState) -> CGFloat {
        return (try! valueForKey("borderWidth", forState: state) as? CGFloat) ?? 0
    }
    
    public
    func cornerRadiusForState(_ state: UIControlState) -> CGFloat {
        return (try! valueForKey("cornerRadius", forState: state) as? CGFloat) ?? 0
    }
    
    public
    func currentBackgroundColor() -> UIColor? {
        return try! currentValueForKey("backgroundColor") as? UIColor
    }
    
    public
    func currentTintColor() -> UIColor? {
        return try! currentValueForKey("tintColor") as? UIColor
    }
    
    public
    func currentBorderColor() -> UIColor? {
        return try! currentValueForKey("borderColor") as? UIColor
    }
    
    public
    func currentBorderWidth() -> CGFloat {
        return (try! currentValueForKey("borderWidth") as? CGFloat) ?? 0
    }

    public
    func currentCornerRadius() -> CGFloat {
        return (try! currentValueForKey("cornerRadius") as? CGFloat) ?? 0
    }
    
}

