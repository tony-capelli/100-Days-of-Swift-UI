//
//  ContentView.swift
//  UserFriend
//
//  Created by Tony Capelli on 03/10/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var cachedUser: FetchedResults<CachedUser>
    
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cachedUser) { user in
                    NavigationLink {
                        DetailView(user: user)
                    } label: {
                        HStack {
                            VStack (alignment: .leading) {
                                Text(user.wrappedName)
                                    .font(.headline)
                                
                                Text(user.wrappedEmail)
                                    .fontWeight(.thin)
                                
                            }
                        }
                    }
                }
                .onDelete(perform: EliminaUtente)
            }
            .toolbar{
                EditButton()
            }
            .navigationTitle("Users")
            .task {
                if cachedUser.isEmpty {
                    if let retrivedUser = await getData(){
                        users = retrivedUser
                    }
                }
                
                await MainActor.run {
                    for user in users {
                        let newUser = CachedUser(context: moc)
                        newUser.name = user.name
                        newUser.isActive = user.isActive
                        newUser.age = Int16(user.age)
                        newUser.about = user.about
                        newUser.email = user.email
                        newUser.address = user.address
                        newUser.company = user.company
                        newUser.registered = user.registered
                        newUser.id = user.id
                        
                        for friend in user.friends {
                            let newFriend = CachedFriend(context: moc)
                            newFriend.id = friend.id
                            newFriend.name = friend.name
                            newFriend.user = newUser
                        }
                        try? moc.save()
                    }
                    
                }
            }
        }
    }
    
    func EliminaUtente(at offsets: IndexSet){
        for index in offsets {
            let elim = cachedUser[index]
            moc.delete(elim)
        }
        try? moc.save()
    }
    
    func getData () async -> [User]? {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        var  request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-typpe")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try? decoder.decode([User].self, from: data)
            return decodedData
        } catch {
            fatalError()
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
