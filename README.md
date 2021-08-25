[![license MIT](https://badgen.net/badge/license/MIT/green)](LICENSE)
![swift 5.3](https://badgen.net/badge/swift/5.3/orange)
![iOS 14](https://badgen.net/badge/iOS/14/gray)
![macOS 11](https://badgen.net/badge/macOS/11/gray)
![tvOS 13](https://badgen.net/badge/tvOS/13/gray)
![watchOS 6](https://badgen.net/badge/watchOS/6/gray)
![PRs welcome](https://badgen.net/badge/PRs/welcome/green)

# BatteryView

A library featuring simple, animated battery icons written in SwiftUI.

<div style="text-align:center"><img width="280" alt="Screen Shot 2021-08-24 at 18 05 58" src="https://user-images.githubusercontent.com/21169289/130648989-f8519766-d9cc-409b-8cbb-51cfe05949e4.gif"></div>

## Usage

A `Battery` can be initialized using `Binding`s to its core properties.

```swift
struct BatteryDemo: View {
    @State var level: Float = 1.0
    @State var state: BatteryState = .full
    @State var mode: BatteryMode = .normal
    
    var body: some View {
        Battery($level, $state, $mode)
            .frame(width: 30)
    }
}
```

You can set the `BatteryStyle` from the outside:

```swift
VStack {
    BatteryDemo()
        .batteryStyle(SFSymbolStyle(Monochrome())) // uses monochrome SFSymbolStyle
    BatteryDemo() // uses normal SFSymbolStyle
}.batteryStyle(SFSymbolStyle())
```

There is also a standalone `SystemBattery` for iOS, that shows the device's battery level, state, and mode:

```swift
SystemBattery()
```

## Styles

There is only one style yet, but feel free to open a PR if you have implemented a new one!

### `SFSymbolStyle`

This style mimics the `"battery"` SF Symbol at regular thickness, but can display any battery level. There is a colorful, monochrome, and black/white only configuration.

| `Multicolor` (light mode)  | `Monochrome` (light mode)  | `Monochrome` (dark mode)  | `Absolute` (light mode)  |
|---|---|---|---|
| ![](https://user-images.githubusercontent.com/21169289/130649303-b8bf537f-5b2c-46cd-a030-89a2cde98a2d.png)  | ![](https://user-images.githubusercontent.com/21169289/130651403-54c09c9a-500f-4f11-8d92-271c6db27e2b.png)  | ![](https://user-images.githubusercontent.com/21169289/130651580-a531176c-248e-42ad-8dc1-05744be7587c.png)  | ![](https://user-images.githubusercontent.com/21169289/130651588-eaff2ce4-382a-46d5-babb-7d093ce5d26f.png)  |


