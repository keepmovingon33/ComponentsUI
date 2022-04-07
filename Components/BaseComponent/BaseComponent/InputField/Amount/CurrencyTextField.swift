//
//  CurrencyTextField.swift
//  BaseComponent
//
//  Created by sky on 4/6/22.
//

import UIKit

public class CurrencyTextField: UITextField {
    public var maximumDigit = 15
    public var maximumAmountValue = Double.infinity
    private var defaultValue = 0.00
    
    /// The numbers that have been entered in the text field
    private var enteredNumbers = ""

    private var didBackspace = false

    var locale: Locale = Locale(identifier: "en_PH")

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        self.attributedText = getCurrency(value: enteredNumbers.asCurrency(locale: locale) ?? "")
        keyboardType = .numberPad
        sizeToFit()
        contentVerticalAlignment = .center
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }

    public override func deleteBackward() {
        enteredNumbers = String(enteredNumbers.dropLast())
        self.attributedText = getCurrency(value: enteredNumbers.asCurrency(locale: locale) ?? "")
        // Call super so that the .editingChanged event gets fired, but we need to handle it differently, so we set the `didBackspace` flag first
        didBackspace = true
        super.deleteBackward()
    }

    @objc func editingChanged() {
        defer {
            didBackspace = false
            self.attributedText = getCurrency(value: enteredNumbers.asCurrency(locale: locale) ?? "")
        }

        guard didBackspace == false else { return }

        if let lastEnteredCharacter = text?.last, lastEnteredCharacter.isNumber {
            enteredNumbers.append(lastEnteredCharacter)
        }
    }
    
    private func getCurrency(value: String) -> NSMutableAttributedString? {
        guard let symbol = locale.currencySymbol else { return nil }
        let fullText = value.contains(symbol) ? value : "\(symbol)\(value)"
        let symbolRange = NSString(string: fullText).range(of: symbol)
        let symbolAttribute = Typesetting.mediumTitle.at(weight: .semiBold).centered
        let resultString = NSMutableAttributedString(string: value, typesetting: Typesetting.xlargeTitle.centered)
        resultString.setAttributes(symbolAttribute.attributes, range: symbolRange)

        resultString.addAttribute(NSAttributedString.Key.kern, value: 4, range: symbolRange)
        resultString.addAttribute(NSAttributedString.Key.baselineOffset, value: 21, range: symbolRange)
        return resultString
    }
}

private extension Formatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
}

private extension String {
    func asCurrency(locale: Locale) -> String? {
        Formatter.currency.locale = locale
        if self.isEmpty {
            return Formatter.currency.string(from: NSNumber(value: 0))
        } else {
            return Formatter.currency.string(from: NSNumber(value: (Double(self) ?? 0) / 100))
        }
    }
}
