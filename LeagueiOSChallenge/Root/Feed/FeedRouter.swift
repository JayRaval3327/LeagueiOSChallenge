//
//  FeedRouter.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-18.
//

import Foundation

protocol FeedRouter {
    func presentProfileViewController(feed: FeedDisplayable)
}

final class DefaultFeedRouter: Router<FeedViewController>, FeedRouter {
    func presentProfileViewController(feed: FeedDisplayable) {
        let viewController = ProfileScene(feed: feed).loadViewController()
        self.presentModally(viewController, detents:[.medium()], embedInNavigationController: true)
    }
}
