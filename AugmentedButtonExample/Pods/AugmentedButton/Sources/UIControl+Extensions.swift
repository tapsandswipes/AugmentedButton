//
//  UIControl+Extensions.swift
//  Prime
//
//  Created by Antonio Cabezuelo Vivo on 13/8/16.
//  Copyright © 2016 Antonio Cabezuelo Vivo. All rights reserved.
//

import UIKit

extension UIControlState: Hashable {
    public
    var hashValue: Int {
        return Int(rawValue)
    }
}
