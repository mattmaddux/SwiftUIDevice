//
//  OrientationExtensions.swift
//  
//
//  Created by Matt Maddux on 4/22/20.
//

import Foundation
import SwiftUI

public typealias DeviceOrientation = UIDeviceOrientation
public typealias UIOrientation = UIInterfaceOrientation

extension DeviceOrientation: CustomStringConvertible {
    
    public var description: String {
        switch self {
            case .portrait: return "portrait"
            case .portraitUpsideDown: return "portraitUpsideDown"
            case .landscapeLeft: return "landscapeLeft"
            case .landscapeRight: return "landscapeRight"
            case .faceUp: return "faceUp"
            case .faceDown: return "faceDown"
            default: return "unknown"
        }
    }
    
}

extension UIOrientation: CustomStringConvertible {
    
    public var description: String {
        switch self {
            case .portrait: return "portrait"
            case .portraitUpsideDown: return "portraitUpsideDown"
            case .landscapeLeft: return "landscapeLeft"
            case .landscapeRight: return "landscapeRight"
            default: return "unknown"
        }
    }
    
}
