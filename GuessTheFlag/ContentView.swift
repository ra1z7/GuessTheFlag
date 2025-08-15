//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Purnaman Rai (College) on 15/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            Button("Bordered Button") { }
                .buttonStyle(.bordered)
            
            Button("Bordered Button (Destructive)", role: .destructive) { }
                .buttonStyle(.bordered)
            
            Button("Bordered Prominent Button") { }
                .buttonStyle(.borderedProminent)
            
            Button("Bordered Prominent Button (Destructive)", role: .destructive) { }
                .buttonStyle(.borderedProminent)
            
            Button("Custom Background Color") { }
                .buttonStyle(.bordered)
                .clipShape(.capsule)
                .tint(.orange)
            
            Button {
                showingAlert = true
            } label: {
                Label("Delete", systemImage: "trash")
                    .padding(10)
                    .background(LinearGradient(colors: [.red, .green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
            .alert("Alert Title Here", isPresented: $showingAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) { }
            } message: {
                Text("Message Here")
            }

            
            
        }
    }
}

#Preview {
    ContentView()
}
