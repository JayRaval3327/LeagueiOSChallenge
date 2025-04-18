//
//  FeedViewModel.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-17.
//

import Foundation

enum ActiveAlert {
    case error, guest
}

class FeedViewModel: ObservableObject {
    
    private(set) var loginType: LoginType?
    private let apiHelper : APIHelper?
    private let router: FeedRouter?
    private let shouldDismiss: () -> Void
    
    @Published private(set) var feeds: [FeedDisplayable] = []
    @Published private(set) var isLoading = true
    @Published private(set) var alertMessage: String = String()
    @Published private(set) var activeAlert: ActiveAlert = .error
    @Published var showAlert: Bool = false
    
    private enum Labels {
        static let guestAlertTitle = "Thank you for trialing this app"
    }
    
    init(loginType: LoginType,
         apiHelper : APIHelper? = nil,
         router: FeedRouter? = nil,
         shouldDismiss: @escaping () -> Void) {
        self.loginType = loginType
        self.apiHelper = apiHelper
        self.router = router
        self.shouldDismiss = shouldDismiss
        
        Task {
            await fetchFeed()
        }
    }
    
    func fetchFeed() async {
        do {
            let data = try await getFeedData()
            print(data)
            await MainActor.run {
                self.feeds = data
                self.isLoading.toggle()
            }
        } catch {
            await MainActor.run {
                self.isLoading.toggle()
                self.showAlertMessage("An unexpected error occurred: \(error.localizedDescription)")
            }
        }
    }
    
    private func getFeedData() async throws -> [FeedDisplayable] {
        async let usersTask = apiHelper?.fetchUsers()
        async let postsTask = apiHelper?.fetchPosts()
        
        do {
            let (users, posts) = try await (usersTask, postsTask)
            guard let unwrappedUsers = users, let unwrappedPosts = posts else {
                throw APIError.invalidData
            }
            return createFeedDisplayItems(users: unwrappedUsers, posts: unwrappedPosts)
        } catch {
            throw error
        }
    }

    private func createFeedDisplayItems(users: Users, posts: Posts) -> [FeedDisplayable] {
        return posts.compactMap { post in
            guard let user = users.first(where: { $0.id == post.userId }) else {
                return nil
            }
            return FeedDisplayable(post: post, user: user)
        }
    }
    
    private func showAlertMessage(_ message: String) {
        self.alertMessage = message
        self.showAlert.toggle()
        self.isLoading = false
    }
    
    func dismissViewController() {
        self.shouldDismiss()
    }
    
    func showGuestAlertMessage() {
        self.activeAlert = .guest
        self.showAlert.toggle()
    }
    
    func didTapUser(_ feed: FeedDisplayable) {
        self.router?.presentProfileViewController(feed: feed)
    }
}
