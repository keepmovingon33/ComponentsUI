//
//  AmountHelperView.swift
//  BaseComponent
//
//  Created by sky on 4/8/22.
//

import UIKit

public struct Provider {
    let image: UIImage?
    let helperText: String
    let fee: Double
    
    func getFee() -> String {
        if isFree() {
            return "FREE"
        }
        
        return "\(String(fee).asCurrency(locale: Locale(identifier: "en-PH")) ?? "") fee"
    }
    
    func isFree() -> Bool {
        return fee == 0.0
    }
}

public class AmountHelperView: BaseView {
    public var provider: Provider = Provider(image: ImageProvider.image(named: "ic_inputGoTyme"), helperText: "Instant Transfer", fee: 15.0)
    
    lazy var providerImageView: UIImageView = {
        let imageView = UIImageView(image: provider.image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var helperLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: provider.helperText, typesetting: Typesetting.caption.at(color: BaseColor.Grey.grey_50))
        return label
    }()
    
    
    lazy var rightImage: UIImageView = {
        let image = UIImageView(image: ImageProvider.image(named: "ic_free"))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var fee: UILabel = {
        let label = UILabel()
        if provider.isFree() {
            label.attributedText = NSAttributedString(string: provider.getFee(), typesetting: Typesetting.caption.at(weight: .medium).at(color: BaseColor.Denotive.green_50))
        } else {
            label.attributedText = NSAttributedString(string: provider.getFee(), typesetting: Typesetting.caption.at(color: BaseColor.Grey.grey_80))
        }
        return label
    }()
    
    lazy var leftStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [providerImageView, helperLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.tiny
        return stackView
    }()
    
    lazy var rightStackView: UIStackView = {
        let stackView = UIStackView()
        if provider.isFree() {
            stackView.addArrangedSubview(rightImage)
        }
        stackView.addArrangedSubview(fee)
    
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.tiny
        return stackView
    }()
    
    public override func setupView() {
        super.setupView()
        
        self.addSubview(leftStackView)
        self.addSubview(rightStackView)
        
        NSLayoutConstraint.activate([
            leftStackView.topAnchor.constraint(equalTo: self.topAnchor),
            leftStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            leftStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            rightStackView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            rightStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rightStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    
}
