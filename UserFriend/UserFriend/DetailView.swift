//
//  DetailView.swift
//  UserFriend
//
//  Created by Tony Capelli on 03/10/22.
//

import SwiftUI


extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

struct DetailView: View {
    let user: User
    
    
    var body: some View {
        ScrollView(.vertical){
            Image(systemName: "circle.fill")
                .foregroundColor(Color.random)
                .font(.system(size: 150))
                .overlay{
                    Text(user.name.prefix(1))
                        .foregroundColor(.white)
                        .font(.system(size: 100))
                }
            VStack{
                Text(user.name)
                    .font(.title.bold())
                
                Text(user.email)
                    .font(.subheadline)
                    .fontWeight(.thin)
                    .padding(.bottom,3)
                
                HStack{
                    Image(systemName: "mappin")
                        .opacity(0.5)
                    Text(user.address)
                        .font(.caption2)
                        .opacity(0.5)
                        .padding(.vertical)
                }
                
                Divider()
                
                
                VStack{
                    Text("ABOUT ME")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 4)
                        .padding(.top, 8)
                    Text(user.about)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding([.bottom,.horizontal])
                }
                .background()
                .backgroundStyle(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                
                HStack {
                    VStack(alignment: .leading){
                        Text("IS ACTIVE")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        if user.isActive {
                            Label("ACTIVE", systemImage: "star.fill")
                                .foregroundColor(.yellow)
                        } else {
                            Text("Not active")
                        }
                    }
                    .padding()
                    Spacer()
                    
                    VStack(alignment: .trailing){
                        Text("USER SINCE")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Text("\(user.registered.formatted(date: .abbreviated, time: .omitted))")
                    }
                    .padding()
                }
                .background()
                .backgroundStyle(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding([.bottom,.horizontal])
                
                Divider()
                VStack(alignment: .leading) {
                    Text("Friends")
                        .font(.title.bold())
                }
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(user.friends){ friend in
                            NavigationLink {
                                FriendView(friend: friend)
                            }label:{
                                HStack{
                                    Image(systemName: "circle.fill")
                                        .font(.title)
                                        .foregroundColor(Color.random)
                                        .overlay{
                                            Text(friend.name.prefix(1))
                                                .foregroundColor(.white)
                                        }
                                    Text(friend.name)
                                }
                                .padding()
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .background()
                        .backgroundStyle(.thinMaterial)
                        .clipShape(Capsule())
                    }
                    .offset(x:15)
                }
            }
        }
        .navigationTitle(("User Detail"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

