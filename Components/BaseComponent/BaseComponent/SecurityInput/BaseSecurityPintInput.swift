//
//  BaseSecurityInput.swift
//  BaseComponent
//
//  Created by sky on 4/14/22.
//

import UIKit

public protocol BaseSecurityInputDelegate {
    func valueDidFill(securityInput: BaseSecurityPintInput, value: String)
}

public class BaseSecurityPintInput: BaseView {
    
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
        
        setupSecurityView()
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
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
    
    func setupSecurityView() {
        for index in 0..<maximumLength {
            let view = SecurityPinView()
            view.tag = index + 1000
            mainStackView.addArrangedSubview(view)
        }
        
        mainStackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor).isActive = true
    }
    
    private func valueChange() {
        fillSecurityInputView(isError: false)
        guard inputSecurityValue.count == maximumLength else {
            errorMessage = nil
            return
        }
        
        self.delegate?.valueDidFill(securityInput: self, value: inputSecurityValue)
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
        
        fillSecurityInputView(isError: true)
    
        messageLabel.attributedText = NSAttributedString(string: error, typesetting: Typesetting.caption.at(color: BaseColor.Denotive.red_50))
        messageImageView.isHidden = false
    }
    
    func fillSecurityInputView(isError: Bool) {
        for index in 0..<maximumLength {
            guard let view = mainStackView.viewWithTag(index + 1000) as? SecurityPinView else { return }
            view.state = isError ? .error : (index < inputSecurityValue.count ? .filled : .empty)
        }
    }
}

extension BaseSecurityPintInput: UITextFieldDelegate {
    // func nay se quyet dinh textfield do co duoc display string minh vua duoc input hay ko. ma minh dang cheating voi cai textfield nay (minh dung cai textfield nay chi de display keyboard len cho cai view)
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // delete
        if string.isEmpty, !inputSecurityValue.isEmpty {
            inputSecurityValue.removeLast()
        }
        
        if inputSecurityValue.count < maximumLength {
            inputSecurityValue += string
        } else {
            inputSecurityValue = string
        }
        
        // phai return true vi neu return false, string input = "", nen delete event se ko chay
        return true
    }
}
