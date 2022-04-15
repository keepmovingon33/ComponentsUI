//
//  BaseSecurityInput.swift
//  BaseComponent
//
//  Created by sky on 4/14/22.
//

import UIKit

public class BaseSecurityInput: BaseView {
    
    public var maximumLength: Int = 6
    public var inputSecurityValue: String = "" {
        didSet {
            valueChange()
        }
    }
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.extraLarge
        return stackView
    }()
    
    // Moi lan minh can dung ban phim, minh can phai dung textfield hoac textview
    lazy var hiddenTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.tintColor = .clear // consor clear
        textField.textColor = .clear // clear textcolor
        textField.delegate = self
        return textField
    }()
    
    public override func setupView() {
        super.setupView()
        self.addSubview(mainStackView)
        self.addSubview(hiddenTextField)
        
        for index in 0..<maximumLength {
            let view = SecurityView()
            view.tag = index + 1000
            mainStackView.addArrangedSubview(view)
        }
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            mainStackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
//            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
            hiddenTextField.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            hiddenTextField.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor),
            hiddenTextField.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            hiddenTextField.heightAnchor.constraint(equalTo: mainStackView.heightAnchor)
        ])
    }
    
    private func valueChange() {
        for index in 0..<maximumLength {
            guard let view = mainStackView.viewWithTag(index + 1000) as? SecurityView else { return }
            view.securityState = index < inputSecurityValue.count ? .filled : .empty
        }
    }
}

extension BaseSecurityInput: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // delete
        if string.isEmpty {
            inputSecurityValue.removeLast()
            return true
        }
        
        if inputSecurityValue.count < maximumLength {
            inputSecurityValue += string
            return true
        }
        
        return false
    }
}
