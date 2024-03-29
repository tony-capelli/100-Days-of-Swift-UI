//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Tony Capelli on 01/02/23.
//

import SwiftUI

extension VerticalAlignment{
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName){
            VStack{
                Text("@tonycapelli")
                    .alignmentGuide(.midAccountAndName) { d  in
                        d[VerticalAlignment.center]
                    }
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            VStack{
                Text("Full name")
                Text("TONY CAPELLI")
                    .alignmentGuide(.midAccountAndName) { d  in
                        d[VerticalAlignment.center]
                    }
                    .font(.largeTitle)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
