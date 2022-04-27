//
//  KeyboardNumpadViewController.swift
//  DemoComponent
//
//  Created by sky on 4/20/22.
//

import BaseComponent
import UIKit

class KeyboardNumpadViewController: UIViewController {
    
    @IBOutlet weak var keyboardNumpad: BaseNumpadKeyboardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardNumpad.delegate = self
    }
}

extension KeyboardNumpadViewController: BaseNumpadKeyboardViewDelegate {
    func numpadTapped(value: String) {
        print(value)
    }
}
