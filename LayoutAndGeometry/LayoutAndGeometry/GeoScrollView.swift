//
//  GeoScrollView.swift
//  LayoutAndGeometry
//
//  Created by Tony Capelli on 02/02/23.
//

import SwiftUI

struct GeoScrollView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50){ index in
                    GeometryReader { geo in
                        Text("\( geo.frame(in: .global).minY / 748)")
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(geo.frame(in: .global).minY / 300 )
                            .scaleEffect(geo.frame(in: .global).minY / 748)
                    }
                    .frame(height: 40 )
                    
                }
            }
        }
    }
}

struct GeoScrollView_Previews: PreviewProvider {
    static var previews: some View {
        GeoScrollView()
    }
}
