//
//  View+Embeded.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-16.
//

import Foundation
import UIKit
import SwiftUI

extension View {
    func embedInHostingController() -> UIHostingController<Self> {
        let controller = UIHostingController(rootView: self)
        controller.view.backgroundColor = .white
        return controller
    }
}

extension UIViewController {
    func embedChildView<V: View>(_ view: V) {
        let controller = view.embedInHostingController()
        self.add(controller)
    }
    
    func add(_ child: UIViewController, containerView: UIView? = nil) {
        self.addChild(child)

        child.view.translatesAutoresizingMaskIntoConstraints = true
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        if let containerView {
            containerView.addSubview(child.view)
            child.view.frame = containerView.bounds
        } else {
            self.view.addSubview(child.view)
            child.view.frame = self.view.bounds
        }

        child.didMove(toParent: self)
    }
}
