//
//  BaseSecurityOTPInput.swift
//  BaseComponent
//
//  Created by sky on 4/18/22.
//

import UIKit

public class BaseSecurityOTPInput: BaseSecurityPintInput {
    override func setupSecurityView() {
        for index in 0..<maximumLength {
            let view = SecurityOTPView()
            view.tag = index + 1000
            mainStackView.addArrangedSubview(view)
        }
        
        mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Spacing.medium).isActive = true
    }
    
    override func fillSecurityInputView(isError: Bool) {
        for index in 0..<maximumLength {
            guard let view = mainStackView.viewWithTag(index + 1000) as? SecurityOTPView else { return }
            if isError {
                view.state = .error
                view.inputValue = String(Array(inputSecurityValue)[index])
            } else {
                if index < inputSecurityValue.count {
                    view.state = .filled
                    view.inputValue = String(Array(inputSecurityValue)[index])
                } else if index == inputSecurityValue.count {
                    view.state = .filling
                    view.inputValue = ""
                } else {
                    view.state = .empty
                    view.inputValue = ""
                }
            }
        }
    }
}

extension BaseSecurityOTPInput {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let view = mainStackView.viewWithTag(inputSecurityValue.count + 1000) as? SecurityOTPView else { return }
        view.state = .filling
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let view = mainStackView.viewWithTag(inputSecurityValue.count + 1000) as? SecurityOTPView else { return }
        view.state = .empty
    }
}
