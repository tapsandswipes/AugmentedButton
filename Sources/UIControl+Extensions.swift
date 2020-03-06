//
//  UIControl+Extensions.swift
//  AugmentedButton
//
//  Created by Antonio Cabezuelo Vivo on 13/8/16.
//  Copyright © 2016 Antonio Cabezuelo Vivo. All rights reserved.
//

import UIKit

public
extension UIControl.Event {

    static let firstAvailableAppEventValue: UInt = (~(UIControl.Event.systemReserved.rawValue | UIControl.Event.applicationReserved.rawValue) + 1) & UIControl.Event.applicationReserved.rawValue
    

    static func appEvent(at position: UInt) -> UIControl.Event {
        let value = (firstAvailableAppEventValue << position) & UIControl.Event.applicationReserved.rawValue
        
        guard value != 0 else { fatalError("App event not available at position \(position)") }
        
        return UIControl.Event(rawValue: value)
    }
    
    private
    static var lastUsedPosition: UInt?
    
    static func nextAvailableAppEvent() -> UIControl.Event {
        if let p = lastUsedPosition {
            lastUsedPosition = p + 1
        } else {
            lastUsedPosition = 0
        }
        
        return appEvent(at: lastUsedPosition ?? 0)
    }

}

public
extension UIControl.State {

    static let firstAvailableAppStateValue: UInt = (~(UIControl.State.reserved.rawValue | UIControl.State.application.rawValue) + 1) & UIControl.State.application.rawValue
    

    static func appState(at position: UInt) -> UIControl.State? {
        let value = (firstAvailableAppStateValue << position) & UIControl.State.application.rawValue
        
        guard value != 0 else { return nil }
        
        return UIControl.State(rawValue: value)
    }
    
    private
    static var lastUsedPosition: UInt?
    
    static func nextAvailableAppState() -> UIControl.State? {
        if let p = lastUsedPosition {
            lastUsedPosition = p + 1
        } else {
            lastUsedPosition = 0
        }

        return lastUsedPosition.flatMap(appState(at:))
    }
}

extension UIControl.State: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
