//
//  EditCards.swift
//  Flashzilla
//
//  Created by Tony Capelli on 31/01/23.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationView {
            List{
                Section("Add new Cars"){
                    TextField("New prompt", text: $newPrompt)
                    TextField("New answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack{
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
        }
    }
    
    func done() {
        dismiss()
    }
    
    func loadData() {
          if let data = UserDefaults.standard.data(forKey: "Cards") {
              print("loaded")
              if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                  cards = decoded
              }
          }
      }

      func saveData() {
          if let data = try? JSONEncoder().encode(cards) {
              print("saved")
              UserDefaults.standard.set(data, forKey: "Cards")
          }
      }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
        newAnswer = ""
        newPrompt = ""
    }
    
    func removeCards(at index: IndexSet){ 
        cards.remove(atOffsets: index)
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
