//
//  SFSymbolWideStyle.swift
//
//
//  Created by Max Obermeier on 07.09.21.
//

import SwiftUI

/// A ``BatteryStyle`` that closely resembles battery-icons available in the SF Symbols icon set, but `state` and
/// `mode` are indicated using colors.
///
/// - Note: This style is a lot simpler than ``SFSymbolStyle`` and does not make use of masking. Thus is can be used
/// in combination with WidgetKit, which is currently not possible with ``SFSymbolStyle``.
public struct SFSymbolWideStyle: BatteryStyle {
    private let color: ColorConfiguration
    
    private let animation: Animation?
    
    /// Initialize a ``SFSymbolWideStyle`` using the given configuration options.
    ///
    /// - Parameters:
    ///     -  ``warningLevel``: below this battery level, the color changes to red
    ///     - ``animation``: the `Animation` used to smoothen changes in the battery's configuration
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
        HStack(spacing: 0) {
            ZStack(alignment: .leading) {
                Image(systemName: "battery.0")
                    .font(Font.custom("SFUIDisplay-Light", size: 200 * (w/294)))
                    .foregroundColor(color.tertiary(for: configuration))
                RoundedRectangle(cornerRadius: w * 0.040, style: .continuous)
                    .frame(width: CGFloat(Float(w) * 0.68 * configuration.level), height: w * 0.276, alignment:  .leading)
                    .foregroundColor(color.secondary(for: configuration))
                    .animation(animation)
                    .offset(x: w * 0.18)
            }
            if configuration.state == .charging || configuration.state == .full {
                Image(systemName: "bolt.fill")
                    .font(Font.custom("SFUIDisplay-Light", size: 120 * (w/294)))
                    .foregroundColor(color.primary(for: configuration))
            }
        }
    }
}

struct SFSymbolWideStyle_Previews: PreviewProvider {
        
    static let opacity = 1.0
    
    static var previews: some View {
        Group {
            BatteryDemo()
                .background(Color.white)
        }.batteryStyle(SFSymbolWideStyle())
        .preferredColorScheme(.light)
        
        
        Group {
            BatteryDemo()
                .background(Color.black)
        }.batteryStyle(SFSymbolWideStyle())
        .preferredColorScheme(.dark)
        Group {
            VStack {
                ForEach(1..<8) { i in
                    Self.instance(width: 294/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: false)
                }

            }
        }.batteryStyle(SFSymbolWideStyle())
        Group {
            ScrollView {
                ForEach(1..<10) { i in
                    Self.instance(width: 294/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: false)
                }
            }
        }.batteryStyle(SFSymbolWideStyle())
        Group {
            VStack {
                ForEach(1..<8) { i in
                    Self.instance(width: 294/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: true)
                }

            }
        }.batteryStyle(SFSymbolWideStyle())
        Group {
            ScrollView {
                ForEach(1..<10) { i in
                    Self.instance(width: 294/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: true)
                }
            }
        }.batteryStyle(SFSymbolWideStyle())
        Group {
            VStack {
                ForEach(1..<8) { i in
                    Self.instance(width: 600/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: true)
                }

            }
        }.batteryStyle(SFSymbolWideStyle())
        Group {
            ScrollView {
                ForEach(1..<10) { i in
                    Self.instance(width: 600/pow(CGFloat(1.5), CGFloat(i)), height: 200/pow(CGFloat(1.5), CGFloat(i)), withOverlay: true)
                }
            }
        }.batteryStyle(SFSymbolWideStyle())
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

