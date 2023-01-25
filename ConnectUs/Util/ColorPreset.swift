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
            return #colorLiteral(red: 0.1431817412, green: 0.1622395217, blue: 0.2208084464, alpha: 1)
        case .accent00:
            return #colorLiteral(red: 0.9673457742, green: 0.5055060983, blue: 0.3958424926, alpha: 1)
        case .accent01:
            return #colorLiteral(red: 0.9437445998, green: 0.2548723221, blue: 0.0589184165, alpha: 1)
        case .accent02:
            return #colorLiteral(red: 0.01202793699, green: 0.7643800974, blue: 0.9986861348, alpha: 1)
        }
    }
}
