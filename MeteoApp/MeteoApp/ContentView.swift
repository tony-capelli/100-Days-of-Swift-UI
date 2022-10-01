//
//  ContentView.swift
//  MeteoApp
//
//  Created by Tony Capelli on 30/09/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var location = LocaationManager()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
