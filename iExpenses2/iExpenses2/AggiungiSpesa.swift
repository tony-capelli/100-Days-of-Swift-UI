//
//  AggiungiSpesa.swift
//  iExpenses2
//
//  Created by Tony Capelli on 26/09/22.
//

import SwiftUI

struct AggiungiSpesa: View {
    @ObservedObject var spese: ListaSpese
    @Environment(\.dismiss) var dismiss
    
    @State private var nome = ""
    @State private var tipo = "Personale"
    @State private var costo = 0.0
    
    let tipiVari = ["Personale", "Buisness"]
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Inserisci il nome della spesa", text: $nome)
                Picker("Seleziona il tipo di spesa", selection: $tipo){
                    ForEach(tipiVari, id:\.self){
                        Text($0)
                    }
                }
                TextField("Prova", value: $costo, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle("Aggiungi una spesa")
            .toolbar{
                Button("Salva"){
                    let item = OggettoSpesa(nome: nome, tipo: tipo, costo: costo)
                    spese.lista.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AggiungiSpesa_Previews: PreviewProvider {
    static var previews: some View {
        AggiungiSpesa(spese: ListaSpese())
    }
}
