//
//  AppColor.swift
//  Stocks
//
//  Created by Naresh on 08/09/2024.
//

import SwiftUI

enum AppColor {
    
    case green
    case red
    case lightGray
    case darkBlue
    case gray
    case black
    
    var color: Color {
        switch self {
        case .green:
            Color(uiColor: UIColor(hex: 0x00A878))
        case .red:
            Color(uiColor: UIColor(hex: 0xFE5E41))
        case .lightGray:
            Color(uiColor: UIColor(hex: 0xF5F7F8))
        case .darkBlue:
            Color(uiColor: UIColor(hex: 0x173B45))
        case .gray:
            Color(uiColor: UIColor(hex: 0x939185))
        case .black:
            Color(uiColor: UIColor(hex: 0x393E46))
            
        }
    }
}


extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex >> 16) & 0xff) / 255
        let g = CGFloat((hex >> 08) & 0xff) / 255
        let b = CGFloat((hex >> 00) & 0xff) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
