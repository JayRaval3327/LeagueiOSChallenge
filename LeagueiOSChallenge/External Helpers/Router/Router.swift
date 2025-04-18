//
//  Router.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-17.
//

import Foundation
import UIKit

class Router<ViewController: UIViewController>: RouterProtocol {
    
    private(set) weak var controller: ViewController?
    
    init(controller: ViewController) {
        self.controller = controller
    }
    
    func presentModally(_ controllerToPresent: UIViewController,
                        detents: [UISheetPresentationController.Detent]? = nil,
                        animated: Bool = true,
                        embedInNavigationController: Bool = true,
                        completion: (() -> Void)? = nil) {
        let controller: UIViewController = embedInNavigationController ? UINavigationController(rootViewController: controllerToPresent) : controllerToPresent
        controller.sheetPresentationController?.detents = detents ?? [.large()]
        controller.sheetPresentationController?.prefersGrabberVisible = detents != nil
        self.controller?.present(controller, animated: animated, completion: completion)
    }
    
    func presentFullScreenModally(_ controllerToPresent: UIViewController,
                                  animated: Bool = true,
                                  embedInNavigationController: Bool = true,
                                  completion: (() -> Void)? = nil) {
        let controller: UIViewController = embedInNavigationController ? UINavigationController(rootViewController: controllerToPresent) : controllerToPresent
        controller.modalPresentationStyle = .fullScreen
        self.controller?.present(controller, animated: animated, completion: completion)
    }
}
