//
//  ProfileScene.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-17.
//

import Foundation

struct ProfileScene: SwiftUIControllerScene {
    private var feed: FeedDisplayable
    
    init(feed: FeedDisplayable) {
        self.feed = feed
    }
    
    func loadViewController() -> ProfileViewController {
        let viewController = ProfileViewController()
        let configuredViewModel = ProfileViewModel(feed: self.feed)
        viewController.viewModel = configuredViewModel
        return viewController
    }
}
