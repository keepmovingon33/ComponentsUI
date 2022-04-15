//
//  SecurityInputViewController.swift
//  DemoComponent
//
//  Created by sky on 4/14/22.
//

import UIKit
import BaseComponent

class SecurityInputViewController: UIViewController {
    
    @IBOutlet weak var securityInputView: BaseSecurityInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        securityInputView.helperText = "Helper"
        securityInputView.delegate = self
    }
}

extension SecurityInputViewController: BaseSecurityInputDelegate {
    func valueDidFill(value: String) {
        securityInputView.errorMessage = "Error"
    }
}
