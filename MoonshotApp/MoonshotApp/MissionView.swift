//
//  MissionView.swift
//  MoonshotApp
//
//  Created by Tony Capelli on 28/09/22.
//

import SwiftUI

struct CrewMember{
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                
                VStack{
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.8)
                        .padding()
                    
                    Text(mission.launchDate?.formatted(date: .complete, time: .omitted) ?? "Date not aviable")
                    
                    
                    VStack(alignment: .leading){
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                            .opacity(0.8)
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                            .opacity(0.8)
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 10)
                    }
                    .padding(.horizontal)
                    HorizontalCrew(crew: crew)

                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]){
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astronaut)
            } else{
                fatalError("Missing member.name")
            }
            
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let mission: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: mission[3], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
