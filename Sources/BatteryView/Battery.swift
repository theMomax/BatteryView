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
