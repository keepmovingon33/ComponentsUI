// swiftlint:disable all
//
//  String+Typography.swift
//  TymeComponent
//
//  Created by Duy Le on 02/12/2021.
//

import Foundation

private let objectFormattingCharacterRegex = try? NSRegularExpression(pattern: #"(?<!%)%(?:\d\$)?@"#, options: [])
private let escapedFormatterRegex = try? NSRegularExpression(pattern: #"%(?=%)"#, options: [])

extension String {
    
    ///Find the object formatting character ranges and positions
    ///
    /// - Returns : An array of ranges and positions for each object formatting character in the order they appear in the string
    internal func orderedObjectFormattingCharacterRanges() -> [(range: NSRange, argumentIndex: Int)] {
        let matches = objectFormattingCharacterRegex?.matches(in: self) ?? []

        let ranges = matches.map({ $0.range })
        let formattingCharacters = ranges.map({ (self as NSString).substring(with: $0) })
        let indexes = argumentIndexes(fromFormattingCharacters: formattingCharacters)
        
        return Array(zip(ranges, indexes))
    }
    
    /// Convert an array of object formating characters ('%@" or '%1$@ ) to their argument's index
    /// - Parameter positions : An array of format characters
    /// - Returns : An array of the argument's indexes in the order the formatting compact characters appear in the string Popover
    private func argumentIndexes(fromFormattingCharacters formattingCharacters: [String]) -> [Int] {
        let positionalFormat = formattingCharacters.joined(separator: ":")
        let positionalArguments = (0 ..< formattingCharacters.count).map(String.init)
    
        return String(format: positionalFormat, arguments: positionalArguments).components(separatedBy: ":").compactMap(Int.init)
    }
    
    /// Find the escaped percent signs: %%
    ///
    /// - Returns : An array of NSRanges of the first % character to remove
    internal func escapedFormatterRanges () -> [NSRange] {
        return escapedFormatterRegex?.matches (in: self).map({ $0.range }) ?? []
    }
    
}

private extension NSRegularExpression {
    func matches(in string: String) -> [NSTextCheckingResult] {
        let fullRange = NSRange (location: 0, length: string.utf16.count)
        return matches (in: string, options: [],range: fullRange)
    }
}
