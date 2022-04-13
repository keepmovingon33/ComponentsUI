//
//  CurrencyTextField.swift
//  BaseComponent
//
//  Created by sky on 4/6/22.
//

import UIKit

public class CurrencyTextField: UITextField {
    public var maximumDigit = 9
    public var maximumAmountValue = Double.infinity
    private var defaultValue = 0.00
    
    /// The numbers that have been entered in the text field
    private var enteredNumbers = ""

    private var didBackspace = false

    var locale: Locale = Locale(identifier: "en_PH")
    
    public var inputState: InputState = .blank {
        didSet {
            guard inputState != oldValue else { return }
            self.attributedText = getCurrency(value: enteredNumbers.asCurrency(locale: locale) ?? "")
        }
    }

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
        let symbolAttribute = Typesetting.mediumTitle.at(weight: .semiBold).at(color: inputState.getInputColor()).centered
        let resultString = NSMutableAttributedString(string: value, typesetting: Typesetting.xlargeTitle.at(color: inputState.getInputColor()).centered)
        resultString.setAttributes(symbolAttribute.attributes, range: symbolRange)
        // padding ben phai cua peso so voi value
        resultString.addAttribute(NSAttributedString.Key.kern, value: Spacing.tiny, range: symbolRange)
        // padding bottom cua peso so voi input
        resultString.addAttribute(NSAttributedString.Key.baselineOffset, value: Spacing.big, range: symbolRange)
        resultString.addAttribute(NSAttributedString.Key.baselineOffset, value: Spacing.small, range: NSString(string: fullText).range(of: String(fullText.dropFirst())))
        return resultString
    }
    
    // kiem tra coi co input duoc hay ko
    func shouldChangeCharacter(range: NSRange, replacement: String) -> Bool {
        guard let textInput = self.text as NSString? else { return false }
        let toUpdateText = textInput.replacingCharacters(in: range, with: replacement)
        
        guard toUpdateText.digits.count <= maximumDigit else { return false }
        return true
    }
}
