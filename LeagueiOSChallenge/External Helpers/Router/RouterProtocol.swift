//
//  RouterProtocol.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-17.
//

import Foundation
import UIKit

protocol RouterProtocol {
    func presentModally(_ controllerToPresent: UIViewController,
                        detents: [UISheetPresentationController.Detent]?,
                        animated: Bool,
                        embedInNavigationController: Bool,
                        completion: (() -> Void)?)
    
    func presentFullScreenModally(_ controllerToPresent: UIViewController,
                                  animated: Bool,
                                  embedInNavigationController: Bool,
                                  completion: (() -> Void)?)
}
