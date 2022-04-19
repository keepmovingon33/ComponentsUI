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
}
