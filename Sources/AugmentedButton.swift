//
//  AugmentedButton.swift
//  AugmentedButton
//
//  Created by Antonio Cabezuelo Vivo on 11/8/16.
//  Copyright © 2016 Antonio Cabezuelo Vivo. All rights reserved.
//

import UIKit

public
extension UIControl.Event {
    static let longPress: UIControl.Event = UIControl.Event.nextAvailableAppEvent()
}

public
enum AugmentedButtonError: Error {
    case undefinedKey
    case keyManagedInSuper
}

open
class AugmentedButton: StateObservableButton {
    public
    typealias Actions = (AugmentedButton) -> Void
    
    open
    func setActions(_ block: @escaping Actions, named name: String? = nil, for state: UIControl.State) {
        var blockGroup: [String:[Actions]] = stateBlocks[state] ?? [:]
        var blocks: [Actions]
        
        if name == nil {
            blocks = blockGroup[""] ?? []
        } else {
            blocks = []
        }
        
        blocks.append(block)
        blockGroup[name ?? ""] = blocks
        
        stateBlocks[state] = blockGroup
        
        if self.state == state {
            block(self)
        }
    }
    
    open
    func clearActions(for state: UIControl.State) {
        update(to: .normal)
        stateBlocks.removeValue(forKey: state)
        update(to: self.state)
    }
    
    open
    func clearAllActions() {
        update(to: .normal)
        stateBlocks.removeAll()
        update(to: self.state)
    }
    
    private
    var stateBlocks: [UIControl.State: [String: [Actions]]] = [:]
        
    open
    func setValue<Root: AugmentedButton, Value>(_ value: Value, forKeyPath keyPath: ReferenceWritableKeyPath<Root, Value>, for state: UIControl.State) {
        precondition(self is Root, "keyPath must be relative to Self")
        
        let actions: Actions = { b in
            guard let button = b as? Root else { return }
            button[keyPath: keyPath] = value
        }
        
        setActions(actions, named: keyPath.ab_stateBlockKey, for: state)
        
        // Set value for .normal state if none exist.
        if state != .normal && self.state == .normal {
            guard
                let button = self as? Root,
                actionsForKeyPath(keyPath, for: .normal) == nil
            else { return }
            
            setValue(button[keyPath: keyPath], forKeyPath: keyPath, for: .normal)
        }

    }
    
    open
    func valueForKeyPath<Root: AugmentedButton, Value>(_ keyPath: KeyPath<Root, Value>, for state: UIControl.State) -> Value? {
        precondition(self is Root, "keyPath must be relative to Self")

        guard let block: Actions = actionsForKeyPath(keyPath, for: state) else { return nil }
        
        let b = Root(type: .custom)
        
        block(b)
        
        return b[keyPath: keyPath]
    }

    open
    func currentValueForKeyPath<Root: AugmentedButton, Value>(_ keyPath: KeyPath<Root, Value>) -> Value {
        precondition(self is Root, "keyPath must be relative to Self")

        return valueForKeyPath(keyPath, for: state) ?? valueForKeyPath(keyPath, for: .normal) ?? (self as! Root)[keyPath: keyPath]
    }

    open
    override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        super.addTarget(target, action: action, for: controlEvents)
        
        // Only install long press gesture recognizer if listening for .longPress events
        if controlEvents.contains(.longPress) {
            // If already has a long press gesture recognizer configure it
            if let g = gestureRecognizers?.first(where: { $0 is UILongPressGestureRecognizer }) as? UILongPressGestureRecognizer {
                g.removeTarget(self, action: #selector(didLongPress(_:)))
                g.addTarget(self, action: #selector(didLongPress(_:)))
                g.minimumPressDuration = longPressMinimumPressDuration
            } else {
                addGestureRecognizer(_longPressGesture)
                _longPressGesture.minimumPressDuration = longPressMinimumPressDuration
            }
        }
    }
    
    open override func removeTarget(_ target: Any?, action: Selector?, for controlEvents: UIControl.Event) {
        super.removeTarget(target, action: action, for: controlEvents)
        
        if !allControlEvents.contains(.longPress) {
            removeGestureRecognizer(_longPressGesture)
        }
    }
    
    public var longPressMinimumPressDuration: TimeInterval = 0.5 {
        didSet {
            _longPressGesture.minimumPressDuration = longPressMinimumPressDuration
        }
    }
    
    public var longPressGesture: UILongPressGestureRecognizer? {
        guard allControlEvents.contains(.longPress) else { return nil }

        return _longPressGesture
    }
    
    private lazy var _longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
    
    
    @IBAction private
    func didLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            sendActions(for: .longPress)
        }
    }
    
}

// MARK: Overrides
extension AugmentedButton {
    override open var isSelected: Bool {
        didSet {
            if oldValue != isSelected {
                update(to: state)
            }
        }
    }
    override open var isHighlighted: Bool {
        didSet {
            if oldValue != isHighlighted {
                update(to: state)
            }
        }
    }
    
    override open var isEnabled: Bool {
        didSet {
            if oldValue != isEnabled {
                update(to: state)
            }
        }
    }
}

private
extension AugmentedButton {

    func actionsForKeyPath<Root: AugmentedButton, Value>(_ keyPath: KeyPath<Root, Value>, for state: UIControl.State) -> Actions? {
        return stateBlocks[state]?[keyPath.ab_stateBlockKey]?.first
    }
    
    func update(to state: UIControl.State) {
        guard let blocks = stateBlocks[state] else { return }
        
        blocks.forEach { $1.forEach { $0(self) } }
    }
}


private
extension KeyPath where Root: AugmentedButton {
    var ab_stateBlockKey: String {
        return NSExpression(forKeyPath: self).keyPath
    }
}

// #############################################
// MARK: - Deprecated methods
// #############################################
extension AugmentedButton {
    @available(*, deprecated, message: "Use setValue(_,forKeyPath:,for:) instead")
    open
    func setValue(_ value: Any?, forKey key: String, for state: UIControl.State) throws {
        guard responds(to: Selector(key)) else {
            throw AugmentedButtonError.undefinedKey
        }
        
        guard !super.responds(to: Selector("set\(key.capitalized):forState:")) else {
            throw AugmentedButtonError.keyManagedInSuper
        }
        
        let actions: Actions = { button in
            button.setValue(value, forKey: key)
        }
        
        setActions(actions, named: key, for: state)
        
        // Set value for .normal state if none exist.
        if state != .normal && self.state == .normal {
            guard try valueForKey(key, for: .normal) == nil else { return }
            
            if let normalValue = self.value(forKey: key) {
                try setValue(normalValue, forKey: key, for: .normal)
            }
        }
    }
    
    @available(*, deprecated, message: "Use valueForKeyPath(_,for:) instead")
    open
    func valueForKey(_ key: String, for state: UIControl.State) throws -> Any? {
        guard responds(to: Selector(key)) else {
            throw AugmentedButtonError.undefinedKey
        }
        
        guard let block: Actions = stateBlocks[state]?[key]?.first else { return nil }
        
        let b = AugmentedButton(type: .custom)
        
        block(b)
        
        return b.value(forKey: key) as Any?
    }
    
    @available(*, deprecated, message: "Use currentValueForKeyPath(_) instead")
    open
    func currentValueForKey(_ key: String) throws -> Any? {
        return try valueForKey(key, for: state)
    }

}
