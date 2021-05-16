//
//  ColoredSFSymbolStyle.swift
//  
//
//  Created by Max Obermeier on 12.05.21.
//

import SwiftUI

/// A `BatteryStyle` that closely resembles battery-icons available in the SF Symbols icon set, but `state` and
/// `mode` are indicated using colors.
public struct ColoredSFSymbolStyle: BatteryStyle {
    
    private let warningLevel: Float
    
    private let animation: Animation?
    
    /// Initialize a `ColoredSFSymbolStyle` using the given configuration options.
    /// - `warningLevel`: below this battery level, the color changes to red
    /// - `animation`: the `Animation` used to smoothen changes in the battery's configuration
    public init(warningLevel: Float = 0.2, animation: Animation? = .spring()) {
        self.warningLevel = warningLevel
        self.animation = animation
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        GeometryReader { gp in
            let w = min(gp.size.width, gp.size.height * 2.15)
            ZStack(alignment: .leading) {
                Self.innerBody(configuration: configuration, w: w, color: self.color(for: configuration), animation: self.animation)
            }
            .frame(width: w, height: w/2.15, alignment: .center)
        }
        .aspectRatio(2.15, contentMode: .fit)
    }
    
    static func innerBody(configuration: Configuration, w: CGFloat, color: Color, animation: Animation?) -> some View {
        ZStack(alignment: .leading) {
            Image(systemName: "battery.0").font(Font.custom("SFUIDisplay-Light", size: 200 * (w/294)))
                .foregroundColor(.gray)
            RoundedRectangle(cornerRadius: w * 0.040, style: .continuous)
                .frame(width: CGFloat(Float(w) * 0.688 * configuration.level), height: w * 0.276, alignment:  .leading)
                .foregroundColor(color)
                .animation(animation)
                .offset(x: w * 0.18)
        }
    }
    
    private func color(for configuration: Configuration) -> Color {
        switch configuration.mode {
        case .lowPower:
            return .yellow
        case .normal:
            break
        }
        
        switch configuration.state {
        case .charging, .full:
            return .green
        default:
            break
        }
        
        if configuration.level <= self.warningLevel {
            return .red
        }
        
        return .primary
    }
}

struct ColoredSFSymbolStyle_Previews: PreviewProvider {
        
    static let opacity = 1.0
    
    static var previews: some View {
        Group {
            BatteryDemo()
        }.batteryStyle(ColoredSFSymbolStyle())
        Group {
            SystemBattery()
                .padding()
                .padding()
        }.batteryStyle(ColoredSFSymbolStyle())
        Group {
            VStack {
                ForEach(1..<8) { i in
                    Self.instance(width: 294/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: false)
                }
                
            }
        }.batteryStyle(ColoredSFSymbolStyle())
        Group {
            ScrollView {
                ForEach(1..<10) { i in
                    Self.instance(width: 294/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: false)
                }
            }
        }.batteryStyle(ColoredSFSymbolStyle())
        Group {
            VStack {
                ForEach(1..<8) { i in
                    Self.instance(width: 294/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: true)
                }
                
            }
        }.batteryStyle(ColoredSFSymbolStyle())
        Group {
            ScrollView {
                ForEach(1..<10) { i in
                    Self.instance(width: 294/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: true)
                }
            }
        }.batteryStyle(ColoredSFSymbolStyle())
        Group {
            VStack {
                ForEach(1..<8) { i in
                    Self.instance(width: 600/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: true)
                }
                
            }
        }.batteryStyle(ColoredSFSymbolStyle())
        Group {
            ScrollView {
                ForEach(1..<10) { i in
                    Self.instance(width: 600/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: true)
                }
            }
        }.batteryStyle(ColoredSFSymbolStyle())
    }
    
    static func instance(width: CGFloat, height: CGFloat, withOverlay: Bool = false) -> some View {
        VStack {
            ZStack {
                if withOverlay {
                    Image(systemName: "battery.100").font(Font.custom("SFUIDisplay-Light", size: 200.0 * (min(width, height * 2.15)/294.0)))
                        .foregroundColor(.red)
                }
                Battery(Binding(.constant(1.0), .constant(.unplugged), .constant(.normal)))
                    .opacity(Self.opacity)
                    .frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }.border(Color.green, width: 1)
        }
    }
}
