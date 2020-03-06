//
//  StateObservableButton.swift
//  AugmentedButton
//
//  Created by Antonio Cabezuelo Vivo on 12/03/2019.
//  Copyright © 2019 Antonio Cabezuelo Vivo. All rights reserved.
//

import UIKit

public
extension UIControl.Event {
    static let stateChanged: UIControl.Event = UIControl.Event.nextAvailableAppEvent()
}

open
class StateObservableButton: UIButton {
    
    /// Prior state is used to compare the state before
    /// and after calls that are likely to change the
    /// state. It is an ivar rather than a local in each
    /// method so that if one of the methods calls another,
    /// the state-changed actions only get called once.
    private
    var priorState: UIControl.State = .normal
    
    override open var isEnabled: Bool {
        willSet {
            priorState = state
        }
        didSet {
            checkStateChangedAndSendActions()
        }
    }
    
    override open var isSelected: Bool {
        willSet {
            priorState = state
        }
        didSet {
            checkStateChangedAndSendActions()
        }
    }
    
    override open var isHighlighted: Bool {
        willSet {
            priorState = state
        }
        didSet {
            checkStateChangedAndSendActions()
        }
    }
    
    private
    func checkStateChangedAndSendActions() {
        guard priorState != state else {
            return
        }
        
        priorState = state
        sendActions(for: .stateChanged)
    }
}
