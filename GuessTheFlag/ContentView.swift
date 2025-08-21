//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Денис Шевченко on 21.08.2025.
//

import SwiftUI

struct ContentView: View {
    let color1 = Color.yellow
    let color2 = Color.white
    @State private var showingAlert = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreNumber = 0
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: .indigo, location: 0.3),
                .init(color: Color(red: 0.8, green: 0.3, blue: 0.36), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            
            .ignoresSafeArea()
            VStack{
                Spacer()
                    Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)

                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.white)
                    }
                    
                    
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        }
                        label: {
                            Image(countries[number])
                                .clipShape(.rect(cornerRadius: 20))
                                .shadow(radius: 4)
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
               
                Text("Score: \(scoreNumber)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
               
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        }message: {
            Text("Your score is \(scoreNumber) points")
        }
        .ignoresSafeArea()
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            scoreNumber += 50
        }
        else{
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
