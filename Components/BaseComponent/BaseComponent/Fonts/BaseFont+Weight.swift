//
//  TymeFont+Weight.swift
//  TymeComponent
//
//  Created by Duy Le on 29/11/2021.
//

import UIKit

extension BaseFont {
    
    /// All possible font weights for Font
    public enum Weight: String, CaseIterable {
        case light = "Light"
        case regular = "Regular"
        case medium = "Medium"
        case semiBold = "SemiBold"
        case heavy = "Heavy"
        
        public init(value: CGFloat) {
            switch value {
            case ...300:
                self = .light
            case ...400:
                self = .regular
            case ...500:
                self = .medium
            case ...600:
                self = .semiBold
            case ...800:
                self = .heavy
            default:
                self = .regular
            }
        }
        
        /// The name of the font at the specified weight
        func getFontName(with name: String) -> String {
            return "\(name)-\(self.rawValue)"
        }
    }
}
