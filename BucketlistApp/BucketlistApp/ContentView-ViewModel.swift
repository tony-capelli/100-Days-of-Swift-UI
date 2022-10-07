//
//  ContentView-ViewModel.swift
//  BucketlistApp
//
//  Created by Tony Capelli on 07/10/22.
//

import Foundation
import MapKit
import LocalAuthentication

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapCoordinate = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 10), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        
        @Published var isUnlocked = false
        
        let savePath = FileManager.documentDirectory.appendingPathComponent("SavedPlaces")
        
        init(){
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch  {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch  {
                print("Unable to save data.")
            }
        }
        
        func addLocation(){
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: mapCoordinate.center.latitude, longitude: mapCoordinate.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success{
                        Task { @MainActor in
                            self.isUnlocked = true
                        }
                    } else {
                        
                    }
                }
            } else {
                
            }
        }
    }
}
