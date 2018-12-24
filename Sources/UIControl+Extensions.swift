//
//  UIControl+Extensions.swift
//  AugmentedButton
//
//  Created by Antonio Cabezuelo Vivo on 13/8/16.
//  Copyright © 2016 Antonio Cabezuelo Vivo. All rights reserved.
//

import UIKit

extension UIControl.State: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
