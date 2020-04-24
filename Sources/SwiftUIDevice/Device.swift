//
//  Device.swift
//
//  Created by Matt Maddux on 1/22/20.
//

import Foundation
import SwiftUI
import CoreNFC

public class Device: ObservableObject {
    
    // ======================================================= //
    // MARK: - Shared Instance
    // ======================================================= //
    
    static public let shared: Device = Device()
    
    // ======================================================= //
    // MARK: - Public Properties
    // ======================================================= //
    
    public let model: DeviceModel = DeviceModel.current
    
    public let isSimulator: Bool = DeviceModel.isSimulator
    
    public let aspectRatio: AspectRatio = AspectRatio.calculated()
    
    public var deviceOrientation: DeviceOrientation {
        return UIDevice.current.orientation
    }
    
    public var uiOrientation: UIOrientation {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation ?? .unknown
    }
    
    public var isiPad: Bool {
        return aspectRatio == .ipad
    }
    
    public var isiPhone: Bool {
        return aspectRatio == .iphoneLong || aspectRatio == .iphoneShort
    }
    
    public var nfcAvailable: Bool {
        return NFCTagReaderSession.readingAvailable
    }
    
    // ======================================================= //
    // MARK: - Internal Properties
    // ======================================================= //
    
    var  windowClass: WindowClass {
        let windowWidth = UIApplication.shared.windows[0].bounds.width
        if windowWidth < 650 {
            return .veryNarrow
        } else if windowWidth < 1000 {
            return .narrow
        } else if windowWidth < 1150 {
            return .wide
        } else {
            return .veryWide
        }
    }
    
    // ======================================================= //
    // MARK: - Initializer
    // ======================================================= //
    
    public init() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(update),
                                               name: Notification.Name("UIDeviceOrientationDidChangeNotification"),
                                               object: nil)
    }
    
    // ======================================================= //
    // MARK: - Notification Selector
    // ======================================================= //
    
    @objc private func update() {
        self.objectWillChange.send()
    }
    
}
