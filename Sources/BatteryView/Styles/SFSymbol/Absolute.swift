//
//  Absolute.swift
//
//
//  Created by Max Obermeier on 24.08.21.
//

import SwiftUI

/// A monochromatic ``ColorConfiguration`` designed for ``SFSymbolStyle`` with no shades.
public struct Absolute: ColorConfiguration {
    public func primary(for configuration: BatteryStyleConfiguration) -> Color {
        .primary
    }
    
    public func secondary(for configuration: BatteryStyleConfiguration) -> Color {
        .primary
    }
    
    public func tertiary(for configuration: BatteryStyleConfiguration) -> Color {
        .primary
    }
}
