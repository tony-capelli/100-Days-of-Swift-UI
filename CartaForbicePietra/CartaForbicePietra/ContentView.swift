//
//  ContentView.swift
//  CartaForbicePietra
//
//  Created by Tony Capelli on 14/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var mosse = ["Carta", "Forbicie", "Sasso"]
    @State private var sceltaComputer = Int.random(in: 0...2)
    
    //@State private var risultatoRandom = Int.random(in: 0...1)
   // @State private var risultato = ["Vincere", "Perdere"]
    
    @State private var sceltaGiocatore = 0
    @State private var punti = 0
    @State private var isShowed = false
    
    @State private var title = ""
    @State private var countMatchPlayed = 0
    
    var body: some View {
        NavigationView{
            ZStack{

                VStack {
                    Text("Score: \(punti)")
                        .font(.largeTitle)
                    Spacer()
                    Text("Il computer ha scelto \(mosse[sceltaComputer])")
                        .font(.headline)
                    Spacer()
                    
                    // Text("Devi \(risultato[risultatoRandom])")
                    
                    
                    ForEach(0..<mosse.count, id: \.self){ number in
                        Button{
                            haCliccato(number)
                        } label: {
                            Text("\(mosse[number])")
                        }
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        
                    }
                    .backgroundStyle(.thinMaterial)
                }
                .padding()
            }
            .navigationBarTitle("Carta, Forbice sasso", displayMode: .inline)
            .alert(isPresented: $isShowed){
                Alert(title: Text(title), message: Text("messagio"), dismissButton: .default(Text("Continue")){
                    continueGame()
                })
            }
        }
    }
    
    
    func haCliccato(_ number: Int){
        sceltaGiocatore = number
        if (countMatchPlayed>10){
            isShowed = true
            title = "La partita è terminta hai totalizzato \(punti) punti"
            punti = 0
        }
        if (sceltaComputer == sceltaGiocatore){
            isShowed = true
            title = "draw"
            countMatchPlayed += 1
        }
        if (sceltaGiocatore == 0 && sceltaComputer == 2){
            winner(sceltaGiocatore, sceltaComputer)
        } else if (sceltaGiocatore == 1 && sceltaComputer == 0){
            winner(sceltaGiocatore, sceltaComputer)
        } else if (sceltaGiocatore == 2 && sceltaComputer == 1){
            winner(sceltaGiocatore, sceltaComputer)
        } else {
            isShowed = true
            title = "Hai perso \(mosse[sceltaComputer]) batte \(mosse[sceltaGiocatore])"
            
        }
    }
        
        func winner(_ number1: Int,_ number2: Int){
                isShowed = true
                punti += 1
                countMatchPlayed += 1
                title = "Hai vinto \(mosse[number1]) batte \(mosse[number2])"
           
        }
        
        func continueGame (){
            sceltaComputer = Int.random(in: 0...2)
        }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
