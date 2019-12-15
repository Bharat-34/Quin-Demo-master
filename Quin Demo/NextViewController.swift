//
//  NextViewController.swift
//  Quin Demo
//
//  Created by krishna on 14/12/19.
//  Copyright © 2019 david. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
    
    @IBOutlet weak var authorsImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var publishedLabel: UILabel!
    
    
    var articles : articles?
    
    override func viewDidLoad() {
        super.viewDidLoad()

           guard let articles = articles else { return }

        if let urlObj = URL(string: articles.urlToImage ?? "Bharat") {
                 
                 
                 if let myData = NSData(contentsOf: urlObj) {
                     authorsImage.image = UIImage(data: myData as Data)
                     
                 }else {
                     authorsImage.image = UIImage(named: "placeholder")
                     
                 }
             }
                 
             else {
                 
                 authorsImage.image = UIImage(named: "placeholder")
                 
             }
             
        authorLabel.text = articles.author
        descriptionLbl.text = articles.description
        contentLbl.text = articles.content
        publishedLabel.text = articles.publishedAt
        
        
        
    }
    

 

}
