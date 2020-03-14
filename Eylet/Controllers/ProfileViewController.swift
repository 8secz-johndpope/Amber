//
//  ProfileViewController.swift
//  Eylet
//
//  Created by Temporary on 3/13/20.
//  Copyright © 2020 Temporary. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var budgetField: UITextField!
    @IBAction func saveButton(_ sender: Any) {
        defaults.set(nameField.text, forKey: "name")
        defaults.set(emailField.text, forKey: "email")
        defaults.set(ageField.text, forKey: "age")
        defaults.set(budgetField.text, forKey: "budget")
    }
    
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.textColor = UIColor.lightGray
        nameField.textColor = UIColor.lightGray
        ageField.textColor = UIColor.lightGray
        budgetField.textColor = UIColor.lightGray
        
        if (defaults.value(forKey: "name") == nil){
        nameField.text = "Full name"
        }
        else{
            nameField.text = defaults.value(forKey: "name") as? String
        }
        
        if (defaults.value(forKey: "email") == nil){
            emailField.text = "Email"
        }
        else{
            emailField.text = defaults.value(forKey: "email") as? String
        }
        
        if (defaults.value(forKey: "age")==nil){
            ageField.text = "Age"
        }
        else{
            ageField.text = defaults.value(forKey: "age") as? String
        }

        if (defaults.value(forKey: "budget") == nil){
        budgetField.text = "Budget"
        }
        else{
            budgetField.text = defaults.value(forKey: "budget") as? String
        }
        
        profileLabel.font = UIFont(name: "Helvetica", size: 40)
        profileLabel.textAlignment = .center
        
        nameLabel.font = UIFont(name: "Helvetica", size: 14)
        
        emailLabel.font = UIFont(name: "Helvetica", size: 14)
        
        ageLabel.font = UIFont(name: "Helvetica", size: 14)
        
        budgetLabel.font = UIFont(name: "Helvetica", size: 14)
        
    }
    
    @IBAction func swipeToRight(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)

    }
    
}

