//
//  PracticeBaseInputPinView.swift
//  BaseComponent
//
//  Created by sky on 4/24/22.
//

import UIKit

public protocol PracticeBaseInputPinViewDelegate {
    func valueTapped(value: String)
}

public class PracticeBaseInputPinView: BaseView {
    
    public var maximumPinNumber: Int = 6
    
    public var delegate: PracticeBaseInputPinViewDelegate?
    
    
    lazy var mainView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.extraLarge
        return stackView
    }()
    
    var valueInput: String = "" {
        didSet {
            fillPinView(input: valueInput, error: false)
        }
    }
    
    lazy var hiddenTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.tintColor = .clear
        textField.textColor = .clear
        textField.delegate = self
        return textField
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var messageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [errorImageView, messageLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.tiny
        return stackView
    }()
    
    public var helperMessage: String = "" {
        didSet {
            updateHelper()
        }
    }
    
    public var errorMessage: String = "" {
        didSet {
            updateErrorMessage()
        }
    }
    
    public override func setupView() {
        self.addSubview(mainView)
        self.addSubview(hiddenTextField)
        self.addSubview(messageStackView)
        
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            mainView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            
            hiddenTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            hiddenTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            hiddenTextField.topAnchor.constraint(equalTo: mainView.topAnchor),
            hiddenTextField.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            messageStackView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: Spacing.medium),
            messageStackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            messageStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            errorImageView.heightAnchor.constraint(equalToConstant: Spacing.medium),
            errorImageView.widthAnchor.constraint(equalToConstant: Spacing.medium)
        ])
        
        
        addPinView()
        
    }
    
    func addPinView() {
        for index in 0..<maximumPinNumber {
            let view = PracticeInputPinView()
            view.tag = 1000 + index
            mainView.addArrangedSubview(view)
            print("mainView.tag = \(mainView.tag)")
        }
    }
    
    func fillPinView(input: String, error: Bool) {
        for index in 0..<maximumPinNumber {
            guard let view = mainView.viewWithTag(index + 1000) as? PracticeInputPinView else { return }
            if error {
                view.state = .error
            } else {
                if index < input.count {
                    view.state = .filled
                } else {
                    view.state = .empty
                }
            }
        }
    }
    
    func updateHelper() {
        errorImageView.isHidden = true
        messageLabel.attributedText = NSAttributedString(string: helperMessage, typesetting: Typesetting.footnode.at(color: BaseColor.Grey.grey_50))
    }
    
    func updateErrorMessage() {
        errorImageView.isHidden = false
        errorImageView.image = ImageProvider.image(named: "ic_error")
        errorImageView.tintColor = BaseColor.Denotive.red_50
        messageLabel.attributedText = NSAttributedString(string: errorMessage, typesetting: Typesetting.footnode.at(color: BaseColor.Denotive.red_50))
        fillPinView(input: valueInput, error: true)
    }
}

extension PracticeBaseInputPinView: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty && !valueInput.isEmpty {
            valueInput.removeLast()
        }
            
        if valueInput.count < maximumPinNumber {
            valueInput += string
        } else {
            valueInput = string
        }
        
        delegate?.valueTapped(value: valueInput)
        
        return true
    }
    
}
