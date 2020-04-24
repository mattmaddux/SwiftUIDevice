# SwiftUIDevice

Filling in some of the missing pieces of SwiftUI's environment. Get easy info about which device is being used, the status of that device, and the window you're running in.

## Installation
----------------------------------

### Swift Package Manager

1. File -> Swift Packages -> Add Package Dependency
2. Enter https://github.com/mattmaddux/SwiftUIDevice.git


### Manual

Copy the following files to your project:
- Device.swift
- DeviceEnums.swift
- OrientationExtensions.swift


## Features
----------------------------------
- [x] Device Model
- [x] Simulator Check
- [x] Aspect Ratio
- [x] iPad & iPhone Check
- [x] Device Orientation
- [x] UI Orientation
- [x] Window Size
- [x] NFC Availability
- [ ] Gyro
- [ ] VPN Status

Other ideas please add an issue.



## Accessing Device Info
----------------------------------

### Model

Check which model you're running on. Even works in simulator. Returns a custom enumeration (DeviceModel).

```swift
import SwiftUI
import SwiftUIDevice

struct ContentView: View {

    @ObservedObject var device = Device.shared

    var body: some View {
    Text("Model: \(self.device.model.rawValue)")
    }
}
```
###  Simulator

Check if you're running in a simulator. Returns a bool.


```swift
import SwiftUI
import SwiftUIDevice

struct ContentView: View {

    @ObservedObject var device = Device.shared

    var body: some View {
        VStack {
            if device.isSimulator {
                Text("I'm not real.")
            }
        }
    }
}
```

### Screen Aspect Ratio

Current iOS and iPadOS devices come in three different aspect ratios:
- Short iPhones (models with home button)
- Long iPhones (models without home button)
- iPads

Check which kind aspect ratio your device has. Returns a custom enumeration (AspectRatio)

```swift
import SwiftUI
import SwiftUIDevice

struct ContentView: View {

    @ObservedObject var device = Device.shared

    var body: some View {
        VStack {
            if device.aspectRatio == .iphoneLong {
                Text("This baby's long.")
            } else if device.aspectRatio == .iphoneShort {
                Text("A little shorter.")
            } else if device.aspectRatio == .ipad {
                Text("Closer to square.")
            }
        }
    }
}
```

### Check for iPhone or iPad

Check more generically if you're running on an iPhone or an iPad. Each return a bool.

```swift
import SwiftUI
import SwiftUIDevice

struct ContentView: View {

    @ObservedObject var device = Device.shared

    var body: some View {
        VStack {
            if device.isiPhone {
                Text("I'm in your pocket.")
            } else if device.isiPad {
                Text("Not so much.")
            }
        }
    }
}
```

### Check orientation
##### (Updates your view as it changes.)

Easily update your SwiftUI views to respond to device rotation with two properties.

#### Device Orientation

(Type alias for UIDeviceOrientation Enum)

Indicates how the device itself (not the user interface is oriented, including facing upwards or downwards).

#### UI Orientation


(Type alias for UIOrientation Enum)

Indicates how the user interface is oriented, relative to the device.

Note that if the device is rotated to the right, Device Orientation will be .landscapeRight, but UIOrientation will be .landscapeLeft. So think about which one you need.

```swift
import SwiftUI
import SwiftUIDevice

struct ContentView: View {

    @ObservedObject var device = Device.shared

    var body: some View {
        VStack {
            if device.deviceOrientation == .faceDown {
                Text("Can't see me.")
            } else if device.deviceOrientation == .faceUp {
                Text("Looking at the ceiling")
            }
            
            if device.uiOrientation == .portrait {
                Text("ʌ")
                Text("|")
                Text("|")
                Text("Front Camera")
            } else if device.uiOrientation == .landscapeLeft {
                Text("Front Camera ---->")
            } else if device.uiOrientation == .landscapeRight {
                Text("<---- Front Camera")
            } else if device.uiOrientation == .portraitUpsideDown {
                Text("Front Camera")
                Text("|")
                Text("|")
                Text("V")
            }
        }
    }
}
```

### Check Window Size
##### (Updates your view as it changes.) 

Size classes already give you basic information about the width of your window (and it's already available in the environment), but sometimes you might need more granular information for sizing. This split between devices is based on how Apple has chosen to render certain elements on different devices in different conditions (e.g. columns in master-detail nav views). Use it to make informed decisions about how to set manual widths.

In order to keep updated with changes in the window size, this is implemented as a WindowReader view, used similarly to a GeometryReader (in fact it uses GeometryReader internally to respond to changes).

WindowClass gives you four cases which break down like this:

- Very Narrow (< 650 points)
    - All iPhones in portrait
    - iPhone SE 1 in landscape
    - Slide over windows on iPad
    - iPad Mini in split view
    - Other iPads in portrait split view
- Narrow (< 1000 points)
    - Non-SE-1 iPhones in landscape
    - Non-Mini iPads in portrait split view
- Wide (< 1150 points)
    - All iPads in fullscreen portrait
    - iPad, Air, Mini, and Pro 9.7-inch in fullscreen landscape
- Very Wide (1150+ points)
    - iPad Pro 11-inch & 12.9-inch in fullscreen landscape

```swift
import SwiftUI
import SwiftUIDevice

struct ContentView: View {
    
    var body: some View {
        WindowReader { windowClass in
            Text(self.text(forClass: windowClass))
        }
    }
    
    func text(forClass windowClass: WindowClass) -> String {
        switch windowClass {
            case .veryWide: return "<----- Lots o' room here ----->"
            case .wide: return "<---- Still plenty ---->"
            case .narrow: return "<-- Getting a little tight -->"
            case .veryNarrow: return "<- Can't breathe ->"
        }
    }
    
}
```


### Check NFC Availability

Check to see if the device can scan NFC tags. Returns bool.

Note: Some early NFC iPhones (i.e. SE 1 and 6s) had NFC hardware for Apple Pay, but NFC capability is not available for your app, so this will come back false.

```swift
import SwiftUI
import SwiftUIDevice

struct ContentView: View {

    @ObservedObject var device = Device.shared

    var body: some View {
        VStack {
            if device.nfcAvailable {
                NFCScanningView()
            } else {
                Text("NFC not available.")
            }
        }
    }
}
```
