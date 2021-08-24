//
//  BoltModifier.swift
//
//
//  Created by Max Obermeier on 24.08.21.
//

import SwiftUI

struct SFBoltModifier: ViewModifier {
    let width: CGFloat
    let color: Color
    
    func body(content: Content) -> some View {
        print(Color.primary)
        return ZStack(alignment: .leading) {
            content.mask(
                ZStack {
                    Color.white
                    Image(systemName: "battery.100.bolt").font(Font.custom("SFUIDisplay-Light", size: 200 * (width/294)))
                        .foregroundColor(.black)
                }
                .compositingGroup()
                .colorInvert()
                .luminanceToAlpha()
            )

            Image(systemName: "bolt.fill")
                .foregroundColor(.primary)
                .font(Font.custom("SFUIDisplay-Light", size: 200 * (width/294)))
                .scaleEffect(0.6)
                .offset(x: 0.2 * width)
        }
    }
}

extension View {
    func withBolt(if enabled: Bool = true, sized width: CGFloat, colored color: Color = .primary) -> AnyView {
        if enabled {
            return AnyView(self.modifier(SFBoltModifier(width: width, color: color)))
        } else {
            return AnyView(self)
        }
    }
}
