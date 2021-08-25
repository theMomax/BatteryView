//
//  BatteryStyleConfiguration.swift
//  
//
//  Created by Max Obermeier on 12.05.21.
//

import SwiftUI

/// `BatteryStyleConfiguration` holds the complete status of a battery.
public struct BatteryStyleConfiguration {
    /// The battery-level from `0.0` to `1.0`
    public let level: Float
    /// The battery's charging state.
    public let state: BatteryState
    /// The battery's power mode.
    public let mode: BatteryMode
}

/// `BatteryState` describes the charging state of a battery.
public enum BatteryState: String, Equatable {
    case unknown
    case unplugged
    case charging
    case full
}

/// `BatteryMode` describes the power mode of a battery.
public enum BatteryMode: String, Equatable {
    case normal
    case lowPower = "low power"
}

public extension Binding where Value == BatteryStyleConfiguration {
    /// Create a `Binding<BatteryStyleConfiguration>` from `Binding`s to `BatteryStyleConfiguration`'s properties.
    init(_ level: Binding<Float>, _ state: Binding<BatteryState> = .constant(.unplugged), _ mode: Binding<BatteryMode> = .constant(.normal)) {
        self = Binding(get: {
            BatteryStyleConfiguration(level: level.wrappedValue, state: state.wrappedValue, mode: mode.wrappedValue)
        }, set: { newValue in
            level.wrappedValue = newValue.level
            state.wrappedValue = newValue.state
            mode.wrappedValue = newValue.mode
        })
    }
}

#if os(iOS)
public extension BatteryState {
    /// Converts from the system's `BatteryState` to this package's
    /// `BatteryState`.
    init(_ state: UIDevice.BatteryState) {
        switch state {
        case .unknown:
            self = .unknown
        case .unplugged:
            self = .unplugged
        case .charging:
            self = .charging
        case .full:
            self = .full
        @unknown default:
            self = .unknown
        }
    }
}
#endif
