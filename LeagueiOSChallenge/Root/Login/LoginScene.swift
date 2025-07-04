//
//  LoginScene.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-17.
//

import Foundation

struct LoginScene: SwiftUIControllerScene {
    
    private let apiHelper : APIHelper
    
    init(apiHelper: APIHelper = APIHelper()) {
        self.apiHelper = apiHelper
    }
    
    func loadViewController() -> LoginViewController {
        let viewController = LoginViewController()
        let configuredViewModel = LoginViewModel(apiHelper: self.apiHelper, router: viewController)
        viewController.viewModel = configuredViewModel
        return viewController
    }
}
