//
//  SystemBattery.swift
//  
//
//  Created by Max Obermeier on 16.05.21.
//

import SwiftUI

public struct SystemBattery: BatteryView {
    private static var defaultStyle: AnyBatteryStyle = AnyBatteryStyle(ColoredSFSymbolStyle())
    
    @Environment(\.batteryStyle) private var style
    
    @State private var configuration: BatteryStyleConfiguration = BatteryStyleConfiguration(level: 0.0, state: .unknown, mode: .normal)
    
    private let levelPublisher = NotificationCenter.default.publisher(for: UIDevice.batteryLevelDidChangeNotification)
    
    private let statePublisher = NotificationCenter.default.publisher(for: UIDevice.batteryStateDidChangeNotification)
    
    public init() {
        NotificationCenter.default.addObserver(forName: Notification.Name.NSProcessInfoPowerStateDidChange, object: nil, queue: nil, using: self.onStatusUpdate)
    }
    
    public var body: some View {
        (self.style ?? Self.defaultStyle).makeBody(configuration: configuration)
            .onAppear {
                UIDevice.current.isBatteryMonitoringEnabled = true
                self.loadData()
            }
            .onDisappear {
                UIDevice.current.isBatteryMonitoringEnabled = false
            }
            .onReceive(levelPublisher) { (output) in
                self.loadData()
            }
            .onReceive(statePublisher) { (output) in
                self.loadData()
            }
    }
    
    private func loadData() {
        self.configuration = BatteryStyleConfiguration(level: UIDevice.current.batteryLevel, state: BatteryState(UIDevice.current.batteryState), mode: ProcessInfo.processInfo.isLowPowerModeEnabled ? .lowPower : .normal)
    }
    
    func onStatusUpdate(_ notification: Notification) {
        loadData()
    }
}
