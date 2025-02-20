//
//  ShimmerEffect.swift
//  MPlay
//
//  Created by maputh on 20/02/25.
//

import SwiftUI

struct ShimmerEffect: ViewModifier {
    @State private var isActive = false

    func body(content: Content) -> some View {
        content
            .opacity(isActive ? 0.3 : 1.0)
            .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isActive)
            .onAppear {
                isActive = true
            }
    }
}

extension View {
    func shimmer() -> some View {
        self.modifier(ShimmerEffect())
    }
}
