//
//  CustomViewModifier.swift
//  GuessTheFlag
//
//  Created by Purnaman Rai (College) on 16/08/2025.
//

import SwiftUI

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func prominentTitleStyle() -> some View {
        modifier(ProminentTitle())
    }
}

struct CustomViewModifier: View {
    var body: some View {
        Text("Hello, World!")
            .prominentTitleStyle()
    }
}

#Preview {
    CustomViewModifier()
}
