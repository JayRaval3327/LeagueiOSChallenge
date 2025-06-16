//
//  LoginViewController.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-16.
//

import UIKit

class LoginViewController: SwiftUIViewController<LoginView>, LoginRouter {    
    
    var viewModel: LoginViewModel! {
        didSet {
            self.childView = LoginView(viewModel: viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
