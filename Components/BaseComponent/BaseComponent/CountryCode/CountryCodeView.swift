//
//  CountryCodeView.swift
//  BaseComponent
//
//  Created by sky on 4/4/22.
//

import UIKit

public struct CountryCode {
    let code: String
    let image: UIImage?
    
    func getCountryCode() -> String {
        return "(\(code))"
    }
}

public class CountryCodeView: BaseView {
    var selectedCountry = CountryCode(code: "+63", image: ImageProvider.image(named: "ic_flag_PH")) {
        didSet {
            flagImageView.image = selectedCountry.image
            countryCodeLabel.attributedText = NSAttributedString(string: selectedCountry.getCountryCode(), typesetting: Typesetting.smallTitle.at(weight: .semiBold))
        }
    }
    
    lazy var flagImageView: UIImageView = {
        let imageView = UIImageView(image: selectedCountry.image)
        return imageView
    }()
    
    lazy var countryCodeLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: selectedCountry.getCountryCode(), typesetting: Typesetting.smallTitle.at(weight: .semiBold))
        return label
    }()
    
    lazy var dropDownImage: UIImageView = {
        let imageView = UIImageView(image: ImageProvider.image(named: "ic_chevron_down"))
        imageView.tintColor = BaseColor.Grey.grey_50
        return imageView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [flagImageView, countryCodeLabel, dropDownImage])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.tiny
        stackView.alignment = .center
        return stackView
    }()
    
    public override func setupView() {
        super.setupView()
        self.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            flagImageView.widthAnchor.constraint(equalToConstant: Spacing.large),
            flagImageView.heightAnchor.constraint(equalToConstant: Spacing.large),
            
            dropDownImage.widthAnchor.constraint(equalToConstant: Spacing.medium),
            dropDownImage.heightAnchor.constraint(equalToConstant: Spacing.medium)
        ])
    }
}
