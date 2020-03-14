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
    var listOfCells: [TableViewCell] = []

    var listOfLikedItems: [CardsDataModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfCells = []
        tableView.frame = CGRect(x: 10, y: 100, width: view.frame.width - 20, height: view.frame.height - 100)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
//        tableView.backgroundColor =  UIColor(red: 236.0/255.0, green: 232.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        tableView.backgroundColor = #colorLiteral(red: 0.9408032298, green: 0.9283742309, blue: 0.9373263717, alpha: 1)
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
        
        if listOfCells.count > indexPath.row {
            return listOfCells[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        
        let currentLastItem = listOfLikedItems[indexPath.row]
        cell.product = currentLastItem
        
        cell.selectedBackgroundView?.layer.cornerRadius = 12
        cell.selectedBackgroundView?.clipsToBounds = true
        listOfCells.append(cell)
        return cell
        
    }
     func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let url = URL(string: listOfLikedItems[indexPath.row].link) else { return }
        UIApplication.shared.open(url)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
                self.listOfCells.remove(at: indexPath.row)
        self.listOfLikedItems.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
    
}
