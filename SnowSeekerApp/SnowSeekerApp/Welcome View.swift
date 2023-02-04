//
//  Welcome View.swift
//  SnowSeekerApp
//
//  Created by Tony Capelli on 04/02/23.
//

import SwiftUI

struct Welcome_View: View {
    var body: some View {
        VStack{
            Text("Welcome to SnowSeeker")
                .font(.largeTitle)
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                           .foregroundColor(.secondary)
        }
    }
}

struct Welcome_View_Previews: PreviewProvider {
    static var previews: some View {
        Welcome_View()
    }
}
