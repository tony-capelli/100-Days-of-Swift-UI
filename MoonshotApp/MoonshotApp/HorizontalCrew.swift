//
//  HorizontalCrew.swift
//  MoonshotApp
//
//  Created by Tony Capelli on 29/09/22.
//

import SwiftUI

struct HorizontalCrew: View {
    let crew: [CrewMember]
    var body: some View {
        ScrollView(.horizontal ,showsIndicators: false){
            HStack{
                ForEach(crew, id: \.role) { crew in
                    NavigationLink {
                        AstronautView(astronaut: crew.astronaut)
                    } label: {
                        HStack{
                            Image(crew.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading){
                                Text(crew.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Text(crew.role)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

