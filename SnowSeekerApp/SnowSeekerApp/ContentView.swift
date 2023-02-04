//
//  ContentView.swift
//  SnowSeekerApp
//
//  Created by Tony Capelli on 04/02/23.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    let allNames = ["Soup", "Vina","Melvin", "staphani"]
    
    var body: some View {
        NavigationView {
            List(filteredNames, id: \.self){ name in
                Text(name)
            }
                .searchable(text: $searchText, prompt: "Look for something")
                .navigationTitle("Searching")
                .animation(.default, value: filteredNames)
        }
       
    }
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
