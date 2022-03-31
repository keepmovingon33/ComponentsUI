//
//  BaseInputField.swift
//  BaseComponent
//
//  Created by sky on 3/29/22.
//

import UIKit

class BaseInputField: UIView {
    
    // sao luc add nay minh ko quy dinh la add horizontal hay veritical, sao no biet duoc?
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
    
    
    // sao ko set placeholder ve cai alignment, text color cac kieu cho placeholder cua textField?
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = BaseFont.smallTitle
        return textField
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: Spacing.medium, height: Spacing.medium))
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func setupUI() {
        
        // constraints for contentView
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            middleView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.tiny),
            middleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            middleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            underlineView.topAnchor.constraint(equalTo: middleView.bottomAnchor, constant: Spacing.tiny),
            underlineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            messageStackView.topAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: Spacing.tiny),
            messageStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            messageStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            messageStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // constraint cho middleview. trailing cua textField va leading cua clearbutton set sao day?
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: middleView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: middleView.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
            clearButton.topAnchor.constraint(equalTo: middleView.topAnchor),
            clearButton.bottomAnchor.constraint(equalTo: middleView.bottomAnchor),
            clearButton.trailingAnchor.constraint(equalTo: middleView.trailingAnchor)
        ])
        
    }
    
}

