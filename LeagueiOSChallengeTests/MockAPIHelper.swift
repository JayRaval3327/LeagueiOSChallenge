//
//  MockAPIHelper.swift
//  LeagueiOSChallengeTests
//
//  Created by Jay Raval on 2025-04-18.
//

import XCTest
@testable import LeagueiOSChallenge

// MARK: - Mock APIHelper for Testing
class MockAPIHelper: APIHelper {
    var mockUsers: [UserResponse]?
    var mockPosts: [PostResponse]?
    var mockToken: String = "mock-api-token-12345"
    var shouldThrowError = false
    var specificError: APIError?
    var delayInSeconds: Double?
    var callCount = CallCount()
    
    struct CallCount {
        var fetchUsers = 0
        var fetchPosts = 0
        var fetchUserToken = 0
    }
    
    override init(apiKey: String? = nil) {
        super.init(apiKey: apiKey)
    }
    
    override func fetchUserToken(username: String, password: String) async throws -> String {
        callCount.fetchUserToken += 1
        
        if let delay = delayInSeconds {
            try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        }
        
        if shouldThrowError {
            throw specificError ?? APIError.invalidData
        }
        
        return mockToken
    }
    
    override func fetchUsers() async throws -> Users {
        callCount.fetchUsers += 1
        
        if let delay = delayInSeconds {
            try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        }
        
        if shouldThrowError {
            throw specificError ?? APIError.invalidData
        }
        
        guard let users = mockUsers else {
            throw APIError.invalidData
        }
        
        return users
    }
    
    override func fetchPosts() async throws -> Posts {
        callCount.fetchPosts += 1
        
        if let delay = delayInSeconds {
            try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        }
        
        if shouldThrowError {
            throw specificError ?? APIError.invalidData
        }
        
        guard let posts = mockPosts else {
            throw APIError.invalidData
        }
        
        return posts
    }
    
    // MARK: - Helper Methods for Testing
    
    func setupSuccessfulResponses() {
        self.mockUsers = createMockUsers()
        self.mockPosts = createMockPosts()
        self.shouldThrowError = false
    }
    
    func setupEmptyResponses() {
        self.mockUsers = []
        self.mockPosts = []
        self.shouldThrowError = false
    }
    
    func setupErrorResponse(error: APIError = .invalidData) {
        self.shouldThrowError = true
        self.specificError = error
    }
    
    func resetCallCounts() {
        callCount = CallCount()
    }
    
    // MARK: - Mock Data Creation
    
    func createMockUsers() -> [UserResponse] {
        return [
            createMockUser(id: 1, name: "User One", username: "user1"),
            createMockUser(id: 2, name: "User Two", username: "user2"),
            createMockUser(id: 3, name: "User Three", username: "user3")
        ]
    }
    
    func createMockPosts() -> [PostResponse] {
        return [
            createMockPost(id: 1, userId: 1, title: "Post 1"),
            createMockPost(id: 2, userId: 1, title: "Post 2"),
            createMockPost(id: 3, userId: 2, title: "Post 3"),
            createMockPost(id: 4, userId: 3, title: "Post 4")
        ]
    }
    
    func createMockUser(id: Int, name: String, username: String) -> UserResponse {
        return UserResponse(
            id: id,
            avatar: "https://example.com/avatar\(id).jpg",
            name: name,
            username: username,
            email: "\(username)@example.com",
            address: UserResponse.Address(
                street: "Street \(id)",
                suite: "Suite \(id)",
                city: "City \(id)",
                zipcode: String(format: "%05d", id),
                geo: UserResponse.Address.Geo(lat: "0", lng: "0")
            ),
            phone: "555-\(String(format: "%03d", id))-1234",
            website: "\(username).example.com",
            company: UserResponse.Company(
                name: "Company \(id)",
                catchPhrase: "Catch phrase \(id)",
                bs: "Business strategy \(id)"
            )
        )
    }
    
    func createMockPost(id: Int, userId: Int, title: String) -> PostResponse {
        return PostResponse(
            userId: userId,
            id: id,
            title: title,
            body: "This is the body content for post \(id) created by user \(userId)."
        )
    }
}

// MARK: - Mock Login Response
struct LoginResponse: Decodable {
    let apiKey: String
}
