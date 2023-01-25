//
//  ColorHelper.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/24.
//

import UIKit

enum ColorPreset: CaseIterable {
    case background
    case accent00
    case accent01
    case accent02
    
    var colors: UIColor {
        switch self {
        case .background:
            return #colorLiteral(red: 0.2898363471, green: 0.3367882371, blue: 0.35048002, alpha: 1)
        case .accent00:
            return #colorLiteral(red: 0.9950535893, green: 0.7137610316, blue: 0.007481636479, alpha: 1)
        case .accent01:
            return #colorLiteral(red: 0.9437445998, green: 0.2548723221, blue: 0.0589184165, alpha: 1)
        case .accent02:
            return #colorLiteral(red: 0.01202793699, green: 0.7643800974, blue: 0.9986861348, alpha: 1)
        }
    }
}
