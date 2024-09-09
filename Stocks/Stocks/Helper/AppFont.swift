//
//  AppFont.swift
//  Stocks
//
//  Created by Naresh on 08/09/2024.
//

import SwiftUI

enum AppFont {
    /// For each font family in the app we can create corresponding enum.
    enum SFPro {
        /// This will create a font with regular face and the size we can pass at runtime.
        case regular(CGFloat)
        /// This will create a font with bold face and the size we can pass at runtime.
        case bold(CGFloat)
        /// This will create a font with medium face and the size we can pass at runtime.
        case medium(CGFloat)
        
        var font: Font {
            switch self {
            case .bold(let size):
                    .custom("SFPro-Bold", size: size)
            case .regular(let size):
                    .custom("SFPro-Regular", size: size)
            case .medium(let size):
                    .custom("SFPro-Medium", size: size)
            }
        }
    }
}
