//
//  ContentView.swift
//  iExpense
//
//  Created by Tony Capelli on 26/09/22.
//

import SwiftUI



struct OnDelete: View {
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack{
                List{
                    ForEach(numbers, id: \.self){
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add number"){
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                
            }
            .navigationTitle("On Delete")
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeRows (at offsets: IndexSet){
        numbers.remove(atOffsets: offsets)
    }
}

struct OnDelete_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
