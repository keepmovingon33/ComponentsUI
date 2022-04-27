//
//  SpendingBarViewController.swift
//  DemoComponent
//
//  Created by sky on 4/25/22.
//

import BaseComponent
import UIKit

class SpendingBarViewController: UIViewController {
    
    @IBOutlet weak var spendingBarView: BaseSpendingBarView!
    @IBOutlet weak var spendingBarView2: BaseSpendingBarView2!
    
    @IBOutlet weak var inputAmount: BaseInputAmount!
    
    override func viewDidLoad() {
        
        spendingBarView.balanceAmount = 100000.00
        inputAmount.delegate = self
        
        spendingBarView2.balanceAmount = 100000.00
        
    }
}

extension SpendingBarViewController: BaseInputAmountDelegate {
    func inputValueChanged(value: String) {
        spendingBarView.spendingAmount = value.toDouble()
        spendingBarView2.spendingAmount = value.toDouble()
    }
}

//
//extension BaseSpendingBarView: UITextFieldDelegate {
//    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if string.isEmpty && !spendingValue.isEmpty {
//            spendingValue.removeLast()
//        }
//        spendingValue += string
//        spendingAmount = Double(spendingValue) ?? 0.0
//        if spendingAmount > balanceAmount {
//            updateError()
//        } else {
//            totalBalanceBar.backgroundColor = BaseColor.Grey.grey_10
////            spendingBar.backgroundColor = .blue
//            spendingBar.applyBackgroundGradient(colors: [BaseColor.Gradient.start, BaseColor.Gradient.end], startPoint: CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint(x: 1.0, y: 0.0))
//        }
//        delegate?.inputValue(value: spendingAmount)
//        
//        return true
//    }
//}
