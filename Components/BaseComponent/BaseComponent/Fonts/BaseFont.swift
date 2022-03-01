// swiftlint:disable all
//
//  TymeFont.swift
//  ios-ui-components
//
//  Created by Phong Le on 16/04/2021.
//

import UIKit
import Foundation

public enum BaseFontName: String, CaseIterable {
    case SFProDisplay = "SFProDisplay"
    case SFProText = "SFProText"
    case ocrABT = "OCRAbyBT"
}

public enum BaseFont: String, CaseIterable {
    case SFProDisplayLight = "SFProDisplay-Light"
    case SFProDisplayRegular = "SFProDisplay-Regular"
    case SFProDisplayMedium = "SFProDisplay-Medium"
    case SFProDisplaySemiBold = "SFProDisplay-Semibold"
    case SFProDisplayHeavy = "SFProDisplay-Heavy"
    case SFProTextMedium = "SFProText-Medium"
    case SFProTextRegular = "SFProText-Regular"
    case SFProTextSemiBold = "SFProText-Semibold"
    case ocrABT = "OCRAbyBT-Regular"
}

extension BaseFont {
    public func withSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

open class BaseFontLoader: NSObject {
    public var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    public func loadFonts() {
        let fontNames = BaseFont.allCases
        for fontName in fontNames {
            self.loadFont(fileName: fontName.rawValue, type: ".otf")
        }
    }
    
    private func loadFont(fileName: String, type: String) {
        guard let fontURL = bundle.url(forResource: fileName, withExtension: type) else { return }
        registerFontFile(url: fontURL)
    }
    
    private func registerFontFile(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let provider = CGDataProvider(data: data as CFData)
            let font = CGFont.init(provider!)
            
            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(font!, &error) {
                let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
               NSLog("registerFontFile \(errorDescription) \n")
            }
            
        } catch {
            print("unable to load font file: \(url.absoluteString)")
        }
    }
}

extension BaseFont {
    /// Indicates whether fonts should automatically return scaled sizes when the device's `UIContentSizeCategory` is set
    public static var adjustsFontForContentSizeCategory = false
    
    // MARK: -
    
    /// Returns a UIFont at the specified weight, italicism, and size
    public static func weight(_ weight: Weight, fontName: String, size: Size) -> UIFont {
        let name = weight.getFontName(with: fontName)
        let font = UIFont(name: name, size: size.rawValue) ?? .systemFont(ofSize: size.rawValue)
        
        if #available(iOS 11.0, *), adjustsFontForContentSizeCategory, let textStyle = size.style {
            return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
        } else {
            return font
        }
    }
    
    public static func monospaced(weight: Weight, fontName: String, size: Size) -> UIFont {
        let name = weight.getFontName(with: fontName)
        let font = UIFont(name: name, size: size.rawValue) ?? .systemFont(ofSize: size.rawValue)
        
        let monospacedFontDescriptorFeatureSetting = [
            UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
            UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector
        ]
        
        let monospacedFontDescriptorAttributes = [UIFontDescriptor.AttributeName.featureSettings: [monospacedFontDescriptorFeatureSetting]]
        let monospacedFontDescriptor = font.fontDescriptor.addingAttributes(monospacedFontDescriptorAttributes)
        
        return UIFont(descriptor: monospacedFontDescriptor, size: 0)
    }
}
