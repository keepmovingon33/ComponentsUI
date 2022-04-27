//
//  BaseSpendingBarView.swift
//  BaseComponent
//
//  Created by sky on 4/25/22.
//

import UIKit

public protocol BaseSpendingBarViewDelegate {
    func inputValue(value: Double)
}

public class BaseSpendingBarView: BaseView {
    
    public var delegate: BaseSpendingBarViewDelegate?
    
    public var balanceAmount: Double = 0.0 {
        didSet {
            let balanceValue = Formatter.currencyWithSpace(locale: Locale(identifier: "en-PH")).string(from: NSNumber(value: balanceAmount)) ?? ""
            beforeValueLabel.attributedText = NSAttributedString(string: balanceValue, typesetting: Typesetting.subHeadline)
            updateSpendingBar()
        }
    }
    
    public var spendingAmount: Double = 0.0 {
        didSet {
            if spendingAmount > balanceAmount {
                updateError()
            } else {
                updateSpendingBar()
                spendingBarWidth?.constant = getSpendingWidth()
            }
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        }
    }
    
    lazy var beforeStackview: UIStackView = {
        let view = UIStackView(arrangedSubviews: [beforeLabel, beforeValueLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        return view
    }()
    
    lazy var beforeLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Before", typesetting: Typesetting.caption)
        return label
    }()
    
    lazy var beforeValueLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var afterStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [afterLabel, afterValueLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.axis = .vertical
        return view
    }()
    
    lazy var afterLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "After", typesetting: Typesetting.caption)
        return label
    }()
    
    lazy var afterValueLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.addSubview(beforeStackview)
        view.addSubview(afterStackView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var totalBalanceBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = BaseColor.Grey.grey_10
        view.cornerRadius = 3
        return view
    }()
    
    lazy var spendingBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .blue
        view.cornerRadius = 3

        return view
    }()

    var spendingBarWidth: NSLayoutConstraint?
    
    // func nay dung sau khi UIView load xong
    public override func layoutSubviews() {
        super.layoutSubviews()
        spendingBar.applyBackgroundGradient(colors: [BaseColor.Gradient.start, BaseColor.Gradient.end], startPoint: CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint(x: 1.0, y: 0.0))
    }
    
    public override func setupView() {
        self.addSubview(mainView)
        self.addSubview(totalBalanceBar)
        self.addSubview(spendingBar)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: Spacing.small),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Spacing.large),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Spacing.large),
            
            totalBalanceBar.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: Spacing.tiny),
            totalBalanceBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            totalBalanceBar.heightAnchor.constraint(equalToConstant: 6),
            
            spendingBar.topAnchor.constraint(equalTo: totalBalanceBar.topAnchor),
            spendingBar.bottomAnchor.constraint(equalTo: totalBalanceBar.bottomAnchor),
            spendingBar.leadingAnchor.constraint(equalTo: totalBalanceBar.leadingAnchor),
//            spendingBar.trailingAnchor.constraint(equalTo: totalBalanceBar.trailingAnchor, constant: -100)
    
            beforeStackview.topAnchor.constraint(equalTo: mainView.topAnchor),
            beforeStackview.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            beforeStackview.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            
            afterStackView.topAnchor.constraint(equalTo: mainView.topAnchor),
            afterStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            afterStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            afterStackView.leadingAnchor.constraint(greaterThanOrEqualTo: beforeStackview.trailingAnchor)
        ])
        
        spendingBarWidth = spendingBar.widthAnchor.constraint(equalToConstant: 0)
        spendingBarWidth?.isActive = true
        updateTotalBalenceBarConstraint()
    }
    
    func updateTotalBalenceBarConstraint() {
        totalBalanceBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Spacing.large).isActive = true
        totalBalanceBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Spacing.large).isActive = true
    }
    
    private func updateError() {
        totalBalanceBar.backgroundColor = BaseColor.Denotive.red_50
        spendingBar.isHidden = true
        afterValueLabel.attributedText = NSAttributedString(string: "--", typesetting: Typesetting.subHeadline)
    }
    
    private func updateSpendingBar() {
        spendingBar.isHidden = false
        totalBalanceBar.backgroundColor = BaseColor.Grey.grey_10
        let afterValue = Formatter.currencyWithSpace(locale: Locale(identifier: "en-PH")).string(from: NSNumber(value: balanceAmount - spendingAmount)) ?? ""
        afterValueLabel.attributedText = NSAttributedString(string: afterValue, typesetting: Typesetting.subHeadline)
    }
    
    func getSpendingWidth() -> CGFloat {
        return (spendingAmount/balanceAmount) * (UIScreen.main.bounds.width - 40)
    }
}
