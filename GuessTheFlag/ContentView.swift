//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Purnaman Rai (College) on 15/08/2025.
//

import SwiftUI

struct FlagImage: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(radius: 5)
    }
    
    init(for imageName: String) {
        self.imageName = imageName
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var userScore = 0
    @State private var showingScoreAlert = false
    @State private var scoreAlertTitle = ""
    @State private var scoreAlertMessage = ""
    @State private var askedQuestionsCount = 0
    
    @State private var spinAmount = 0.0
    @State private var flagTapped = 0
    @State private var flagOpacity = 1.0
    @State private var scaleAmount = 1.0
    @State private var tappedFlagScale = 1.0
    
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
                            
                            withAnimation {
                                spinAmount += 360.0
                                flagOpacity = 0.25
                                scaleAmount = 0
                            }
                        } label: {
                            FlagImage(for: countries[flagNumber])
                                .rotation3DEffect(.degrees(spinAmount), axis: (x: 0, y: (flagTapped == flagNumber ? 1 : 0), z: 0))
                                .opacity(flagTapped == flagNumber ? 1 : flagOpacity)
                                .scaleEffect(flagTapped == flagNumber ? tappedFlagScale : scaleAmount)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 15))
                
                Spacer()
                
                Text("SCORE: \(userScore)/8")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
            .padding()
        }
        .alert(scoreAlertTitle, isPresented: $showingScoreAlert) {
            if askedQuestionsCount < 8 {
                Button("Continue", action: askNextQuestion)
            } else {
                Button("Restart Game", action: startNewGame)
            }
            
        
        } message: {
            Text(scoreAlertMessage)
        }
    }
    
    func checkAnswer(_ tappedFlag: Int) {
        askedQuestionsCount += 1
        flagTapped = tappedFlag
        
        if tappedFlag == correctAnswer {
            userScore += 1
            scoreAlertTitle = "Correct!"
            scoreAlertMessage = "Your Score: \(userScore)"
        } else {
            scoreAlertTitle = "Oops, wrong!"
            scoreAlertMessage = "That's the flag of \(countries[tappedFlag])."
        }
        
        showingScoreAlert = true
    }
    
    func askNextQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 1...2)
        flagOpacity = 1.0
        tappedFlagScale = 0.0
        
        withAnimation {
            scaleAmount = 1.0
            tappedFlagScale = 1.0
        }
    }
    
    func startNewGame() {
        userScore = 0
        askedQuestionsCount = 0
        askNextQuestion()
    }
}

#Preview {
    ContentView()
}
