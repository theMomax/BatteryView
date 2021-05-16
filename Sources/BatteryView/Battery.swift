//
//  Battery.swift
//  
//
//  Created by Max Obermeier on 12.05.21.
//

import SwiftUI


/// A `BatteryView` that is based on a `Binding` to `BatteryStyleConfiguration`.
public struct Battery: BatteryView {
    private static var defaultStyle: AnyBatteryStyle = AnyBatteryStyle(ColoredSFSymbolStyle())
    
    @Environment(\.batteryStyle) private var style
    
    @Binding private var configuration: BatteryStyleConfiguration
    
    public var body: some View {
        (self.style ?? Self.defaultStyle).makeBody(configuration: self.configuration)
    }
}

public extension Battery {
    /// Initialize a `Battery` with a `Binding<BatteryStyleConfiguration>` directly.
    init(_ configuration: Binding<BatteryStyleConfiguration>) {
        self._configuration = configuration
    }
    
    /// Initialize a `Battery` with a constant `BatteryStyleConfiguration`.
    init(_ configuration: BatteryStyleConfiguration) {
        self._configuration = .constant(configuration)
    }
    
    /// Initialize a `Battery` with `Binding`s to `BatteryStyleConfiguration`'s properties.
    init(_ level: Binding<Float>, _ state: Binding<BatteryState> = .constant(.unplugged), _ mode: Binding<BatteryMode> = .constant(.normal)) {
        self.init(Binding(level, state, mode))
    }
}

public struct SystemBattery: BatteryView {
    private static var defaultStyle: AnyBatteryStyle = AnyBatteryStyle(ColoredSFSymbolStyle())
    
    @Environment(\.batteryStyle) private var style
    
    @State private var configuration: BatteryStyleConfiguration = BatteryStyleConfiguration(level: 0.0, state: .unknown, mode: .normal)
    
    private let levelPublisher = NotificationCenter.default.publisher(for: UIDevice.batteryLevelDidChangeNotification)
    
    private let statePublisher = NotificationCenter.default.publisher(for: UIDevice.batteryStateDidChangeNotification)
    
    private let modePublisher = NotificationCenter.default.publisher(for: Notification.Name.NSProcessInfoPowerStateDidChange)
    
    public init() {}
    
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
}



// MARK: Demo View
struct BatteryDemo: View {
    @State var level: Float = 1.0
    @State var state: BatteryState = .unplugged
    @State var mode: BatteryMode = .normal
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Battery(Binding($level, $state, $mode))
                    .frame(width: 30)
            }
            Spacer()
            Battery(Binding($level, $state, $mode))
                .frame(width: 200)
                
            Spacer()
            Text("Level")
            Slider(value: $level, in: 0...1.0)
                .padding(.bottom)
                .padding(.bottom)
            Text("State")
            Picker("State", selection: $state) {
                ForEach([BatteryState.unknown, .unplugged, .charging, .full], id: \.self) { value in
                    Text(value.rawValue)
                        .tag(value)
                }
            }.pickerStyle(SegmentedPickerStyle())
            .padding(.bottom)
            Text("Mode")
            Picker("Mode", selection: $mode) {
                ForEach([BatteryMode.normal, BatteryMode.lowPower], id: \.self) { value in
                    Text(value.rawValue)
                        .tag(value)
                }
            }.pickerStyle(SegmentedPickerStyle())
        }.padding()
        .padding()
    }
}
