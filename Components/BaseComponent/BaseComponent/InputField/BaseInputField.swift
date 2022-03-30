//
//  BaseInputField.swift
//  BaseComponent
//
//  Created by sky on 3/29/22.
//

import UIKit

class BaseInputField: UIView {
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = BaseFont.smallTitle
        return textField
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: Spacing.medium, height: Spacing.medium))
        button.setImage(ImageProvider.image(named: "ic_clear"), for: .normal)
        return button
    }()
}

