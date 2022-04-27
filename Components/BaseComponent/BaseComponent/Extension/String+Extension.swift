//
//  String+Extension.swift
//  BaseComponent
//
//  Created by sky on 4/5/22.
//

import Foundation

public extension String {
    func format(with pattern: String) -> String {
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in pattern where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                // move numbers iterator to the next index
                index = numbers.index(after: index)
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}

public extension String {
    func asCurrency(locale: Locale) -> String? {
        Formatter.currency.locale = locale
        if self.isEmpty {
            return Formatter.currency.string(from: NSNumber(value: 0))
        } else {
            return Formatter.currency.string(from: NSNumber(value: (Double(self) ?? 0) / 100))
        }
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}

public extension String {
    func toDouble() -> Double {
        return Double(self.components(separatedBy: CharacterSet(charactersIn: "0123456789.").inverted).joined()) ?? 0.0
    }
}
