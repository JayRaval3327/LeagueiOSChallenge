//
//  LoginViewModel.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-16.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var username: String = String()
    @Published var password: String = String()
    @Published var showAlert: Bool = false
    @Published private(set) var alertMessage: String = String()
    @Published private(set) var isLoading: Bool = false
    @Published private var loginType: LoginType = .authenticated
    @Published private(set) var errorMessage: String?
    
    private let apiHelper : APIHelper?
    private let router: LoginRouter?
    
    init(apiHelper: APIHelper? = nil,
         router: LoginRouter? = nil) {
        self.apiHelper = apiHelper
        self.router = router
    }
    
    func didTapOnLoginButton() {
        self.isLoading.toggle()
        
        guard !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlertMessage("Please enter a username")
            return
        }
        
        guard !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlertMessage("Please enter a password")
            return
        }
        
        self.loginType = .authenticated
        
        Task {
            await self.authenticateUser()
        }
    }
    
    func didTapOnGuestButton() {
        self.loginType = .guest
        Task {
            await self.authenticateUser()
        }
    }
    
    private func authenticateUser() async {
        do {
            let apiKey = try await apiHelper?.fetchUserToken(username: username, password: password)
            await MainActor.run {
                self.isLoading = false
                self.username = String()
                self.password = String()
                self.router?.presentFeedViewController(loginType: self.loginType, apiKey: apiKey ?? String())
            }
        } catch {
            self.showAlertMessage("An unexpected error occurred: \(error.localizedDescription)")
        }
    }
    
    private func showAlertMessage(_ message: String) {
        self.alertMessage = message
        self.showAlert.toggle()
        self.isLoading.toggle()
    }
}
