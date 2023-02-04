//
//  ContentView.swift
//  SnowSeekerApp
//
//  Created by Tony Capelli on 04/02/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Text("Hello, world!")
                .navigationTitle("Primary")
            
            Text("Secondary")
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
