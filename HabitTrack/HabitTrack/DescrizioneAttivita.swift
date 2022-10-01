//
//  DescrizioneAttivita.swift
//  HabitTrack
//
//  Created by Tony Capelli on 29/09/22.
//

import SwiftUI

struct DescrizioneAttivita: View {
    let attivita: Attivita
    @ObservedObject var lista: ListaAttivita
    @State private var numeroComplatamento = 0
    
    
    var body: some View {
        
        VStack{
            ScrollView{
                VStack{
                    Image(systemName: "calendar.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 400)
                        .opacity(0.4)
                    
                    
                    VStack(alignment: .leading){
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .opacity(0.4)
                        
                        Text(attivita.titolo)
                            .font(.title.bold())
                        
                        Text(attivita.descrizione)
                        Spacer()
                    }

                }
            }
            Section("Numero di volte completato"){
                HStack(alignment: .center){
                    Button{

                        let index = lista.lista.firstIndex(of: attivita)
                        lista.lista[index!] = Attivita(titolo: attivita.titolo, descrizione: attivita.descrizione, numeroCompletato: attivita.numeroCompletato - 1)
                    }label: {
                        Image(systemName: "minus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    .disabled(attivita.numeroCompletato == 0 ? true : false)
                    
                    Text("\(attivita.numeroCompletato)")
                        .font(.title)
                        .fontWeight(.black)
                        .padding(.horizontal)
                    
                    
                    Button{
                        let index = lista.lista.firstIndex(of: attivita)
                        lista.lista[index!] = Attivita(titolo: attivita.titolo, descrizione: attivita.descrizione, numeroCompletato: attivita.numeroCompletato + 1)
                    }label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                }
            }
        }
        .padding(.horizontal)

        .navigationTitle(attivita.titolo)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//*struct DescrizioneAttivita_Previews: PreviewProvider {
//    static var previews: some View {
//        DescrizioneAttivita(attivita: attivita[0], lista: attivita)
//   }
//}

