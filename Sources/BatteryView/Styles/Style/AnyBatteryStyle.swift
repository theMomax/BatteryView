//
//  AnyBatteryStyle.swift
//  
//
//  Created by Max Obermeier on 12.05.21.
//

import SwiftUI

/// A type-erased wrapper around `BatteryStyle`
public struct AnyBatteryStyle: BatteryStyle {
    public typealias Body = AnyView
    
    private let styleMakeBody: (BatteryStyle.Configuration) -> AnyView
        
    init<S: BatteryStyle>(_ style: S) {
        self.styleMakeBody = style.makeTypeErasedBody
    }
    
    public func makeBody(configuration: BatteryStyle.Configuration) -> AnyView {
        self.styleMakeBody(configuration)
    }
}

fileprivate extension BatteryStyle {
    func makeTypeErasedBody(configuration: BatteryStyle.Configuration) -> AnyView {
        AnyView(makeBody(configuration: configuration))
    }
}
