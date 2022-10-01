//
//  ListaAttivita.swift
//  HabitTrack
//
//  Created by Tony Capelli on 29/09/22.
//

import Foundation

class ListaAttivita: ObservableObject {
    @Published var lista = [Attivita](){
        didSet{
            let encoder = JSONEncoder()
            if let encodedFile = try? encoder.encode(lista){
                UserDefaults.standard.set(encodedFile, forKey: "listaAttivita")
            }
        }
    }
    
    init(){
        let decoder = JSONDecoder()
        if let elementiSalvati = UserDefaults.standard.data(forKey: "listaAttivita"){
            if let decodedFile = try? decoder.decode([Attivita].self, from: elementiSalvati){
                lista = decodedFile
                return
            }
        }
    }
}
