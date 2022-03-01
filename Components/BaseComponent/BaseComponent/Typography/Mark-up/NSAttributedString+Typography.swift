// swiftlint:disable all
//
//  NSAttributedString+Typography.swift
//  TymeComponent
//
//  Created by Duy Le on 02/12/2021.
//

import Foundation

extension NSAttributedString {
    
    // MARK: NSAttributedString input

    /// Initialize an NSAttributedString with an NSAttributedString format and list of NSAttributedString arguments
    ///
    /// - Parameters :
    ///  - format: A format string containing `%@` object formatting characters
    ///  - arguments: An array of strings to replace in each format
    public convenience init(format formatAttributedString: NSAttributedString,
                            _ arguments: NSAttributedString ...) {
        self.init(format: formatAttributedString, arguments: arguments)
    }
    
    /// Convenience for init(format: NSAttributedString, arguments: NSAttributedString ... )
    public convenience init(format formatAttributedString: NSAttributedString,
                            arguments: [NSAttributedString]) {
        let formattingCharacters = formatAttributedString.string.orderedObjectFormattingCharacterRanges()
        let mutableAttributedFormat = NSMutableAttributedString(attributedString: formatAttributedString)

        for formattingCharacter in formattingCharacters.reversed() {
            mutableAttributedFormat.replaceCharacters(in: formattingCharacter.range,
                                                      with: arguments[formattingCharacter.argumentIndex])
        }

        mutableAttributedFormat.string.escapedFormatterRanges().reversed().forEach({ mutableAttributedFormat.deleteCharacters(in: $0) })

        self.init(attributedString: mutableAttributedFormat)
    }

    // MARK: String and Attributes input

    /// An unformatted string and its associated attributes.
    public typealias StringWithAttributesPair = (text: String, attributes: [Key: Any])
    
    /// Initialize an NSAttributedString with a format String, attributes, and list of String/attribute arguments

    /// - Parameters
    ///  - format : A format string containing `%@` object formatting characters
    ///  - attributes: Base attributes to apply to the string
    ///  - arguments : An array of strings to replace in each format
    public convenience init(format formatString: String, attributes: [Key: Any],
                            _ arguments: StringWithAttributesPair ...) {
        self.init(format: formatString, attributes: attributes, arguments: arguments)
    }

    /// Convenience for init (format: String, attributes: [Key: Any], arguments: (text: String, attributes: [Key: Any] ) ... )
    public convenience init(format formatString: String, attributes: [Key: Any],
                            arguments: [StringWithAttributesPair]) {
        let formatAttributedString = NSAttributedString(string: formatString, attributes: attributes)
        let attributedArguments = arguments.map({NSAttributedString(string: $0.text, attributes:
                                                                    attributes.merging($0.attributes, uniquingKeysWith: { $1 })) })
        self.init(format: formatAttributedString, arguments: attributedArguments)
    }

    // MARK: String and Typesetting input
    
    /// Initialize an NSAttributedString with a format String, Typesetting, and list of String/Attribute Transformer arguments
    /// - Parameters:
    ///  - format : A format string containing `%@` object formatting characters
    ///  - typesetting: Base `Typesetting` to apply to the string
    ///  - arguments : An array of strings and `AttributeTransformer`s to replace in each format
    public convenience init(format formatString: String, typesetting: Typesetting,
                            _ arguments: (string: String, modifier: AttributeTransformer)... ) {
        let formatAttributedString = NSAttributedString(string: formatString, typesetting: typesetting)
        let attributedArguments = arguments.map(
            {NSAttributedString(string: $0.string,
                                attributes: $0.modifier(transform: typesetting.attributes)) })
        self.init(format: formatAttributedString, arguments: attributedArguments)
    }

    /// Initialize an NSAttributedString with a format String, Typesetting, and list of String/Typesetting arguments
    ///
    /// - Parameters :
    ///  - format : A format string containing `%@` object formatting characters
    ///  - typesetting: Base `Typesetting` to apply to the string
    ///  - arguments: An array of strings and `Typesetting`s to replace in each format
    public convenience init(format formatString: String, typesetting: Typesetting,
                            _ arguments: (text: String, typesetting: Typesetting)...) {
        let formatAttributedString = NSAttributedString(string: formatString, typesetting: typesetting)
        let attributedArguments = arguments.map({
            NSAttributedString(string: $0.text, attributes: $0.typesetting.attributes)
        })
        
        self.init(format: formatAttributedString, arguments: attributedArguments)
    }
    
    /// Initialize an `NSAttributedString` with a format String, Typesetting, and list of String/Keypath<TypeSetting> arguments
    /// - Parameters:
    ///  - format : A format string containing %@ object formatting characters
    ///  - typesetting: Base Typesetting to apply to the string
    ///  - arguments : An array of strings and key paths to replace in each format
    public convenience init(format formatString: String, typesetting: Typesetting,
                            _ arguments: (text: String, modifier: KeyPath<Typesetting, Typesetting>)...) {
        let formatAttributedString = NSAttributedString(string: formatString, typesetting: typesetting)
        let attributedArguments = arguments.map({
            NSAttributedString(string: $0.text, attributes: typesetting[keyPath: $0.modifier].attributes)
        })
        
        self.init(format: formatAttributedString, arguments: attributedArguments)
    }
    
    /// Initialize an NSAttributedString object initialized with a given string and Typesetting
    /// - Parameters :
    ///  - string : The string for the new attributed string
    ///  - typesetting : Base `Typesetting` to apply to the string
    public convenience init(string: String, typesetting: Typesetting) {
        self.init(string: string, attributes: typesetting.attributes)
    }
}
