//
//  Multicolor.swift
//
//
//  Created by Max Obermeier on 24.08.21.
//

import SwiftUI

/// A colorful ``ColorConfiguration`` designed for ``SFSymbolStyle``.
///
/// With these colors and dark mode the ``SFSymbolStyle`` almost exactly matches the iOS battery indicator
/// on the home screen's upper right corner.
public struct Multicolor: ColorConfiguration {
    private let warningLevel: Float
    
    public init(warningLevel: Float = 0.2) {
        self.warningLevel = warningLevel
    }
    
    public func primary(for configuration: BatteryStyleConfiguration) -> Color {
        .primary
    }
    
    public func secondary(for configuration: BatteryStyleConfiguration) -> Color {
        if configuration.state == .unknown {
            return .gray
        }
        
        switch configuration.mode {
        case .lowPower:
            return .yellow
        case .normal:
            break
        }
        
        switch configuration.state {
        case .charging, .full:
            return .green
        default:
            break
        }
        
        if configuration.level <= self.warningLevel {
            return .red
        }
        
        return .primary
    }
    
    public func tertiary(for configuration: BatteryStyleConfiguration) -> Color {
        .primary.opacity(0.5)
    }
}
