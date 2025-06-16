//
//  FeedViewController.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-17.
//

import UIKit

class FeedViewController: SwiftUIViewController<FeedView>, FeedRouter {
    
    var viewModel: FeedViewModel! {
        didSet {
            self.childView = FeedView(viewModel: viewModel)
        }
    }
    
    private enum Labels {
        static let title = "Posts"
        static let exitTitle = "Exit"
        static let logoutTitle = "Logout"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Labels.title
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel.loginType == .authenticated ? Labels.logoutTitle : Labels.exitTitle,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapBarButton(_:)))
    }
    
    @objc
    func didTapBarButton(_ sender: Any) {
        if viewModel.loginType == .authenticated {
            self.viewModel.dismissViewController()
        } else {
            self.viewModel.showGuestAlertMessage()
        }
    }
    
}
