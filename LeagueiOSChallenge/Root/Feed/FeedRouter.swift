//
//  FeedRouter.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-18.
//

import Foundation

protocol FeedRouter: RouterProtocol {
    func presentProfileViewController(feed: FeedDisplayable)
}

extension FeedRouter {
    func presentProfileViewController(feed: FeedDisplayable) {
        let viewController = ProfileScene(feed: feed).loadViewController()
        self.presentModally(viewController, detents: [.medium()], embedInNavigationController: true)
    }
}
