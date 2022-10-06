//
//  ContentView.swift
//  BucketlistApp
//
//  Created by Tony Capelli on 05/10/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var mapCoordinate = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 10), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    @State private var locations = [Location]()
    
    @State private var selectedPlace: Location?
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapCoordinate, annotationItems: locations){ location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                        
                        Text(location.name)
                    }
                    .onTapGesture {
                        selectedPlace = location
                    }
                }
            }
            .ignoresSafeArea()
            
            Circle()
                .fill(.blue)
                .opacity((0.3))
                .frame(width: 32, height: 32)
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: mapCoordinate.center.latitude, longitude: mapCoordinate.center.longitude)
                        locations.append(newLocation)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background()
                    .font(.title)
                    .foregroundColor(.blue)
                    .clipShape(Circle())
                    .padding(.trailing)
                    .shadow(color: .black, radius: 10, x: 2, y: 2)
                }
            }
        }
        .sheet(item: $selectedPlace){ place in
            EditView(location: place) { newLocation in
                if let index = locations.firstIndex(of: place) {
                    locations[index] = newLocation
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
