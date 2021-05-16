//
//  Environment+BatteryStyle.swift
//  
//
//  Created by Max Obermeier on 12.05.21.
//

import Foundation

import SwiftUI

extension EnvironmentValues {
    var batteryStyle: AnyBatteryStyle? {
        get {
            return self[BatteryStyleKey.self]
        }
        set {
            self[BatteryStyleKey.self] = newValue
        }
    }
}
