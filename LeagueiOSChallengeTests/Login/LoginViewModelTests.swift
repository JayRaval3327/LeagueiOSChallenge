//
//  LoginViewModelTests.swift
//  LeagueiOSChallengeTests
//
//  Created by Jay Raval on 2025-04-18.
//

import XCTest
@testable import LeagueiOSChallenge

class LoginViewModelTests: XCTestCase {
    
    var sut: LoginViewModel!
    var mockAPIHelper: MockAPIHelper!
    var mockRouter: MockLoginRouter!
    
    override func setUp() {
        super.setUp()
        mockAPIHelper = MockAPIHelper()
        mockRouter = MockLoginRouter()
        sut = LoginViewModel(apiHelper: mockAPIHelper, router: mockRouter)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIHelper = nil
        mockRouter = nil
        super.tearDown()
    }
    
    // MARK: - Initial State Tests
    
    func testInitialState() {
        // Then
        XCTAssertEqual(sut.username, "")
        XCTAssertEqual(sut.password, "")
        XCTAssertFalse(sut.showAlert)
        XCTAssertEqual(sut.alertMessage, "")
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
    }
    
    // MARK: - Login Button Tests
    
    func testDidTapOnLoginButton_WithEmptyUsername_ShouldShowAlert() {
        // Given
        sut.username = ""
        sut.password = "password123"
        
        // When
        sut.didTapOnLoginButton()
        
        // Then
        XCTAssertTrue(sut.showAlert)
        XCTAssertEqual(sut.alertMessage, "Please enter a username")
        XCTAssertFalse(sut.isLoading)
    }
    
    func testDidTapOnLoginButton_WithEmptyPassword_ShouldShowAlert() {
        // Given
        sut.username = "testuser"
        sut.password = ""
        
        // When
        sut.didTapOnLoginButton()
        
        // Then
        XCTAssertTrue(sut.showAlert)
        XCTAssertEqual(sut.alertMessage, "Please enter a password")
        XCTAssertFalse(sut.isLoading)
    }
    
    func testDidTapOnLoginButton_WithWhitespaceUsername_ShouldShowAlert() {
        // Given
        sut.username = "   "
        sut.password = "password123"
        
        // When
        sut.didTapOnLoginButton()
        
        // Then
        XCTAssertTrue(sut.showAlert)
        XCTAssertEqual(sut.alertMessage, "Please enter a username")
        XCTAssertFalse(sut.isLoading)
    }
    
    func testDidTapOnLoginButton_WithWhitespacePassword_ShouldShowAlert() {
        // Given
        sut.username = "testuser"
        sut.password = "   "
        
        // When
        sut.didTapOnLoginButton()
        
        // Then
        XCTAssertTrue(sut.showAlert)
        XCTAssertEqual(sut.alertMessage, "Please enter a password")
        XCTAssertFalse(sut.isLoading)
    }
    
    func testDidTapOnLoginButton_WithValidCredentials_ShouldCallAuthenticateUser() async {
        // Given
        sut.username = "testuser"
        sut.password = "password123"
        mockAPIHelper.mockToken = "test-token"
        
        // When
        sut.didTapOnLoginButton()
        
        // Wait for async operations to complete
        let expectation = XCTestExpectation(description: "Login completion")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        
        // Then
        XCTAssertTrue(mockAPIHelper.fetchUserTokenCalled)
        XCTAssertEqual(mockAPIHelper.username, "testuser")
        XCTAssertEqual(mockAPIHelper.password, "password123")
        XCTAssertTrue(mockRouter.presentFeedViewControllerCalled)
        XCTAssertEqual(mockRouter.loginType, .authenticated)
        XCTAssertEqual(mockRouter.apiKey, "test-token")
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.username, "")
        XCTAssertEqual(sut.password, "")
    }
    
    func testDidTapOnLoginButton_WhenAPIFails_ShouldShowAlert() async {
        // Given
        sut.username = "testuser"
        sut.password = "password123"
        mockAPIHelper.shouldThrowError = true
        mockAPIHelper.mockError = NSError(domain: "TestError", code: 401, userInfo: [NSLocalizedDescriptionKey: "Unauthorized"])
        
        // When
        sut.didTapOnLoginButton()
        
        // Wait for async operations to complete
        let expectation = XCTestExpectation(description: "Login failure")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        
        // Then
        XCTAssertTrue(mockAPIHelper.fetchUserTokenCalled)
        XCTAssertTrue(sut.showAlert)
        XCTAssertTrue(sut.alertMessage.contains("An unexpected error occurred"))
        XCTAssertFalse(sut.isLoading)
    }
    
    // MARK: - Guest Button Tests
    
    func testDidTapOnGuestButton_ShouldCallAuthenticateUser() async {
        // Given
        mockAPIHelper.mockToken = "guest-token"
        
        // When
        sut.didTapOnGuestButton()
        
        // Wait for async operations to complete
        let expectation = XCTestExpectation(description: "Guest login completion")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        
        // Then
        XCTAssertTrue(mockAPIHelper.fetchUserTokenCalled)
        XCTAssertTrue(mockRouter.presentFeedViewControllerCalled)
        XCTAssertEqual(mockRouter.loginType, .guest)
        XCTAssertEqual(mockRouter.apiKey, "guest-token")
        XCTAssertFalse(sut.isLoading)
    }
}

class MockLoginRouter: LoginRouter {
    var presentFeedViewControllerCalled = false
    var loginType: LoginType?
    var apiKey: String?
    
    func presentFeedViewController(loginType: LoginType, apiKey: String) {
        presentFeedViewControllerCalled = true
        self.loginType = loginType
        self.apiKey = apiKey
    }
}
