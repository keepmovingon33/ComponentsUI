//
//  BaseSecurityPinSetupInput.swift
//  BaseComponent
//
//  Created by sky on 4/19/22.
//

import UIKit

public class BaseSecurityPinSetupInput: BaseSecurityOTPInput {
    
    override func setupSecurityView() {
        for index in 0..<maximumLength {
            let view = SecurityPinSetupView()
            view.tag = index + 1000
            mainStackView.addArrangedSubview(view)
        }

        mainStackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor).isActive = true
    }
    
    override func fillSecurityInputView(isError: Bool) {
        for index in 0..<maximumLength {
            guard let view = mainStackView.viewWithTag(index + 1000) as? SecurityOTPView else { return }
            view.inputValue = ""
            if isError {
                view.state = .error
            } else {
                if index < inputSecurityValue.count {
                    view.state = .filled
                    if index == inputSecurityValue.count - 1 {
                        view.inputValue = String(Array(inputSecurityValue)[index])
                    }
                } else if index == inputSecurityValue.count {
                    view.state = .filling
                } else {
                    view.state = .empty
                }
            }
        }
    }
}
