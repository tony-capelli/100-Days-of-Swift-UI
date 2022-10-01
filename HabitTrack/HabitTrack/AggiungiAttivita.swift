//
//  AggiungiAttivita.swift
//  HabitTrack
//
//  Created by Tony Capelli on 29/09/22.
//

import SwiftUI

struct AggiungiAttivita: View {
    @ObservedObject var lista: ListaAttivita
    @Environment(\.dismiss) var dismiss
    
    @State private var titolo = ""
    @State private var descrizione = ""
    
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Dai un titolo alla tua attività")){
                    TextField("Titolo", text: $titolo)
                }
                Section(header: Text("Descrivi la tua nuova abitudine")){
                    TextField("Descrizione...", text: $descrizione,axis: .vertical)
                        .lineLimit(10...20)
                }
            }
            .navigationTitle("Aggiungi attività")
            .toolbar{
                Button("Salva"){
                    lista.lista.append(Attivita(titolo: titolo, descrizione: descrizione, numeroCompletato: 0))
                    dismiss()
                }
            }
        }
    }
}

struct AggiungiAttivita_Previews: PreviewProvider {
    static var previews: some View {
        AggiungiAttivita(lista: ListaAttivita())
    }
}
