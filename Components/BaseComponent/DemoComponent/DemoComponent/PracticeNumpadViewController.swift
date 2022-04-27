//
//  PracticeNumpadViewController.swift
//  DemoComponent
//
//  Created by sky on 4/23/22.
//

import BaseComponent
import UIKit

class PracticeNumpadViewController: UIViewController {

    
    @IBOutlet weak var practiceNumpadView: PracticeNumpadView!
    @IBOutlet weak var pinInputView: PracticeBaseInputPinView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        practiceNumpadView.delegate = self
        
        pinInputView.delegate = self
        pinInputView.helperMessage = "Pin input Helper"
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideNumpadKeyboard))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func hideNumpadKeyboard() {
        view.endEditing(true)
    }

}

extension PracticeNumpadViewController: PracticeNumpadViewDelegate {
    func numpadTapped(numpadItem: PracticeNumpadItem) {
        
    }
}

extension PracticeNumpadViewController: PracticeBaseInputPinViewDelegate {
    func valueTapped(value: String) {
        if value.count == pinInputView.maximumPinNumber {
            pinInputView.errorMessage = "Pin Error Message"
            print("you input = \(value)")
        } else {
            pinInputView.helperMessage = "Pin Input Helper"
        }
        
    }
}
