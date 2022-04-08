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
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    override func setupMiddleView() {
        middleView.addSubview(inputAmount)
        
        NSLayoutConstraint.activate([
            inputAmount.topAnchor.constraint(equalTo: middleView.topAnchor),
            inputAmount.bottomAnchor.constraint(equalTo: middleView.bottomAnchor, constant: -Spacing.tiny),
            inputAmount.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
            inputAmount.trailingAnchor.constraint(equalTo: middleView.trailingAnchor),
            middleView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        textField.removeFromSuperview()
        rightButton.removeFromSuperview()
        titleLabel.removeFromSuperview()
    }
    
    override func updateInputField() {
        inputAmount.inputState = inputState
    }
    
    override func textFieldDidChange(_ textField: UITextField) {
        inputState = .focus
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return inputAmount.shouldChangeCharacter(range: range, replacement: string)
    }
}
