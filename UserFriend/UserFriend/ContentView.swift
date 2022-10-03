//
//  ContentView.swift
//  UserFriend
//
//  Created by Tony Capelli on 03/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        DetailView(user: user)
                    } label: {
                        HStack {
                            VStack (alignment: .leading) {
                                Text(user.name)
                                    .font(.headline)
                                
                                Text(user.email)
                                    .fontWeight(.thin)
                                
                            }
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .task {
                await getData()
            }
        }
    }
    
    
    func getData () async {
        if users.isEmpty {
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                fatalError("error")
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                
                if let decodedData = try? JSONDecoder().decode([User].self, from: data) {
                    users = decodedData
                    print("ok")
                }
            } catch {
                fatalError()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
