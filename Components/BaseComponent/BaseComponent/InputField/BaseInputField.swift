//
//  BaseInputField.swift
//  BaseComponent
//
//  Created by sky on 3/29/22.
//

import UIKit

public class BaseInputField: UIView {
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.addSubview(titleLabel)
        view.addSubview(middleView)
        view.addSubview(underlineView)
        view.addSubview(messageStackView)
        return view
    }()
    
    lazy var middleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.addSubview(textField)
        view.addSubview(clearButton)
        return view
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = BaseFont.smallTitle
        textField.textAlignment = inputAlignment
        textField.delegate = self
        return textField
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.setImage(ImageProvider.image(named: "ic_clear"), for: .normal)
        return button
    }()
    
    lazy var underlineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = BaseColor.Grey.grey_50
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BaseFont.caption
        label.textAlignment = .center
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = BaseFont.caption
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var messageImage: UIImageView = {
        let imageView = UIImageView(image: ImageProvider.image(named: "ic_error"))
        imageView.tintColor = BaseColor.Denotive.red_50
        return imageView
    }()
    
    lazy var messageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [messageImage, messageLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Spacing.tiny
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    public var inputState: InputState = .blank {
        didSet {
            guard inputState != oldValue else { return }
            stateChanged()
        }
    }
    
    public var placeholder: String = "" {
        didSet {
            titleLabel.text = placeholder
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, typesetting: Typesetting.smallTitle.at(color: BaseColor.Grey.grey_50))
        }
    }
    
    public var inputAlignment: NSTextAlignment = .center {
        didSet {
            textField.textAlignment = inputAlignment
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public func setupUI() {
        self.addSubview(contentView)
        // constraints for contentView
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Spacing.medium),
            
            middleView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.tiny),
            middleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            middleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            underlineView.topAnchor.constraint(equalTo: middleView.bottomAnchor, constant: Spacing.tiny),
            underlineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            underlineView.heightAnchor.constraint(equalToConstant: 1),
            
            messageStackView.topAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: Spacing.tiny),
            messageStackView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Spacing.medium),
            messageStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            messageStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            messageImage.widthAnchor.constraint(equalToConstant: Spacing.medium),
            messageImage.heightAnchor.constraint(equalToConstant: Spacing.medium)
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: middleView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: middleView.bottomAnchor),
            textField.centerXAnchor.constraint(equalTo: middleView.centerXAnchor),
            textField.trailingAnchor.constraint(equalTo: middleView.trailingAnchor, constant: -Spacing.large),
            clearButton.topAnchor.constraint(equalTo: middleView.topAnchor),
            clearButton.bottomAnchor.constraint(equalTo: middleView.bottomAnchor),
            clearButton.trailingAnchor.constraint(equalTo: middleView.trailingAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: Spacing.medium),
            clearButton.heightAnchor.constraint(equalToConstant: Spacing.medium)
        ])
        
        stateChanged()
        
    }
    
    private func stateChanged() {
        updatePlaceholder()
        updateMessage()
        updateUnderline()
    }
    
    private func updatePlaceholder() {
        switch inputState {
        case .blank:
            titleLabel.textColor = .clear
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, typesetting: Typesetting.smallTitle.at(color: BaseColor.Grey.grey_50))
        case .focus:
            titleLabel.textColor = BaseColor.Indigo.indigo_50
            textField.attributedPlaceholder = nil
        case .lostFocus:
            titleLabel.textColor = BaseColor.Grey.grey_50
            textField.attributedPlaceholder = nil
        case .error:
            if let text = textField.text, !text.isEmpty {
                titleLabel.textColor = BaseColor.Denotive.red_50
                textField.attributedPlaceholder = nil
            } else {
                titleLabel.textColor = .clear
                textField.attributedPlaceholder = NSAttributedString(string: placeholder, typesetting: Typesetting.smallTitle.at(color: BaseColor.Grey.grey_50))
            }
        }
    }
    
    private func updateUnderline() {
        
    }
    
    private func updateMessage() {
        
    }
}

extension BaseInputField: UITextFieldDelegate {
    // start editing
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        inputState = .focus
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            inputState = .lostFocus
        } else {
            inputState = .blank
        }
        
    }
}
