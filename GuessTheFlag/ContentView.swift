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
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    
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
                    .accessibilityElement()
                    .accessibilityLabel("Tap the flag of \(countries[correctAnswer])")
                    
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
                        // SwiftUI’s default behavior is to read out the image names as their VoiceOver label, which means anyone using VoiceOver can just move over our three flags to have the system announce which one is correct. SOLUTION:
                        .accessibilityLabel(labels[countries[flagNumber], default: "Unknown Flag"])
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
                    .accessibilityLabel("You have answered \(userScore) correctly out of 8 questions.")
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
