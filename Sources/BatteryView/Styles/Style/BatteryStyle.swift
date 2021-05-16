//
//  BatteryStyle.swift
//  
//
//  Created by Max Obermeier on 12.05.21.
//

import SwiftUI

/// A `BatteryStyle` provides logic to convert a `BatteryStyleConfiguration` to a `View`.
public protocol BatteryStyle {
    associatedtype Body: View
    
    func makeBody(configuration: Self.Configuration) -> Self.Body
    
    typealias Configuration = BatteryStyleConfiguration
}
