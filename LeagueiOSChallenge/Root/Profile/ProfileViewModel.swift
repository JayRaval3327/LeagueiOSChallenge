//
//  ProfileViewModel.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-18.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    private(set) var feed: FeedDisplayable
    private(set) var isValidEmail: Bool = false
    
    init(feed: FeedDisplayable) {
        self.feed = feed
        
        let validExtensions = [".com", ".net", ".biz"]
        isValidEmail = validExtensions.contains { feed.email.hasSuffix($0) }
    }
    
}
