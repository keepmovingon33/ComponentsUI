//
//  BaseSecurityInput.swift
//  BaseComponent
//
//  Created by sky on 4/14/22.
//

import UIKit

public protocol BaseSecurityInputDelegate {
    func valueDidFill(value: String)
}

public class BaseSecurityInput: BaseView {
    
    public var maximumLength: Int = 6
    public var inputSecurityValue: String = "" {
        didSet {
            valueChange()
        }
    }
    
    public var delegate: BaseSecurityInputDelegate?
    
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
    
    lazy var messageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = ImageProvider.image(named: "ic_error")
        imageView.tintColor = BaseColor.Denotive.red_50
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var messageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [messageImageView, messageLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.tiny
        return stackView
    }()
    
    public var helperText: String? = nil {
        didSet {
            updateHelper()
        }
    }
    
    public var errorMessage: String? = nil {
        didSet {
            updateErrorMessage()
        }
    }
    
    public override func setupView() {
        super.setupView()
        self.addSubview(mainStackView)
        self.addSubview(hiddenTextField)
        self.addSubview(messageStackView)
        
        for index in 0..<maximumLength {
            let view = SecurityView()
            view.tag = index + 1000
            mainStackView.addArrangedSubview(view)
        }
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainStackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            
            hiddenTextField.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            hiddenTextField.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor),
            hiddenTextField.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            hiddenTextField.heightAnchor.constraint(equalTo: mainStackView.heightAnchor),
            
            messageStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: Spacing.medium),
            messageStackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            messageStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            messageStackView.heightAnchor.constraint(equalToConstant: Spacing.medium),
            
            messageImageView.heightAnchor.constraint(equalToConstant: Spacing.medium),
            messageImageView.widthAnchor.constraint(equalToConstant: Spacing.medium)
        ])
    }
    
    private func valueChange() {
        fillSecurityInputView(isError: false)
        guard inputSecurityValue.count == maximumLength else {
            errorMessage = nil
            return
        }
        
        self.delegate?.valueDidFill(value: inputSecurityValue)
    }
    
    private func updateHelper() {
        guard let helper = helperText, errorMessage == nil else { return }
        messageLabel.attributedText = NSAttributedString(string: helper, typesetting: Typesetting.caption.at(color: BaseColor.Grey.grey_50))
        messageImageView.isHidden = true
    }
    
    private func updateErrorMessage() {
        guard let error = errorMessage else {
            updateHelper()
            return
        }
        
        inputSecurityValue = ""
        fillSecurityInputView(isError: true)
    
        messageLabel.attributedText = NSAttributedString(string: error, typesetting: Typesetting.caption.at(color: BaseColor.Denotive.red_50))
        messageImageView.isHidden = false
    }
    
    private func fillSecurityInputView(isError: Bool) {
        for index in 0..<maximumLength {
            guard let view = mainStackView.viewWithTag(index + 1000) as? SecurityView else { return }
            view.securityState = isError ? .error : (index < inputSecurityValue.count ? .filled : .empty)
        }
    }
}

extension BaseSecurityInput: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // delete
        if string.isEmpty, !inputSecurityValue.isEmpty {
            
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
