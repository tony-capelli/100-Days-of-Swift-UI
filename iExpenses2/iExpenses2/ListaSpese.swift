//
//  ListaSpese.swift
//  iExpenses2
//
//  Created by Tony Capelli on 26/09/22.
//

import Foundation

class ListaSpese: ObservableObject {
    @Published var lista = [OggettoSpesa]() {
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(lista){
                UserDefaults.standard.set(encoded, forKey: "Lista")
            }
        }
    }
    
    init(){
        if let elementiSalvati = UserDefaults.standard.data(forKey: "Lista"){
            if let elementiDecifrati = try? JSONDecoder().decode([OggettoSpesa].self, from: elementiSalvati){
                lista = elementiDecifrati
                return
            }
        }
        lista = []
    }
    
}
