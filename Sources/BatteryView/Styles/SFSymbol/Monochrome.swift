//
//  Monochrome.swift
//
//
//  Created by Max Obermeier on 24.08.21.
//

import SwiftUI

/// A monochromatic ``ColorConfiguration`` designed for ``SFSymbolStyle``.
public struct Monochrome: ColorConfiguration {
    private let colorScheme: ColorScheme
    
    public init(_ colorScheme: ColorScheme) {
        self.colorScheme = colorScheme
    }
    
    public func primary(for configuration: BatteryStyleConfiguration) -> Color {
        .primary
    }
    
    public func secondary(for configuration: BatteryStyleConfiguration) -> Color {
        if configuration.state == .unknown {
            return .primary.opacity(0.5)
        }
        
        switch configuration.mode {
        case .normal:
            return .primary
        case .lowPower:
            if colorScheme == .light {
                return Color(white: 0.25)
            } else {
                return Color(white: 0.75)
            }
        }
    }
    
    public func tertiary(for configuration: BatteryStyleConfiguration) -> Color {
        .primary.opacity(0.5)
    }
}
