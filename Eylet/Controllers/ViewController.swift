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
        var snippet = ""
        let myURLString = "https://mlhack.appspot.com/clothesJson"
        guard let myURL = URL(string: myURLString) else {
           // print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }

        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
           // print("HTML : \(myHTMLString)")
            snippet = myHTMLString
        } catch let error {
            print("Error: \(error)")
        }
        
       
        let data = snippet.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String: [[String:String]]]
            {
                for i in 0...jsonArray["items"]!.count - 1 {
                    let goodsName  = jsonArray["items"]?[i]["goodsName"]
                    let brandName  = jsonArray["items"]?[i]["brandName"]
                    let price  = (jsonArray["items"]?[i]["price"])!
                    let image  = jsonArray["items"]?[i]["image"]
                    let link =  jsonArray["items"]?[i]["link"]

                    arrayOfShoes.append(CardsDataModel(image: decodeToCyrillic(string: image!), goodsName: decodeToCyrillic(string: goodsName!), price: decodeToCyrillic(string: price), brandName: decodeToCyrillic(string: brandName!), link: decodeToCyrillic(string: link!)))
                  
                }
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
        

        
        
        stackContainer.reloadData()
    }
    
    func  decodeToCyrillic(string: String) -> String {
        let decodedString = string.data(using: .isoLatin1)
        let cyrillicNameString = String(data: decodedString!, encoding: .utf8)!
        return cyrillicNameString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "swipeToLeft" {
        let destVC : ProfileViewController = segue.destination as! ProfileViewController
        } else {
        let destVC : LikedViewController = segue.destination as! LikedViewController
            destVC.listOfLikedItems = stackContainer.customClass as! [CardsDataModel]
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
        stackContainer.heightAnchor.constraint(equalToConstant: 500).isActive = true
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
