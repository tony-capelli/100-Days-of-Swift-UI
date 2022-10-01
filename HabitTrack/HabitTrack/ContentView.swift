//
//  ContentView.swift
//  HabitTrack
//
//  Created by Tony Capelli on 29/09/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var listaAttivita = ListaAttivita()
    @State private var isShowing = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(listaAttivita.lista){ attivita in
                    NavigationLink{
                        DescrizioneAttivita(attivita: attivita, lista: listaAttivita)
                    } label: {
                        Text(attivita.titolo)
                    }
                }
                .onDelete(perform: removeItem)
                .onMove(perform: { indices, neWoffsets in
                    listaAttivita.lista.move(fromOffsets: indices, toOffset: neWoffsets)
                    
                })
            }
            .navigationTitle("Habit Tracker")
            .toolbar{
                ToolbarItem(placement: .bottomBar){
                    Button{
                        isShowing = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .automatic){
                    EditButton()
                }
            }
            .sheet(isPresented: $isShowing){
                AggiungiAttivita(lista: listaAttivita)
            }
        }
    }
    
    func removeItem(at offsets: IndexSet){
        listaAttivita.lista.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
