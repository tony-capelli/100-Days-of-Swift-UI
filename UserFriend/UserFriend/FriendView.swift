//
//  FriendView.swift
//  UserFriend
//
//  Created by Tony Capelli on 04/10/22.
//

import SwiftUI

struct FriendView: View {
    let friend: CachedFriend
    var body: some View {
        Text(friend.wrappedName)
    }
}

//struct FriendView_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendView()
//    }
//}
