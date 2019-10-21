//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Saif on 21/10/19.
//  Copyright © 2019 LeftRightMind. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var shapes = ["ROCK", "PAPER", "SCISSORS"]
    private var emojis = ["✊", "🖐", "✌️"]
    
    @State private var chosenShape = Int.random(in: 0...2)
    
    @State private var playerWins = Bool.random()
    
    @State private var showingScore = false
    
    @State private var score = 0
    
    @State private var numberOfTurns = 1
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors:[.blue,.black,.blue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing:50) {
                Text("Rock Paper Scissors")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .lineLimit(2)
                Text("Question - \(numberOfTurns)")
                    .foregroundColor(.orange)
                
                HStack {
                    Text("The app choice is: ")
                    Text(emojis[chosenShape])
                }
                .foregroundColor(.green)
                
                Text("Play to -  \(playerWins ? "Win" : "Lose")")
                    .foregroundColor(.yellow)
                
                Text("Your score is: \(score)")
                    .foregroundColor(score == 0 ? .red : .white)
                
                ForEach(0..<shapes.count) { shapeNumber in
                    Button(action: {
                        self.playerTapped(choice: self.shapes[shapeNumber])
                    }, label: {
                        Text(self.emojis[shapeNumber])
                            .frame(width: 80, height: 80)
                            .clipShape(Capsule())
                            .shadow(color:.white,radius: 2)
                    })
                }
                Spacer()
            }
            .edgesIgnoringSafeArea(.bottom)
        .padding()
            .font(.title)
            .padding()
            .alert(isPresented: $showingScore) {
                Alert(title: Text("Game Over"), message: Text("Your score is: \(score)"), dismissButton: .default(Text("New Game?")) {
                    self.restart()
                    })
            }
        }
    }
    
    func playerTapped(choice: String) {
        
        if playerWins == true {
            if chosenShape == 0 && choice == "PAPER" {
                successOrFailure(result: "success")
            } else if chosenShape == 1 && choice == "SCISSORS" {
                successOrFailure(result: "success")
            } else if chosenShape == 2 && choice == "ROCK" {
                successOrFailure(result: "success")
            } else {
                successOrFailure(result: "failure")
            }
        } else if playerWins == false {
            if chosenShape == 0 && choice == "PAPER" {
                successOrFailure(result: "failure")
            } else if chosenShape == 1 && choice == "SCISSORS" {
                successOrFailure(result: "failure")
            } else if chosenShape == 2 && choice == "ROCK" {
                successOrFailure(result: "failure")
            } else {
                successOrFailure(result: "success")
            }
        }
    }
    
    func successOrFailure(result: String) {
        
        if result == "success" {
            self.score += 1
        } else if result == "failure" {
            self.score -= 1
        }
        
        numberOfTurns += 1
        
        if numberOfTurns == 10 {
            showingScore = true
        } else {
            chosenShape = Int.random(in: 0...2)
            playerWins = Bool.random()
        }
    }
    
    func restart() {
        showingScore = false
        score = 0
        numberOfTurns = 0
        chosenShape = Int.random(in: 0...2)
        playerWins = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
