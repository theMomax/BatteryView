//
//  ColorConfiguration.swift
//
//
//  Created by Max Obermeier on 24.08.21.
//

import SwiftUI

/// A type that defines color mappings for ``BatteryStyleConfiguration``s.
///
/// ``ColorConfiguration``s are usually used to configure ``BatteryStyle``s.
public protocol ColorConfiguration {
    /// The color for primary elements in the ``BatteryStyle``'s visualization, e.g. small icons that indicate charging.
    func primary(for configuration: BatteryStyleConfiguration) -> Color
    
    /// The color for secondary elements in the ``BatteryStyle``'s visualization, usually the background of the battery.
    func secondary(for configuration: BatteryStyleConfiguration) -> Color
    
    /// The color for tertiary elements in the ``BatteryStyle``'s visualization, e.g. outlines.
    func tertiary(for configuration: BatteryStyleConfiguration) -> Color
}
