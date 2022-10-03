//
//  DetailView.swift
//  UserFriend
//
//  Created by Tony Capelli on 03/10/22.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        ScrollView(.vertical){
            Image(systemName: "circle.fill")
                .foregroundColor(.blue)
                .font(.system(size: 150))
                .overlay{
                    Text(user.name.prefix(1))
                        .foregroundColor(.white)
                        .font(.system(size: 100))
                }
            VStack{
                Text(user.name)
                    .font(.headline)

                Text(user.email)
                    .font(.caption)
                    .fontWeight(.thin)
                    .padding(.bottom,3)
                
                HStack{
                    Image(systemName: "mappin")
                        .opacity(0.5)
                    Text(user.address)
                        .font(.caption2)
                        .opacity(0.5)
                }
                
                Divider()
                
                Text("About me")
                    .font(.headline)
                    .padding(.top)
                
                Text(user.about)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.vertical,2)
                    .padding(.horizontal)
                
                HStack {
                    VStack(alignment: .leading){
                        Text("IS ACTIVE")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        if user.isActive {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                        } else {
                            Text("Not active")
                        }
                    }
                    Spacer()
                    
                    VStack(alignment: .trailing){
                        Text("USER SINCE")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Text(user.registered)
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                
                Divider()
                Text("Friends")
                    .font(.headline)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(user.friends){ friend in
                            VStack(alignment:.leading){
                                HStack{
                                    Image(systemName: "circle.fill")
                                        .font(.title)
                                        .overlay{
                                            Text(friend.name.prefix(1))
                                                .foregroundColor(.white)
                                        }
                                    Text(friend.name)
                                }
                            }
                        }
                    }
                }
               
            }
        }
        .navigationTitle(("User Detail"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

