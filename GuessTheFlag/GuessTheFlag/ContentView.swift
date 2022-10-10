//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tony Capelli on 11/09/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scorePoints = 0
    
    @State private var country = ["Estonia","France","Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    let labels = [
            "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
            "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
            "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
            "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
            "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
            "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
            "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
            "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
            "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
            "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
            "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
        ]

    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack{
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack (spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(country[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) {number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(country[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                                .accessibilityLabel(labels[country[number], default: "Unknown flag"])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scorePoints)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is now \(scorePoints)")
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scorePoints += 1
            scoreTitle = "Correct"
        } else {
            scorePoints = 0
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    
    func askQuestion(){
        country = country.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
