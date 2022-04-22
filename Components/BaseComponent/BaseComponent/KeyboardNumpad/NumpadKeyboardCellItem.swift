//
//  NumpadKeyboardCellItem.swift
//  BaseComponent
//
//  Created by sky on 4/20/22.
//

import UIKit

public class NumpadKeyboardCellItem: UICollectionViewCell {
    
    static let identifier = "NumpadKeyboardCellItem"
    
    private var item: NumpadItem?
    
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
        self.item = item
        keypadView.backgroundColor = item.type.getNumPadBackgroundColor()
    
        if let inputValue = item.value {
            inputLabel.attributedText = NSAttributedString(string: inputValue, typesetting: Typesetting.mediumTitle)
        } else {
            inputLabel.attributedText = nil
        }
        
        numpadImageView.image = item.image
        numpadImageView.tintColor = item.type.getHighLightColor().normal
    }
    
    // animation thi ko can dung weak self
    public override var isHighlighted: Bool {
        didSet {
            guard let highLightColor = item?.type.getHighLightColor(), let numpadType = item?.type else { return }
            UIView.animate(withDuration: 0.1) {
                if numpadType == .numpad {
                    self.keypadView.backgroundColor = self.isHighlighted ? highLightColor.highLight : highLightColor.normal
                }
                self.numpadImageView.tintColor = self.isHighlighted ? highLightColor.highLight : highLightColor.normal
            }
        }
    }
    
}

public struct NumpadItem {
    let value: String?
    let image: UIImage?
    let type: NumpadType
    
    static func defaultValue() -> [NumpadItem] {
        return [
            NumpadItem(value: "1", image: nil, type: .numpad),
            NumpadItem(value: "2", image: nil, type: .numpad),
            NumpadItem(value: "3", image: nil, type: .numpad),
            NumpadItem(value: "4", image: nil, type: .numpad),
            NumpadItem(value: "5", image: nil, type: .numpad),
            NumpadItem(value: "6", image: nil, type: .numpad),
            NumpadItem(value: "7", image: nil, type: .numpad),
            NumpadItem(value: "8", image: nil, type: .numpad),
            NumpadItem(value: "9", image: nil, type: .numpad),
            NumpadItem(value: nil, image: ImageProvider.image(named: "ic_bio_touchID"), type: .biometric),
            NumpadItem(value: "0", image: nil, type: .numpad),
            NumpadItem(value: nil, image: ImageProvider.image(named: "ic_backspace"), type: .delete)
        ]
    }
}

public struct HighLightColor {
    let highLight: UIColor
    let normal: UIColor
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
    
    func getHighLightColor() -> HighLightColor {
        switch self {
        case .numpad:
            return HighLightColor(highLight: BaseColor.Indigo.indigo_10, normal: BaseColor.Grey.grey_5)
        case .delete, .biometric:
            return HighLightColor(highLight: BaseColor.Grey.grey_100.withAlphaComponent(0.3),
                                  normal: BaseColor.Grey.grey_100)
        }
    }
}
