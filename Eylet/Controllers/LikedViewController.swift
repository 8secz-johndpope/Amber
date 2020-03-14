//
//  ProfileViewController.swift
//  Eylet
//
//  Created by Temporary on 3/13/20.
//  Copyright © 2020 Temporary. All rights reserved.
//

import Foundation
import UIKit

class LikedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    var tableView: UITableView = UITableView()
    let cellId = "cellId"

    var listOfLikedItems: [CardsDataModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.frame = CGRect(x: 10, y: 100, width: view.frame.width - 20, height: view.frame.height - 200)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        
           self.view.addSubview(tableView)

    }
    
    
    
    @IBAction func swipeToRight(_ sender: Any) {
        navigationController?.popViewController(animated: true)
               dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfLikedItems.count
      }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        let currentLastItem = listOfLikedItems[indexPath.row]
        cell.product = currentLastItem
        return cell
        
    }
     func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let url = URL(string: listOfLikedItems[indexPath.row].link) else { return }
        UIApplication.shared.open(url)
    }
  
    
    
}
