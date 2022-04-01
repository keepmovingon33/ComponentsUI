//
//  BaseInputField+Style.swift
//  BaseComponent
//
//  Created by sky on 3/31/22.
//

import Foundation
import UIKit

public enum InputState {
    case blank
    case focus
    case lostFocus
    case error
    
    func getInputColor() -> UIColor {
        switch self {
            // blank van return mau den nhung vi minh chi display placeholder nen ko quan trong
        case .blank, .lostFocus:
            return BaseColor.Grey.grey_100
        case .focus:
            return BaseColor.Indigo.indigo_50
        case .error:
            return BaseColor.Denotive.red_50
        }
    }
    
    func getTitleColor(input: String?) -> UIColor {
        switch self {
        case .blank:
            return UIColor.clear
        case .focus:
            return BaseColor.Indigo.indigo_50
        case .lostFocus:
            return BaseColor.Grey.grey_50
        case .error:
            if let text = input, !text.isEmpty {
                return BaseColor.Denotive.red_50
            } else {
                return .clear
            }
        }
    }
    
    func getInputPlaceholder(input: String?) -> Typesetting? {
        switch self {
        case .blank:
            return Typesetting.smallTitle.at(color: BaseColor.Grey.grey_50)
        case .focus, .lostFocus:
            return nil
        case .error:
            if isInputEmpty(input: input) {
                return Typesetting.smallTitle.at(color: BaseColor.Grey.grey_50)
            } else {
                return nil
            }
        }
    }
    
    func isInputEmpty(input: String?) -> Bool {
        guard let input = input, !input.isEmpty else { return true }
        return false
    }
    
    // if input field is not empty && state is either focus or error -> show clear button. Otherwise, don't show clear button
    func isHiddenClearButton(input: String?) -> Bool {
        guard !isInputEmpty(input: input) else { return true }
        return self == .lostFocus || self == .blank
    }
    
    func getClearButtonColor() -> UIColor {
        switch self {
        case .blank, .lostFocus:
            return .clear
        case .focus:
            return BaseColor.Grey.grey_100
        case .error:
            return BaseColor.Denotive.red_50
        }
    }
}

