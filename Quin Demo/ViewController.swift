//
//  ViewController.swift
//  Quin Demo
//
//  Created by krishna on 13/12/19.
//  Copyright © 2019 david. All rights reserved.
//



import UIKit

struct Entirejsondata : Decodable {
    
    var status : String
    var totalResults : Int
    var articles : [articles]
    
}

struct articles : Decodable {
    
    var source : source
    var author : String?
    var title : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var publishedAt : String?
    var content : String?
  
}

struct source : Decodable {
    
    var id : String?
    var name : String?
    
}


class ViewController: UIViewController {
    
    var articlesArray : [articles] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        myActivityIndicator.center = view.center
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=fd3dd6fe8a334ff2b7275aa5bd887a2f"
        
        guard let urlObj = URL(string: urlString) else { return }
        
        let download = URLSession.shared.dataTask(with: urlObj) { (data, response, error) in
            
            DispatchQueue.main.async {
            
            guard let data = data else { return }
                
            do {
                
                let decodedData = try JSONDecoder().decode(Entirejsondata.self, from: data)
                
                self.articlesArray = decodedData.articles
                
                print("decodededData \(self.articlesArray)")
                
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
                
                myActivityIndicator.stopAnimating()
                myActivityIndicator.isHidden = true
                
            }
            
            catch {
                print("error")
                print("Bharat")
            }

            }
        }
        
        download.resume()
        
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
              
              Cell.selectionStyle = .none
              
              let articles = articlesArray[indexPath.row]
            
                        Cell.nameLabel.text = articles.source.name
                           
                        Cell.titleLabel.text = articles.title
                       
                        let imageUrlString = articles.urlToImage
        
                        if imageUrlString != "" && imageUrlString != nil
                            
                        {
                            
                    if let urlObj = URL(string: imageUrlString!) {

                        if let myData = NSData(contentsOf: urlObj) {
                            
                            Cell.authorImage.image = UIImage(data: myData as Data)

                        }
                        
                        else {
                            
                            Cell.authorImage.image = UIImage(named: "placeholder")

                            }
                        }

            else {

                Cell.authorImage.image = UIImage(named: "placeholder")

            }

        }
        else
        {
            Cell.authorImage.image = UIImage(named: "placeholder")

        }

                       return Cell
                
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension

    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVc = storyboard?.instantiateViewController(withIdentifier: "NextViewController") as! NextViewController
        
        nextVc.articles = articlesArray[indexPath.row]
        
        self.navigationController?.pushViewController(nextVc, animated: true)
        
        
    }
    
    
}
