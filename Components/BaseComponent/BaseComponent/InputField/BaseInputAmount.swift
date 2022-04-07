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
        textField.textAlignment = .center
        textField.clipsToBounds = true
        return textField
    }()
    override func setupMiddleView() {
        middleView.addSubview(inputAmount)
        
        NSLayoutConstraint.activate([
            inputAmount.topAnchor.constraint(equalTo: middleView.topAnchor),
            inputAmount.bottomAnchor.constraint(equalTo: middleView.bottomAnchor, constant: -Spacing.normal),
            inputAmount.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
            inputAmount.trailingAnchor.constraint(equalTo: middleView.trailingAnchor)
        ])
        
        textField.removeFromSuperview()
    }
}
