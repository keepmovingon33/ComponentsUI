//
//  SecurityInputViewController.swift
//  DemoComponent
//
//  Created by sky on 4/14/22.
//

import UIKit
import BaseComponent

class SecurityInputViewController: UIViewController {
    
    @IBOutlet weak var securityPinInputView: BaseSecurityPintInput!
    @IBOutlet weak var securityOTPInputView: BaseSecurityOTPInput!
    @IBOutlet weak var securityPinSetupInput: BaseSecurityPinSetupInput!
    
    private let isCustomizedNumpad: Bool = true
    
    @IBOutlet weak var numpadView: BaseNumpadKeyboardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        securityPinInputView.helperText = "Pin Helper"
        securityPinInputView.delegate = self
        
        securityOTPInputView.helperText = "OTP helper"
        securityOTPInputView.delegate = self
        
        securityPinSetupInput.helperText = "Pin Setup helper"
        securityPinSetupInput.delegate = self
        
        displayNumpad(isCustomizedNumpad)
        
    }
    
    func displayNumpad(_ isCustomizedNumpad: Bool) {
        if isCustomizedNumpad {
            numpadView.delegate = self
            securityPinInputView.hideTextField()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
            self.view.addGestureRecognizer(tapGesture)
        } else {
            numpadView.isHidden = true
            
        }
    }
    
    @objc func didTap(_ sender: UITapGestureRecognizer? = nil) {
        view.endEditing(true)
    }
}

extension SecurityInputViewController: BaseSecurityInputDelegate {
    func valueDidFill(securityInput: BaseSecurityPintInput, value: String) {
//        securityPinInputView.errorMessage = "Pin Error"
//        securityOTPInputView.errorMessage = "OTP Error"
        if let otpInput = securityInput as? BaseSecurityOTPInput {
            otpInput.errorMessage = "OTP Error"
        } else {
            securityInput.errorMessage = "Pin error"
        }
        print(value)
    }
}

extension SecurityInputViewController: BaseNumpadKeyboardViewDelegate {
    func numpadTapped(value: String) {
        if value == "bio" {
            return
        } else if value == "delete" && !securityPinInputView.inputSecurityValue.isEmpty {
            securityPinInputView.inputSecurityValue.removeLast()
        } else if value != "delete" {
            if securityPinInputView.inputSecurityValue.count < securityPinInputView.maximumLength {
                securityPinInputView.inputSecurityValue += value
            } else {
                securityPinInputView.inputSecurityValue = value
            }
        }
    }
}
