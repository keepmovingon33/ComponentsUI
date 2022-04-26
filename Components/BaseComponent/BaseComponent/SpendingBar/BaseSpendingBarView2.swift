//
//  BaseSpendingBarView2.swift
//  BaseComponent
//
//  Created by sky on 4/25/22.
//

import UIKit

public class BaseSpendingBarView2: BaseSpendingBarView {
    public override var spendingAmount: Double {
        didSet {
            // co dung super cho bien var duoc ko hay minh chi dung super cho func thoi vi minh ko muon lap code???
            let afterValue = Formatter.currencyWithSpace(locale: Locale(identifier: "en-PH")).string(from: NSNumber(value: balanceAmount - spendingAmount)) ?? ""
            afterValueLabel.attributedText = NSAttributedString(string: afterValue, typesetting: Typesetting.subHeadline)
            spendingBarTrailingConstraint?.constant = -(spendingAmount/balanceAmount) * (self.frame.size.width)
        }
    }
    
    override var beforeLabel: UILabel {
        didSet {
            
        }
    }
    
//    after
    
    override func updateTotalBalenceBarConstraint() {
        totalBalanceBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        totalBalanceBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
