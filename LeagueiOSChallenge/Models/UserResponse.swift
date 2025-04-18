//
//  UserResponse.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-17.
//

import Foundation

typealias Users = [UserResponse]

struct UserResponse: Decodable, Identifiable {
    let id: Int
    let avatar: String
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
    struct Address: Decodable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: Geo
        
        struct Geo: Decodable {
            let lat: String
            let lng: String
        }
    }
    
    struct Company: Decodable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}
