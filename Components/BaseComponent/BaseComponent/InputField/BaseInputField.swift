//
//  BaseInputField.swift
//  BaseComponent
//
//  Created by sky on 3/29/22.
//

import UIKit

public class BaseInputField: BaseInput {
    override func setupMiddleView() {
        rightButton.setImage(ImageProvider.image(named: "ic_clear"), for: .normal)
    }
    
    override func rightButtonTapped(_ input: UIButton) {
        textField.text = ""
        rightButton.isHidden = true
    }
}
