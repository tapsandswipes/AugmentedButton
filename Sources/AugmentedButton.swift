//
//  AugmentedButton.swift
//  AugmentedButton
//
//  Created by Antonio Cabezuelo Vivo on 11/8/16.
//  Copyright © 2016 Antonio Cabezuelo Vivo. All rights reserved.
//

import UIKit

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
    func setValue<Value>(_ value: Value, forKeyPath keyPath: ReferenceWritableKeyPath<AugmentedButton, Value>, for state: UIControl.State) {
        let actions: Actions = { button in
            button[keyPath: keyPath] = value
        }

        setActions(actions, named: keyPath.ab_stateBlockKey, for: state)
        
        // Set value for .normal state if none exist.
        if state != .normal && self.state == .normal {
            guard actionsForKeyPath(keyPath, for: .normal) == nil else { return }
            
            setValue(self[keyPath: keyPath], forKeyPath: keyPath, for: .normal)
        }

    }
    
    open
    func valueForKeyPath<Value>(_ keyPath: KeyPath<AugmentedButton, Value>, for state: UIControl.State) -> Value? {
        guard let block: Actions = actionsForKeyPath(keyPath, for: state) else { return nil }
        
        let b = AugmentedButton(type: .custom)
        
        block(b)
        
        return b[keyPath: keyPath]
    }

    open
    func currentValueForKeyPath<Value>(_ keyPath: KeyPath<AugmentedButton, Value>) -> Value {
        return valueForKeyPath(keyPath, for: state) ?? valueForKeyPath(keyPath, for: .normal) ?? self[keyPath: keyPath]
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

    func actionsForKeyPath<Value>(_ keyPath: KeyPath<AugmentedButton, Value>, for state: UIControl.State) -> Actions? {
        return stateBlocks[state]?[keyPath.ab_stateBlockKey]?.first
    }
    
    func update(to state: UIControl.State) {
        guard let blocks = stateBlocks[state] else { return }
        
        blocks.forEach { $1.forEach { $0(self) } }
    }
}


private
extension KeyPath {
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
