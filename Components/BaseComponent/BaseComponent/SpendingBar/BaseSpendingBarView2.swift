//
//  BaseSpendingBarView2.swift
//  BaseComponent
//
//  Created by sky on 4/25/22.
//

import UIKit

public class BaseSpendingBarView2: BaseSpendingBarView {
    override func getSpendingWidth() -> CGFloat {
        return (1 - spendingAmount/balanceAmount) * (UIScreen.main.bounds.width)
    }

    override func updateTotalBalenceBarConstraint() {
        totalBalanceBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        totalBalanceBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        spendingBar.roundCorners(corners: [.topRight, .bottomRight], radius: 3)
//        totalBalanceBar.roundCorners(corners: [.topRight, .bottomRight], radius: 3)
    }
}
