//
//  itemDetailViewController.swift
//  wishListApp
//
//  Created by Christopher Canales on 4/19/20.
//  Copyright © 2020 Christopher Canales. All rights reserved.
//

import UIKit

class itemDetailViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    var anItem : Item?
    var jsonItems: NSArray?
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemAdress: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var jsonItemsTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        itemName.text = anItem?.itemName
        if let anItemprice = anItem?.itemPrice{
            itemPrice.text = String(anItemprice)
        }
        else{
            itemPrice.text = ""
        }
        if let anItemAdress = anItem?.itemLocation {
            itemAdress.text = anItemAdress
        }
        else{
            itemAdress.text = ""
        }
        if let anItemIMG = anItem?.itemImage{
            itemImage.image = UIImage(data: anItemIMG)
        }
        jsonItemsTableView.rowHeight = 75
        jsonItemsTableView.allowsSelection = false
        
        
        DispatchQueue.main.async(execute: {
            self.getTableItems()
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let aJA = jsonItems{
            return aJA.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = jsonItemsTableView.dequeueReusableCell(withIdentifier: "jsonItemTableViewCell", for: indexPath) as! jsonItemTableViewCell
        let obj  = jsonItems![indexPath.row] as! NSDictionary
        var theTitle = obj["title"] as! String
        cell.jsonItemLabel.text = theTitle
//        print(theTitle)
        return cell
    }
    func getTableItems(){
        let headers = [
             "x-rapidapi-host": "amazon-price1.p.rapidapi.com",
             "x-rapidapi-key": "ddfa93fc54mshf7d5b2662f8bc2ep1c2573jsn61e7581c7b09"
         ]
        let theItem = anItem?.itemName!
//        I was using rapidAPI for my API, and i couldnt get the
        let theURL = "https://amazon-price1.p.rapidapi.com/search?keywords="+theItem!+"&marketplace=US"
         let request = NSMutableURLRequest(url: NSURL(string:theURL)! as URL,
                                                 cachePolicy: .useProtocolCachePolicy,
                                             timeoutInterval: 10.0)
         request.httpMethod = "GET"
         request.allHTTPHeaderFields = headers

         let session = URLSession.shared
         let jsonQuery = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
             if (error != nil) {
                 print(error)
             } else {
                 let jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSArray
                 self.jsonItems = jsonResult
                DispatchQueue.main.async {
                    self.jsonItemsTableView.reloadData()
                }
            }
         })

         jsonQuery.resume()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
