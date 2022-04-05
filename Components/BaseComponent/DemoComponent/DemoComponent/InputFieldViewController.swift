//
//  InputTextFieldViewController.swift
//  DemoComponent
//
//  Created by sky on 3/31/22.
//

import BaseComponent
import UIKit

class InputFieldViewController: UIViewController {
    
    @IBOutlet weak var inputField: BaseDropDown!
    @IBOutlet weak var inputField2: BaseInputField!
    @IBOutlet weak var inputField3: BaseInputPhoneNumber!
    @IBOutlet weak var inputField4: BaseInputField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputField.placeholder = ""
        inputField2.placeholder = "username"
        inputField2.helper = "Testing for helper"
        inputField2.keyboardType = .emailAddress
        inputField2.returnKeyType = .next
        inputField3.placeholder = "username"
        inputField4.placeholder = "username"
    }
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        inputField.errorMessage = "invalid"
        // turn off keyboard when hit done button
//        inputField.endEditing(true)
        self.view.endEditing(true)
        inputField2.errorMessage = "invalid username"
    }
}
