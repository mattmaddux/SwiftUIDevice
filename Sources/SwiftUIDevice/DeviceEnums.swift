//
//  DeviceEnums.swift
//  
//
//  Created by Matt Maddux on 4/22/20.
//

import Foundation
import SwiftUI

// ======================================================= //
// MARK: - Window Class
// ======================================================= //

public enum WindowClass: String, CustomStringConvertible {
    case veryNarrow
    case narrow
    case wide
    case veryWide
    
    public var description: String {
        return self.rawValue
    }
}

// ======================================================= //
// MARK: - Device Model
// ======================================================= //

public enum DeviceModel: String, CustomStringConvertible {
    
    case iPodTouch7thGen
    case iPhone6s
    case iPhone6sPlus
    case iPhone7
    case iPhone7Plus
    case iPhoneSE
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXS
    case iPhoneXSMax
    case iPhoneXR
    case iPhone11
    case iPhone11Pro
    case iPhone11ProMax
    case iPad5thGen
    case iPad6thGen
    case iPad7thGen
    case iPadAir2
    case iPadAir3rdGen
    case iPadMini4
    case iPadMini5thGen
    case iPadPro97
    case iPadPro129
    case iPadPro1292ndGen
    case iPadPro105
    case iPadPro11
    case iPadPro1293rdGen
    case unknown
    
    static private let conversionTable: [String: DeviceModel] = [
        "iPod9,1": .iPodTouch7thGen,
        "iPhone8,1": .iPhone6s,
        "iPhone8,2": .iPhone6sPlus,
        "iPhone9,1": .iPhone7,
        "iPhone9,3": .iPhone7,
        "iPhone9,2": .iPhone7Plus,
        "iPhone9,4": .iPhone7Plus,
        "iPhone8,4": .iPhoneSE,
        "iPhone10,1": .iPhone8,
        "iPhone10,4": .iPhone8,
        "iPhone10,2": .iPhone8Plus,
        "iPhone10,5": .iPhone8Plus,
        "iPhone10,3": .iPhoneX,
        "iPhone10,6": .iPhoneX,
        "iPhone11,2": .iPhoneXS,
        "iPhone11,4": .iPhoneXSMax,
        "iPhone11,6": .iPhoneXSMax,
        "iPhone11,8": .iPhoneXR,
        "iPhone12,1": .iPhone11,
        "iPhone12,3": .iPhone11Pro,
        "iPhone12,5": .iPhone11ProMax,
        "iPad6,11": .iPad5thGen,
        "iPad6,12": .iPad5thGen,
        "iPad7,5": .iPad6thGen,
        "iPad7,6": .iPad6thGen,
        "iPad7,11": .iPad7thGen,
        "iPad7,12": .iPad7thGen,
        "iPad5,3": .iPadAir2,
        "iPad5,4": .iPadAir2,
        "iPad11,4": .iPadAir3rdGen,
        "iPad11,5": .iPadAir3rdGen,
        "iPad5,1": .iPadMini4,
        "iPad5,2": .iPadMini4,
        "iPad11,1": .iPadMini5thGen,
        "iPad11,2": .iPadMini5thGen,
        "iPad6,3": .iPadPro97,
        "iPad6,4": .iPadPro97,
        "iPad6,7": .iPadPro129,
        "iPad6,8": .iPadPro129,
        "iPad7,1": .iPadPro1292ndGen,
        "iPad7,2": .iPadPro1292ndGen,
        "iPad7,3": .iPadPro105,
        "iPad7,4": .iPadPro105,
        "iPad8,1": .iPadPro11,
        "iPad8,2": .iPadPro11,
        "iPad8,3": .iPadPro11,
        "iPad8,4": .iPadPro11,
        "iPad8,5": .iPadPro1293rdGen,
        "iPad8,6": .iPadPro1293rdGen,
        "iPad8,7": .iPadPro1293rdGen,
        "iPad8,8": .iPadPro1293rdGen
    ]
    
    static private let simulatorIds: [String] = ["x86_64", "i386"]
    
    static public var deviceID: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    static public var isSimulator: Bool {
        return simulatorIds.contains(DeviceModel.deviceID)
    }
    
    static public var current: DeviceModel {
        if DeviceModel.isSimulator {
            if let simulatorDeviceID = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                return DeviceModel.conversionTable[simulatorDeviceID] ?? .unknown
            }
            return .unknown
        }
        return DeviceModel.conversionTable[DeviceModel.deviceID] ?? .unknown
    }
    
    public var description: String {
        return self.rawValue
    }

}

// ======================================================= //
// MARK: - Aspect Ratio
// ======================================================= //

public enum AspectRatio: String, CustomStringConvertible {
    
    case iphoneShort
    case iphoneLong
    case ipad
    case unknown
    
    static private let ratioTable: [AspectRatio: Set<CGFloat> ] = [
        .iphoneShort : [0.56],
        .iphoneLong : [0.46],
        .ipad : [1.33, 0.75],
    ]

    static public func calculated() -> AspectRatio {
        let bounds = UIScreen.main.bounds
        let ratio = (bounds.width / bounds.height * 100).rounded() / 100
        for key in ratioTable.keys {
            if ratioTable[key]!.contains(ratio) {
                return key
            }
        }
        return .unknown
    }
    
    public var description: String {
        return self.rawValue
    }
}
