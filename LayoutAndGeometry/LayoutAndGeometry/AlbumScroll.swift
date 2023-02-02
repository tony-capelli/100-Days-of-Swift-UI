//
//  AlbumScroll.swift
//  LayoutAndGeometry
//
//  Created by Tony Capelli on 02/02/23.
//

import SwiftUI

struct AlbumScroll: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20){ num in
                    GeometryReader { geo in
                        Text("Number \(num)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                            .frame(width: 200, height: 200)
                    }
                    .frame(width: 200, height: 200)
                }
            }
        }
    }
}

struct AlbumScroll_Previews: PreviewProvider {
    static var previews: some View {
        AlbumScroll()
    }
}
