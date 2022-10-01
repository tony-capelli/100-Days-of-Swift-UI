//
//  ContentView.swift
//  iExpenses2
//
//  Created by Tony Capelli on 26/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var lista = ListaSpese()
    @State private var isShowingSheet = false
    
    func contaTotale()->Double {
        var totale = 0.0
        
        for numeri in lista.lista {
            totale = totale + numeri.costo
        }
        
        return totale
    }
    
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    HStack{
                        Text("Totale speso: ")
                            .font(.headline)
                        Spacer()
                        Text("\(contaTotale(), specifier:  "%.2f")€")
                            .fontWeight(.bold)
                            .foregroundColor(contaTotale() < 500 ? .green : contaTotale() > 1000 ? .red : .orange )
                    }
                }
                ForEach(lista.lista){ elemento in
                    HStack{
                        VStack(alignment: .leading){
                            Text(elemento.nome)
                            Text(elemento.tipo)
                        }
                        Spacer()
                        Text(elemento.costo, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .foregroundColor(elemento.costo < 50 ? .green : elemento.costo > 100 ? .red : .orange )
                    }
                }
                .onDelete(perform: removeItem)
                .onMove(perform: { indices, newOffsets in
                    lista.lista.move(fromOffsets: indices, toOffset: newOffsets)
                })
            }
            .navigationTitle("Lista della spesa")
            .toolbar{
                Button{
                    isShowingSheet = true
                } label: {
                    Image(systemName: "plus")
                }
                EditButton()
            }
            .sheet(isPresented: $isShowingSheet){
                AggiungiSpesa(spese: lista)
            }
        }
    }
    
    func removeItem(at posizione: IndexSet){
        lista.lista.remove(atOffsets: posizione)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
