//
//  AugmentedButton.swift
//  Prime
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

public
class AugmentedButton: UIButton {
    public
    typealias Actions = (AugmentedButton) -> Void
    
    public
    func setActions(_ block: @escaping Actions, named name: String? = nil, forState state: UIControlState) {
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
    
    public
    func clearActions(forState state: UIControlState) {
        update(to: .normal)
        stateBlocks.removeValue(forKey: state)
        update(to: self.state)
    }
    
    public
    func clearAllActions() {
        update(to: .normal)
        stateBlocks.removeAll()
        update(to: self.state)
    }
    
    fileprivate
    var stateBlocks: [UIControlState: [String:[Actions]]] = [:]
    
    public
    func setValue(_ value: AnyObject?, forKey key: String, forState state: UIControlState) throws {
        guard responds(to: Selector(key)) else {
            throw AugmentedButtonError.undefinedKey
        }
        
        guard !super.responds(to: Selector("set\(key.capitalized):forState:")) else {
            throw AugmentedButtonError.keyManagedInSuper
        }
        
        let actions: Actions = { button in
            button.setValue(value, forKey: key)
        }
        
        setActions(actions, named: key, forState: state)
    }
    
    public
    func valueForKey(_ key: String, forState state: UIControlState) throws -> AnyObject? {
        guard responds(to: Selector(key)) else {
            throw AugmentedButtonError.undefinedKey
        }
        
        guard let block: Actions = stateBlocks[state]?[key]?.first else { return nil }
        
        let b = AugmentedButton(type: .custom)
        
        block(b)
        
        return b.value(forKey: key) as AnyObject?
    }
    
    public
    func currentValueForKey(_ key: String) throws -> AnyObject? {
        return try valueForKey(key, forState: state)
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
    func update(to state: UIControlState) {
        guard let blocks = stateBlocks[state] else { return }
        
        blocks.forEach { $1.forEach { $0(self) } }
    }
}
