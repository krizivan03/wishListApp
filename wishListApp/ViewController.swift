//
//  ViewController.swift
//  wishListApp
//
//  Created by Christopher Canales on 3/21/20.
//  Copyright © 2020 Christopher Canales. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var m:itemModel?
    
    
    
//    @IBOutlet weak var itemSearchBar: UISearchBar!
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        m = itemModel(context: managedObjectContext)
        itemsTableView.rowHeight = 500
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (m?.fetchRecord().count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTableView.dequeueReusableCell(withIdentifier: "theItemCell", for: indexPath) as! itemTableViewCell
        cell.itemNameLabel.text = m?.fetchRecord()[indexPath.row].itemName
        cell.itemPriceLabel.text = "$ " + String((m?.fetchRecord()[indexPath.row].itemPrice)!)
        
        if let thereIsAnImage = m?.fetchRecord()[indexPath.row].itemImage{
            
            cell.itemImageView.image = UIImage(data: thereIsAnImage)
        }
               return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
//     implement delete function
       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
       {

           if editingStyle == .delete
           {

               // delete the selected object from the managed
               // object context
            m?.managedObjectContext.delete((m?.fetchRecord()[indexPath.row])!)
               do {
                   // save the updated managed object context
                   try managedObjectContext.save()
               } catch {
                   print("The delete method isn't working")
               }
               // reload the table after deleting a row
               itemsTableView.reloadData()
           }

       }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddEditView" {
            let addEditItemVC = segue.destination as! addEditItemViewController
            addEditItemVC.m_fromHome = m
            addEditItemVC.theTV = itemsTableView
        }
        if segue.identifier == "toItemDetailVC"{
            let itemDetailVC = segue.destination as! itemDetailViewController
            let selectedIndex: IndexPath = itemsTableView.indexPath(for: sender as! UITableViewCell)!
            itemDetailVC.anItem = m?.fetchRecord()[selectedIndex.row]
            
            
            
        }
        
    }
}


