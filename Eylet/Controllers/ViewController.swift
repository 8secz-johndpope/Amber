//
//  ViewController.swift
//  Eylet
//
//  Created by Temporary on 2/8/20.
//  Copyright © 2020 Temporary. All rights reserved.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController {
    
    var arrayOfShoes: [CardsDataModel] = []
    var snippet: String = ""
    
    @IBOutlet weak var leftButton: UIButton!
    var stackContainer : StackContainerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackContainer()
        view.backgroundColor = .white
        
        arrayOfShoes.append(CardsDataModel(photoLink:"https://www.overkillshop.com/media/catalog/product/cache/2/image/9df78eab33525d08d6e5fb8d27136e95/n/f/nf0a4agklkd_1.jpg", name: "hey", price: 0, isMale: true, brand: ""))
        
        arrayOfShoes.append(CardsDataModel(photoLink:"https://www.overkillshop.com/media/catalog/product/cache/2/image/9df78eab33525d08d6e5fb8d27136e95/n/f/nf0a4agklkd_1.jpg", name: "hey", price: 0, isMale: true, brand: ""))
        
        arrayOfShoes.append(CardsDataModel(photoLink:"https://www.overkillshop.com/media/catalog/product/cache/2/image/9df78eab33525d08d6e5fb8d27136e95/n/f/nf0a4agklkd_1.jpg", name: "hey", price: 0, isMale: true, brand: ""))
        
        stackContainer.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "swipeToLeft" {
        let destVC : ProfileViewController = segue.destination as! ProfileViewController
        } else {
        let destVC : LikedViewController = segue.destination as! LikedViewController
        }
    }

    
    @IBAction func segueToRight(_ sender: Any) {
        performSegue(withIdentifier: "swipeToRight", sender: nil)
    }
    
    @IBAction func segueToLeft(_ sender: Any) {
        performSegue(withIdentifier: "swipeToLeft", sender: nil)
    }
    func setupStackContainer() {
        stackContainer = StackContainerView()
        view.addSubview(stackContainer)
        configureStackContainer()
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        configureNavigationBarButtonItem()
        stackContainer.dataSource = self
    }
    
    func configureStackContainer() {
        stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30).isActive = true
        stackContainer.widthAnchor.constraint(equalToConstant: 300).isActive = true
        stackContainer.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    func configureNavigationBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetTapped))
    }
    
    //MARK: - Handlers
    @objc func resetTapped() {
        stackContainer.reloadData()
    }
}

extension ViewController : SwipeCardsDataSource {
    
    func numberOfCardsToShow() -> Int {
        return arrayOfShoes.count
    }
    
    func card(at index: Int) -> SwipeCardView {
        let card = SwipeCardView()
        card.dataSource = arrayOfShoes[index]
        return card
    }
    
    func emptyView() -> UIView? {
        return nil
    }
    
    
}
