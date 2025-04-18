//
//  FeedScene.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-17.
//

import Foundation

struct FeedScene: SwiftUIControllerScene {
    
    private let apiHelper: APIHelper
    private let loginType: LoginType
    
    init(loginType: LoginType, apiHelper: APIHelper = APIHelper()) {
        self.apiHelper = apiHelper
        self.loginType = loginType
    }
    
    func loadViewController() -> FeedViewController {
        let viewController = FeedViewController()
        let router = DefaultFeedRouter(controller: viewController)
        let configuredViewModel = FeedViewModel(loginType: loginType, apiHelper: self.apiHelper, router: router) { [weak viewController] in
            viewController?.dismiss(animated: true)
        }
        viewController.viewModel = configuredViewModel
        return viewController
    }
}
