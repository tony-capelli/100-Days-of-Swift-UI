//
//  ContentView.swift
//  BucketlistApp
//
//  Created by Tony Capelli on 05/10/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                Map(coordinateRegion: $viewModel.mapCoordinate, annotationItems: viewModel.locations){ location in
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
                            viewModel.selectedPlace = location
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
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
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
            }
            .sheet(item: $viewModel.selectedPlace){ place in
                EditView(location: place) { newLocation in
                    viewModel.update(location: newLocation)
                }
            }
        } else {
            Button("Unlock places"){
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            Text("Locked")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
