//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Purnaman Rai (College) on 15/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var userScore = 0
    @State private var showingScoreAlert = false
    @State private var scoreAlertTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Text("GUESS THE FLAG")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                
                Spacer()
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)
                    }
                    
                    ForEach(0..<3) { flagNumber in
                        Button {
                            checkAnswer(flagNumber)
                        } label: {
                            Image(countries[flagNumber])
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 15))
                
                Spacer()
                
                Text("SCORE: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
            .padding()
        }
        .alert(scoreAlertTitle, isPresented: $showingScoreAlert) {
            Button("Continue", action: askNextQuestion)
        } message: {
            Text("Your Score: \(userScore)")
        }
    }
    
    func checkAnswer(_ tappedFlag: Int) {
        if tappedFlag == correctAnswer {
            userScore += 1
            scoreAlertTitle = "Correct!"
        } else {
            scoreAlertTitle = "Oops, wrong!"
        }
        
        showingScoreAlert = true
    }
    
    func askNextQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 1...2)
    }
}

#Preview {
    ContentView()
}
