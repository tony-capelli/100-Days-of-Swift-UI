//
//  FriendView.swift
//  UserFriend
//
//  Created by Tony Capelli on 04/10/22.
//

import SwiftUI

struct FriendView: View {
    let friend: User.Friend
    var body: some View {
        Text(friend.name)
    }
}

//struct FriendView_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendView()
//    }
//}
