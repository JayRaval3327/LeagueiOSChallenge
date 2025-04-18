//
//  LoginResponse.swift
//  LeagueiOSChallenge
//
//  Copyright © 2024 League Inc. All rights reserved.
//

import Foundation

enum LoginType {
    case authenticated
    case guest
}

struct LoginResponse: Codable {
    let apiKey: String
}
