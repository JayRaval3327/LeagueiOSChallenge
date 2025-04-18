//
//  SwiftUIControllerScene.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-17.
//

import Foundation
import UIKit

protocol SwiftUIControllerScene {

    associatedtype ViewControllerType: UIViewController

    func loadViewController() -> ViewControllerType
}
