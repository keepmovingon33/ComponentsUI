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
    @IBOutlet weak var inputField4: BaseInputAmount!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputField.placeholder = ""
        inputField2.placeholder = "username"
        inputField2.helper = "Testing for helper"
        inputField2.keyboardType = .emailAddress
        inputField2.returnKeyType = .next
        inputField3.placeholder = "phone number"
        inputField4.placeholder = "username"
    }
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        // turn off keyboard when hit done button
        self.view.endEditing(true)
        inputField.errorMessage = "invalid"
        inputField2.errorMessage = "invalid username"
        inputField3.errorMessage = "invalid phoneNumber"
        inputField4.errorMessage = "invalid amount"
    }
}
