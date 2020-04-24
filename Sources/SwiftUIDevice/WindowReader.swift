//
//  WindowReader.swift
//  
//
//  Created by Matt Maddux on 4/24/20.
//

import Foundation
import SwiftUI

public struct WindowReader<Content: View >: View {
    
    @ObservedObject private var device = Device.shared
    private let content: (WindowClass) -> Content
    

    public init(@ViewBuilder content: @escaping (WindowClass) -> Content) {
        self.content = content
    }

    public var body: some View {
        GeometryReader { geo in
            self.content(self.device.windowClass)
                .border(Color.red, width: geo.size.width * 0)
        }
    }
}
