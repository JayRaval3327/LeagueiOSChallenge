//
//  FeedDisplayable.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-17.
//

import Foundation

struct FeedDisplayable: Identifiable {
    let id: Int
    let avatarURL: String
    let email: String
    let username: String
    let title: String
    let description: String
    
    // Initialize a FeedDisplayable with a post and its corresponding user
    init(post: PostResponse, user: UserResponse) {
        self.id = post.id
        self.avatarURL = user.avatar
        self.email = user.email
        self.username = user.username
        self.title = post.title
        self.description = post.body
    }
}
