//
//  BaseInputAmount.swift
//  BaseComponent
//
//  Created by sky on 4/6/22.
//

import UIKit

public class BaseInputAmount: BaseInputField {
    lazy var inputAmount: CurrencyTextField = {
        let textField = CurrencyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    override func setupMiddleView() {
        super.setupMiddleView()
        middleView.addSubview(inputAmount)
        
        NSLayoutConstraint.activate([
            inputAmount.topAnchor.constraint(equalTo: middleView.topAnchor),
            inputAmount.bottomAnchor.constraint(equalTo: middleView.bottomAnchor),
            inputAmount.centerXAnchor.constraint(equalTo: middleView.centerXAnchor),
            inputAmount.trailingAnchor.constraint(equalTo: middleView.trailingAnchor, constant: -Spacing.large),
            inputAmount.heightAnchor.constraint(greaterThanOrEqualToConstant: 26)
        ])
        
        textField.removeFromSuperview()
    }
}
