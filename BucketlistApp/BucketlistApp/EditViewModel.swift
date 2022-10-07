//
//  EditViewModel.swift
//  BucketlistApp
//
//  Created by Tony Capelli on 07/10/22.
//

import Foundation

extension EditView {
   @MainActor class EditModel: ObservableObject {
    
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
       
        
        enum LoadingState {
            case loading, loaded, failed
        }
        

       func fetchNearyPlaces(_ urlString: String) async {
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
                
            } catch  {
                loadingState = .failed
            }
        }
    }
}
