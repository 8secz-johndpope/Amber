//
//  ProfileViewController.swift
//  Eylet
//
//  Created by Temporary on 3/13/20.
//  Copyright © 2020 Temporary. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func swipeToRight(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)

    }
    
    
}
