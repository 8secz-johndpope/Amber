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
    
    var stackContainer : StackContainerView!


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Expense Tracker"
        fetchData()
        stackContainer.dataSource = self

    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        stackContainer = StackContainerView()
        view.addSubview(stackContainer)
        configureStackContainer()
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        configureNavigationBarButtonItem()
    }
    
    func configureStackContainer() {
            stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
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


    
    static func readJSONFromFile(fileName: String) -> Any?
    {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                // Handle error here
            }
        }
        return json
    }
    
    
    func fetchData() {
        let myURLString = "https://gcrexample-tsaurfxama-lz.a.run.app/"
               guard let myURL = URL(string: myURLString) else {
                   print("Error: \(myURLString) doesn't seem to be a valid URL")
                   return
               }
               
               do {
                   let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
                   //print("HTML : \(myHTMLString)")
                   snippet = myHTMLString
               } catch let error {
                   print("Error: \(error)")
               }
//        snippet = ViewController.readJSONFromFile(fileName: "http://localhost:8080/hello/vapor") as! String
               snippet = cutBeforeCharacter(snippet: snippet, string: "<noscript> <ul><li>")
               snippet = cutAfterCharacter(snippet: snippet, string: " </noscript>" )
        guard let els: Elements = try? SwiftSoup.parse(snippet).select("img") else { return }
        
        for element: Element in els.array() {
            
        let decodedString = (try! element.attr("alt")).data(using: .isoLatin1)
            let cyrillicNameString = String(data: decodedString!, encoding: .utf8)!
            let decodedCyrillicNameString = cyrillicNameString.data(using: .isoLatin1)
            let stringDecodedCyrillicNameString = String(data: decodedCyrillicNameString!, encoding: .utf8)!
         arrayOfShoes.append(CardsDataModel(photoLink: try! element.attr("src"), name: stringDecodedCyrillicNameString, price: 0, isMale: false, brand: "stradivarius", mall: "Galeria"))

        }
        
        
//
    }
        
    func fillArray(string: String) {
        var photoLink = ""
        var name = ""
        var price: Int = 0
                let cutBeforeString  = cutBeforeCharacter(snippet: string, string: "<img src=\"")
        //print(cutBeforeString)
       
        let photoLinkString = cutAfterCharacter(snippet: cutBeforeString, string: "\" alt=")
        let nameStringCutBefore = cutBeforeCharacter(snippet: cutBeforeString, string: "alt=\"")
               
       //print(nameStringCutBefore)
        let nameString = cutAfterCharacter(snippet: nameStringCutBefore, string: "\"/><p>")
        let decodedString = nameString.data(using: .isoLatin1)
        let cyrillicNameString = String(data: decodedString!, encoding: .utf8)
        
        let priceStringBefore = cutBeforeCharacter(snippet: nameStringCutBefore, string: "</p><p>")
        let priceString = cutAfterCharacter(snippet: priceStringBefore, string: "</p></a>")
        
        
        name = cyrillicNameString ?? "errorName"
        photoLink = photoLinkString
        price = Int(priceString) ?? 0
        
        print(snippet)
        arrayOfShoes.append(CardsDataModel(photoLink: photoLink, name: name, price: price, isMale: false, brand: "stradivarius", mall: "Galleria SPB"  ))
        
        if priceStringBefore == "2599</p></a></li><li>" || priceStringBefore == "2599</p></a></li></ul>" {
            print("done")
        } else {
            print(priceStringBefore)
        fillArray(string: cutBeforeCharacter(snippet: priceStringBefore, string: "</p></a></li><li>"))
        }
    
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
