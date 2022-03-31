//
//  InputTextFieldViewController.swift
//  DemoComponent
//
//  Created by sky on 3/31/22.
//

import BaseComponent
import UIKit

class InputFieldViewController: UIViewController {
    
    @IBOutlet weak var inputField: BaseInputField!
    @IBOutlet weak var inputField2: BaseInputField!
    @IBOutlet weak var inputField3: BaseInputField!
    @IBOutlet weak var inputField4: BaseInputField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputField.placeholder = ""
        inputField2.placeholder = "username"
        inputField3.placeholder = "username"
        inputField4.placeholder = "username"
    }
}
