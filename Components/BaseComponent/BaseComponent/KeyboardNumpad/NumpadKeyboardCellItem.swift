//
//  NumpadKeyboardCellItem.swift
//  BaseComponent
//
//  Created by sky on 4/20/22.
//

import UIKit

public class NumpadKeyboardCellItem: UICollectionViewCell {
    
    lazy var keypadView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var inputLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var numpadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    public func setupView() {
        self.addSubview(keypadView)
        self.addSubview(inputLabel)
        self.addSubview(numpadImageView)
        
        NSLayoutConstraint.activate([
            keypadView.topAnchor.constraint(equalTo: self.topAnchor),
            keypadView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            keypadView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            keypadView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            keypadView.heightAnchor.constraint(equalTo: self.widthAnchor),
            keypadView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            inputLabel.centerXAnchor.constraint(equalTo: keypadView.centerXAnchor),
            inputLabel.centerYAnchor.constraint(equalTo: keypadView.centerYAnchor),
            
            numpadImageView.centerXAnchor.constraint(equalTo: keypadView.centerXAnchor),
            numpadImageView.centerYAnchor.constraint(equalTo: keypadView.centerYAnchor),
            numpadImageView.heightAnchor.constraint(equalToConstant: Spacing.huge),
            numpadImageView.widthAnchor.constraint(equalToConstant: Spacing.huge)
        ])
        
        keypadView.cornerRadius = self.bounds.width / 2
    }
    
    public func bindingData(item: NumpadItem) {
        keypadView.backgroundColor = item.type.getNumPadBackgroundColor()
        if let inputValue = item.value {
            inputLabel.attributedText = NSAttributedString(string: inputValue, typesetting: Typesetting.mediumTitle)
        } else {
            inputLabel.attributedText = nil
        }
        
        numpadImageView.image = item.image
    }
    
}

public struct NumpadItem {
    let value: String?
    let image: UIImage?
    let type: NumpadType
}

public enum NumpadType {
    case numpad
    case delete
    case biometric
    
    func getNumPadBackgroundColor() -> UIColor {
        switch self {
        case .numpad:
            return BaseColor.Grey.grey_5
        default:
            return .clear
        }
    }
}
