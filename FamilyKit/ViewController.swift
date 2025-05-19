//
//  ViewController.swift
//  FamilyKit
//
//  Created by Sharda Prasad on 18/05/25.
//

import UIKit
import DeviceActivity
import FamilyControls


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
    }


    @IBAction func checkFamilyKit(_ sender: Any) {
//        
//        let familyKit = FamilyControls()
//        familyKit.checkFamilyKitStatus()
        
        Task {
            do {
                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                print("Authorization granted!")
            } catch {
                print("Authorization failed: \(error)")
            }
        }
        
    }
    
    
}

