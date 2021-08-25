//
//  SFSymbolStyle.swift
//  
//
//  Created by Max Obermeier on 12.05.21.
//

import SwiftUI

/// A `BatteryStyle` that closely resembles battery-icons available in the SF Symbols icon set, but `state` and
/// `mode` are indicated using colors.
public struct SFSymbolStyle: BatteryStyle {
    private let color: ColorConfiguration
    
    private let animation: Animation?
    
    /// Initialize a `SFSymbolStyle` using the given configuration options.
    /// - `warningLevel`: below this battery level, the color changes to red
    /// - `animation`: the `Animation` used to smoothen changes in the battery's configuration
    public init(_ colorConfiguration: ColorConfiguration = Multicolor(), animation: Animation? = .spring()) {
        self.color = colorConfiguration
        self.animation = animation
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        GeometryReader { gp in
            let w = min(gp.size.width, gp.size.height * 2.15)
            ZStack(alignment: .leading) {
                self.innerBody(configuration: configuration, w: w)
            }
            .frame(width: w, height: w/2.15, alignment: .center)
        }
        .aspectRatio(2.15, contentMode: .fit)
    }
    
    func innerBody(configuration: Configuration, w: CGFloat) -> some View {
        ZStack(alignment: .leading) {
            Image(systemName: "battery.0")
                .font(Font.custom("SFUIDisplay-Light", size: 200 * (w/294)))
                .foregroundColor(color.tertiary(for: configuration))
            RoundedRectangle(cornerRadius: w * 0.040, style: .continuous)
                .frame(width: CGFloat(Float(w) * 0.688 * configuration.level), height: w * 0.276, alignment:  .leading)
                .foregroundColor(color.secondary(for: configuration))
                .animation(animation)
                .offset(x: w * 0.18)
        }
        .mask(
            ZStack {
                Color.white
                Image(systemName: "battery.100").font(Font.custom("SFUIDisplay-Light", size: 200 * (w/294)))
                    .foregroundColor(.black)
            }
            .compositingGroup()
            .colorInvert()
            .luminanceToAlpha()
        )
        .withBolt(if: configuration.state == .charging || configuration.state == .full, sized: w, colored: color.primary(for: configuration))
    }
}

struct ColoredSFSymbolStyle_Previews: PreviewProvider {
        
    static let opacity = 1.0
    
    static var previews: some View {
        Group {
            BatteryDemo()
                .background(Color.white)
        }.batteryStyle(SFSymbolStyle())
        .preferredColorScheme(.light)
        
        
        Group {
            BatteryDemo()
                .background(Color.black)
        }.batteryStyle(SFSymbolStyle())
        .preferredColorScheme(.dark)
        Group {
            VStack {
                ForEach(1..<8) { i in
                    Self.instance(width: 294/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: false)
                }

            }
        }.batteryStyle(SFSymbolStyle())
        Group {
            ScrollView {
                ForEach(1..<10) { i in
                    Self.instance(width: 294/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: false)
                }
            }
        }.batteryStyle(SFSymbolStyle())
        Group {
            VStack {
                ForEach(1..<8) { i in
                    Self.instance(width: 294/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: true)
                }

            }
        }.batteryStyle(SFSymbolStyle())
        Group {
            ScrollView {
                ForEach(1..<10) { i in
                    Self.instance(width: 294/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: true)
                }
            }
        }.batteryStyle(SFSymbolStyle())
        Group {
            VStack {
                ForEach(1..<8) { i in
                    Self.instance(width: 600/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: true)
                }

            }
        }.batteryStyle(SFSymbolStyle())
        Group {
            ScrollView {
                ForEach(1..<10) { i in
                    Self.instance(width: 600/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: true)
                }
            }
        }.batteryStyle(SFSymbolStyle())
    }
    
    static func instance(width: CGFloat, height: CGFloat, withOverlay: Bool = false) -> some View {
        VStack {
            ZStack {
                if withOverlay {
                    Image(systemName: "battery.100.bolt").font(Font.custom("SFUIDisplay-Light", size: 200.0 * (min(width, height * 2.15)/294.0)))
                        .foregroundColor(.red)
                }
                Battery(Binding(.constant(1.0), .constant(.unplugged), .constant(.normal)))
                    .opacity(Self.opacity)
                    .frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }.border(Color.green, width: 1)
        }
    }
}
