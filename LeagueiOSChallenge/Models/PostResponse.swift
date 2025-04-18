//
//  PostResponse.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-17.
//

import Foundation

typealias Posts = [PostResponse]

struct PostResponse: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
