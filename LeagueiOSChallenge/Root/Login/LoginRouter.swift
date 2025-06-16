//
//  LoginRouter.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-17.
//

import Foundation

protocol LoginRouter: RouterProtocol {
    func presentFeedViewController(loginType: LoginType, apiKey: String)
}

extension LoginRouter {
    func presentFeedViewController(loginType: LoginType, apiKey: String) {
        let viewController = FeedScene(loginType: loginType, apiHelper: APIHelper(apiKey: apiKey)).loadViewController()
        self.presentFullScreenModally(viewController, embedInNavigationController: true)
    }
}
