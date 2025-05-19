//
//  ScreenTimeReportVC.swift
//  FamilyKit
//
//  Created by Sharda Prasad on 18/05/25.
//

import UIKit
import FamilyControls
import DeviceActivity
import SwiftUI

class ScreenTimeReportVC: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        title = "Report"
        // Create the SwiftUI view
        let swiftUIView = ScreenTimeReportView()
        
        // Wrap it in a UIHostingController
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        // Add the hostingController as a child
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .white
        view.addSubview(hostingController.view)
        
        // Constrain the SwiftUI view to fill the UIKit view
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Finalize the child view controller
        hostingController.didMove(toParent: self)
    }
}
