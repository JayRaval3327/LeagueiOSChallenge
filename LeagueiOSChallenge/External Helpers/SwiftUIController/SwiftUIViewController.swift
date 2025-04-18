//
//  SwiftUIViewController.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-16.
//

import Foundation
import SwiftUI

class SwiftUIViewController<ChildView: View>: UIViewController {
    
    var childView: ChildView?
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        if let childView = self.childView {
            self.embedChildView(childView)
        }
    }
}
