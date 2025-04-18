//
//  LoginViewControllerTests.swift
//  LeagueiOSChallengeTests
//
//  Created by Jay Raval on 2025-04-18.
//

import XCTest
import SwiftUI
@testable import LeagueiOSChallenge

class LoginViewControllerTests: XCTestCase {
    
    var sut: LoginViewController!
    var mockViewModel: MockLoginViewModel!
    
    override func setUp() {
        super.setUp()
        sut = LoginViewController()
        mockViewModel = MockLoginViewModel()
        sut.viewModel = mockViewModel
    }
    
    override func tearDown() {
        sut = nil
        mockViewModel = nil
        super.tearDown()
    }
    
    func testViewDidLoad() {
        sut.viewDidLoad()
        
        XCTAssertNotNil(sut.view)
    }
    
    func testViewModelDidSet() {
        let newViewModel = MockLoginViewModel()
        
        sut.viewModel = newViewModel
        
        XCTAssertNotNil(sut.childView)
    }
}

class LoginSceneTests: XCTestCase {
    
    func testLoadViewController() {
        let mockAPIHelper = MockAPIHelper()
        let scene = LoginScene(apiHelper: mockAPIHelper)
        
        let viewController = scene.loadViewController()
        
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController.viewModel)
        
        let castedViewModel = viewController.viewModel as? LoginViewModel
        XCTAssertNotNil(castedViewModel)
    }
}

class MockLoginViewModel: LoginViewModel {
    var loginButtonTapped = false
    var guestButtonTapped = false
    
    override func didTapOnLoginButton() {
        loginButtonTapped = true
        super.didTapOnLoginButton()
    }
    
    override func didTapOnGuestButton() {
        guestButtonTapped = true
        super.didTapOnGuestButton()
    }
}
