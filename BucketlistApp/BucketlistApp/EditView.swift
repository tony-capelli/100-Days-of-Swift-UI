//
//  EditView.swift
//  BucketlistApp
//
//  Created by Tony Capelli on 06/10/22.
//

import SwiftUI

struct EditView: View {
    @StateObject var editModel = EditModel()
    @State private var name: String
    @State private var description: String
    var location: Location
    
    
    @Environment(\.dismiss) var dismiss
    

    var onSave: (Location) -> Void

    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
                
                Section("Nearby.."){
                    switch editModel.loadingState {
                    case .loading:
                        Text("Loading..")
                    case .loaded:
                        ForEach(editModel.pages, id:\.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar{
                Button("Save"){
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task{
                let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
                await editModel.fetchNearyPlaces(urlString)
            }
        }
    }
    
    
    
    init(location: Location, onSave: @escaping (Location)->Void) {
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    

}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) {_ in}
    }
}
