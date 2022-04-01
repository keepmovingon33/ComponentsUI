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
        view.addSubview(underlineAnimationView)
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
        textField.font = BaseFont.smallTitle.at(weight: .semiBold)
        textField.textAlignment = inputAlignment
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.setImage(ImageProvider.image(named: "ic_clear"), for: .normal)
        button.addTarget(self, action: #selector(clearButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var underlineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = BaseColor.Grey.grey_50
        return view
    }()
    
    lazy var underlineAnimationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = BaseColor.Indigo.indigo_50
        return view
    }()
    
    // we use this one for animation to change the width for underline
    private var underlineAnimationWidthConstraint: NSLayoutConstraint?
    
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
        label.isHidden = true
        return label
    }()
    
    lazy var messageImage: UIImageView = {
        let imageView = UIImageView(image: ImageProvider.image(named: "ic_error"))
        imageView.tintColor = BaseColor.Denotive.red_50
        imageView.isHidden = true
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
    
    public var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    
    public var returnKeyType: UIReturnKeyType = .default {
        didSet {
            textField.returnKeyType = returnKeyType
        }
    }
    
    public var helper: String? = nil {
        didSet {
            updateHelper()
        }
    }
    
    public var errorMessage: String? = nil {
        didSet {
            guard let message = errorMessage else { return }
            messageLabel.attributedText = NSAttributedString(string: message, typesetting: Typesetting.caption.at(color: BaseColor.Denotive.red_50))
            messageLabel.isHidden = false
            messageImage.isHidden = false
            inputState = .error
            self.shake()
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
    
    @objc func clearButtonTapped(_ input: UIButton) {
        textField.text = ""
        clearButton.isHidden = true
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
            
            underlineAnimationView.centerYAnchor.constraint(equalTo: underlineView.centerYAnchor),
            underlineAnimationView.centerXAnchor.constraint(equalTo: underlineView.centerXAnchor),
            underlineAnimationView.heightAnchor.constraint(equalToConstant: 2),
            
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
            textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 26),
            
            clearButton.topAnchor.constraint(greaterThanOrEqualTo: middleView.topAnchor),
            clearButton.centerYAnchor.constraint(equalTo: middleView.centerYAnchor),
            clearButton.trailingAnchor.constraint(equalTo: middleView.trailingAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: Spacing.medium),
            clearButton.heightAnchor.constraint(equalToConstant: Spacing.medium)
        ])
        
        underlineAnimationWidthConstraint = underlineAnimationView.widthAnchor.constraint(equalToConstant: 0)
        underlineAnimationWidthConstraint?.isActive = true
        
        stateChanged()
        
    }
    
    private func stateChanged() {
        updatePlaceholder()
        updateInputField()
        updateUnderline()
        updateHelper()
    }
    
    private func updatePlaceholder() {
        titleLabel.textColor = inputState.getTitleColor(input: textField.text)
        if let style = inputState.getInputPlaceholder(input: textField.text) {
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, typesetting: style)
        } else {
            textField.attributedPlaceholder = nil
        }
    }
    
    private func updateInputField() {
        textField.textColor = inputState.getInputColor()
        clearButton.tintColor = inputState.getClearButtonColor()
        clearButton.isHidden = inputState.isHiddenClearButton(input: textField.text)
    }
    
    private func updateUnderline() {
        underlineAnimationView.backgroundColor = inputState.getUnderlineColor()
        underlineAnimationWidthConstraint?.constant = inputState.isUnderlineAnimated ? underlineView.bounds.width : 0
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    private func updateHelper() {
        guard let helper = helper, inputState != .error else { return }
        messageLabel.attributedText = NSAttributedString(string: helper, typesetting: Typesetting.caption.at(color: BaseColor.Grey.grey_50))
        messageLabel.isHidden = false
        messageImage.isHidden = true
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        clearButton.isHidden = textField.text?.isEmpty == true
        inputState = .focus
    }
}
