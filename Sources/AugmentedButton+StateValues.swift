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
    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        setValue(color, forKeyPath: \.backgroundColor, for: state)
    }
    
    open
    func setTintColor(_ color: UIColor?, for state: UIControl.State) {
        setValue(color, forKeyPath: \.tintColor, for: state)
    }
    
    open
    func setBorderColor(_ color: UIColor?, for state: UIControl.State) {
        setValue(color, forKeyPath: \.borderColor, for: state)
    }
    
    open
    func setBorderWidth(_ width: CGFloat, for state: UIControl.State) {
        setValue(width, forKeyPath: \.borderWidth, for: state)
    }
    
    open
    func setCornerRadius(_ radius: CGFloat, for state: UIControl.State) {
        setValue(radius, forKeyPath: \.cornerRadius, for: state)
    }
    
    open
    func backgroundColor(for state: UIControl.State) -> UIColor? {
        return valueForKeyPath(\.backgroundColor, for: state)?.map( { $0 })
    }
    
    open
    func tintColor(for state: UIControl.State) -> UIColor? {
        return valueForKeyPath(\.tintColor, for: state)?.map( { $0 })
    }
    
    open
    func borderColor(for state: UIControl.State) -> UIColor? {
        return valueForKeyPath(\.borderColor, for: state)?.map( { $0 })
    }
    
    open
    func borderWidth(for state: UIControl.State) -> CGFloat {
        return valueForKeyPath(\.borderWidth, for: state) ?? 0
    }
    
    open
    func cornerRadius(for state: UIControl.State) -> CGFloat {
        return valueForKeyPath(\.cornerRadius, for: state) ?? 0
    }
    
    open
    func currentBackgroundColor() -> UIColor? {
        return currentValueForKeyPath(\.backgroundColor)
    }
    
    open
    func currentTintColor() -> UIColor? {
        return currentValueForKeyPath(\.tintColor)
    }
    
    open
    func currentBorderColor() -> UIColor? {
        return currentValueForKeyPath(\.borderColor)
    }
    
    open
    func currentBorderWidth() -> CGFloat {
        return currentValueForKeyPath(\.borderWidth)
    }

    open
    func currentCornerRadius() -> CGFloat {
        return currentValueForKeyPath(\.cornerRadius)
    }
    
}

