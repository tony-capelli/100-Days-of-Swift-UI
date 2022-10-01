//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Tony Capelli on 25/09/22.
//

import SwiftUI

struct Question {
    var domanda : String
    var risposta : Int
    
}

struct ContentView: View {
    
    @State private var tabellinaSelezionata = 2
    @State private var numeroDiDomandeSelezionate = 0
    @State private var gameActive = false
    let numeroDiDomande = [5,10,15,20]
    
    @State private var difficoltaSelezionata = "Facile"
    let difficoltaDisponibili = ["Facile", "Medio", "Difficile"]
    
    @State private var arrayDiDomande = [Question]()

    @State private var punteggio = 0
    @State private var domandeRimaste = 0
    @State private var currentQuestion = 0
    @State private var risposta = 0
    
    @State private var showAlert = false
    
    @FocusState private var isFocussed: Bool

    func creaNuovaMoltiplicazione(difficoltaScelta: String, num: Int) -> Array<Question>{
        
        var domandeCreate = [Question]()
        var range : Range<Int>
        

        switch difficoltaScelta {
        case "Facile":
            range = 1..<6
        case "Medio":
            range = 5..<9
        case "Difficile":
            range = 1..<13
            
        default:
            range = 1..<6
        }
        
        for _ in 0..<num {
            
            let numeroDaMoltiplicare = Int.random(in: range)
            
            domandeCreate.append(Question(domanda: "\(tabellinaSelezionata) x \(numeroDaMoltiplicare)", risposta: tabellinaSelezionata * numeroDaMoltiplicare))
        }
        
        
        return domandeCreate
    }
    
    
    var body: some View {
        NavigationView{
            
            if gameActive && currentQuestion != numeroDiDomande[numeroDiDomandeSelezionate] {
                Form(){
                    Section(){
                        HStack{
                            Text("Punteggio:")
                            Text("\(punteggio)")
                                .font(.headline)
                        }
                        
                        HStack{
                            Text("Domande rimaste:")
                            Text("\(domandeRimaste)")
                                .font(.headline)
                        }
                    }
                    VStack(alignment: .center){
                        Text("Rispondi correttamente, quanto fa")
                            .font(.headline)
                            .padding()
          
                        Text(arrayDiDomande[currentQuestion].domanda + " ?")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                            
     
                        TextField("", value: $risposta, format: .number)
                            .keyboardType(.numberPad)
                            .focused($isFocussed)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .padding()
                            .font(Font.system(size: 60, design: .default))
                
                        
                        Button{
                            if(risposta == arrayDiDomande[currentQuestion].risposta){
                                currentQuestion += 1
                                punteggio += 1
                                domandeRimaste -= 1
                                risposta = 0
                            } else {
                                currentQuestion += 1
                                domandeRimaste -= 1
                                risposta = 0
                            }
                            if(currentQuestion != numeroDiDomande[numeroDiDomandeSelezionate]){
                                showAlert = true
                            }
                        } label: {
                            Text("Conferma risposta").frame(maxWidth: .infinity, alignment: .center)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                        .font(.headline)
                    }
                    .backgroundStyle(.thinMaterial)
                
                }
                .navigationTitle("Education App")

            } else {
                
                Form{
                    VStack(alignment: .leading){
                        Text ("Quale tabellina vuoi allenare?")
                            .font(.headline)
                    
                        Stepper("\(tabellinaSelezionata)", value: $tabellinaSelezionata, in: 2...12, step: 1)
                    }
                    
                    VStack(alignment: .leading){
                        Text ("A quante domande vuoi rispondere?")
                            .font(.headline)
                    
                        Picker("\(numeroDiDomandeSelezionate)", selection: $numeroDiDomandeSelezionate){
                            ForEach(0..<numeroDiDomande.count, id: \.self) { num in
                                Text("\(numeroDiDomande[num])")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    VStack(alignment: .leading){
                        Text ("Seleziona un livello di difficoltà")
                            .font(.headline)
                    
                        Picker("\(difficoltaSelezionata)", selection: $difficoltaSelezionata){
                            ForEach(difficoltaDisponibili, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Button{
                        StartTheGame()
                    } label: {
                        Text("Inizia il gioco").frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                }
                
                .navigationTitle("Education App")
                .alert("Congratulazioni!", isPresented: $showAlert){
                    Button("Rigioca", action: {
                        gameActive = true
                        StartTheGame()
                    })
                    Button("Impostazioni"){
                        gameActive = false
                        showAlert = false
                    }
                } message: {
                    Text("Hai risposto correttamente \(punteggio) su \(numeroDiDomande[numeroDiDomandeSelezionate])")
                }
                
                }
            }.toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Button("Done"){
                        isFocussed = false
                    }
                }
            }
            
       
    }
    
    func StartTheGame(){
        gameActive = true
        punteggio = 0
        arrayDiDomande =  creaNuovaMoltiplicazione(difficoltaScelta: difficoltaSelezionata, num: numeroDiDomande[numeroDiDomandeSelezionate])
        domandeRimaste = numeroDiDomande[numeroDiDomandeSelezionate]
        currentQuestion = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
