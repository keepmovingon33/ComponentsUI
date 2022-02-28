//
//  UIImage_Extension.swift
//  BaseComponent
//
//  Created by sky on 2/28/22.
//

import UIKit

public class ImageProvider {
    public static func image(named: String) -> UIImage? {
        return UIImage(named: named, in: Bundle(for: self), compatibleWith: nil)
    }
}

