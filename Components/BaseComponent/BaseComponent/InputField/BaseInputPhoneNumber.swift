//
//  BaseInputPhoneNumber.swift
//  BaseComponent
//
//  Created by sky on 4/4/22.
//

import UIKit

public class BaseInputPhoneNumber: BaseInputField {
    var patternNotStartWithZero: String = "XXX XXXX XXX"
    var patternStartWithZero: String = "XXX XXXX XXXX"
    lazy var countryCodeView: CountryCodeView = {
        let view = CountryCodeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.selectedCountry = CountryCode(code: "+84", image: ImageProvider.image(named: "ic_flag_PH"))
        return view
    }()
    
    override func setupMiddleView() {
        middleView.addSubview(countryCodeView)
        textField.textAlignment = .left
        titleLabel.textAlignment = .left
        keyboardType = .numberPad
        
        NSLayoutConstraint.activate([
            countryCodeView.topAnchor.constraint(greaterThanOrEqualTo: middleView.topAnchor),
            countryCodeView.centerYAnchor.constraint(equalTo: middleView.centerYAnchor),
            countryCodeView.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
    
            textField.topAnchor.constraint(equalTo: middleView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: middleView.bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: middleView.trailingAnchor, constant: -Spacing.large),
            textField.leadingAnchor.constraint(equalTo: countryCodeView.trailingAnchor, constant: Spacing.small),
            textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 26),

            rightButton.topAnchor.constraint(greaterThanOrEqualTo: middleView.topAnchor),
            rightButton.centerYAnchor.constraint(equalTo: middleView.centerYAnchor),
            rightButton.trailingAnchor.constraint(equalTo: middleView.trailingAnchor),
            rightButton.widthAnchor.constraint(equalToConstant: Spacing.medium),
            rightButton.heightAnchor.constraint(equalToConstant: Spacing.medium),
            
            titleLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
    
        ])
    }
    
    override func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text, let firstCharacter = text.first else { return }
        let pattern = firstCharacter == "0" ? patternStartWithZero : patternNotStartWithZero
        let newString = text.format(with: pattern)
        textField.text = newString
        rightButton.isHidden = newString.isEmpty == true
        inputState = .focus
    }
}
