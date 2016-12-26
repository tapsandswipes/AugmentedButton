//
//  ViewController.swift
//  AugmentedButtonExample
//
//  Created by Antonio Cabezuelo Vivo on 26/12/16.
//  Copyright © 2016 Antonio Cabezuelo Vivo. All rights reserved.
//

import UIKit
import AugmentedButton

class ViewController: UIViewController {

    @IBOutlet weak var button: AugmentedButton!
    @IBOutlet weak var button2: AugmentedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.borderWidth = 2
        
        button.setBorderColor(.green, forState: .normal)
        button.setCornerRadius(5, forState: .normal)
        button.setBorderColor(.red, forState: .highlighted)
        button.setCornerRadius(22, forState: .highlighted)
        button.setBorderWidth(4, forState: .highlighted)
        
        button2.setActions({ b in
            b.backgroundColor = UIColor(white: 0, alpha: 0.2)
            b.tintColor = .green
        }, forState: .normal)

        button2.setActions({ b in
            b.backgroundColor = UIColor(white: 0, alpha: 0.6)
            b.tintColor = .red
        }, forState: .highlighted)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

