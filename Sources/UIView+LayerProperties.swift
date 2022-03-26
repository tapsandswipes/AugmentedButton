
//
//  UIView+Utils.swift
//  AugmentedButton
//
//  Created by Antonio Cabezuelo Vivo on 4/8/16.
//  Copyright © 2016 Antonio Cabezuelo Vivo. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable open
    var borderColor: UIColor? {
        set { layer.borderColor = newValue?.cgColor }
        get { layer.borderColor.map(UIColor.init) }
    }

    @IBInspectable open
    var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { layer.borderWidth }
    }

    @IBInspectable open
    var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius }
    }

}
