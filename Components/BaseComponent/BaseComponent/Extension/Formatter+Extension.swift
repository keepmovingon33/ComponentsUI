//
//  Formatter+Extension.swift
//  BaseComponent
//
//  Created by sky on 4/8/22.
//

import Foundation

public extension Formatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    static func currencyWithSpace(locale: Locale) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let symbol = locale.currencySymbol ?? ""
        formatter.locale = locale
        formatter.positivePrefix = "\(formatter.positivePrefix ?? symbol) "
        return formatter
    }
}
