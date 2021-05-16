//
//  View+BatteryStyle.swift
//  
//
//  Created by Max Obermeier on 12.05.21.
//

import SwiftUI

extension View {
    /// Sets the style for `BatteryView`s within the environment of `self`.
    public func batteryStyle<S>(_ style: S) -> some View where S : BatteryStyle {
        self.environment(\.batteryStyle, AnyBatteryStyle(style))
    }
    
    /// Sets the style for `Battery` within the environment of `self`.
    /// - Note: use `.batteryStyle(nil)` to reset the `BatteryStyle` to each
    ///   `BatteryView`'s default value.
    public func batteryStyle(_ style: AnyBatteryStyle?) -> some View {
        self.environment(\.batteryStyle, style)
    }
}
