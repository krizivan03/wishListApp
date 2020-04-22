//
//  addEditItemViewController.swift
//  wishListApp
//
//  Created by Christopher Canales on 3/21/20.
//  Copyright © 2020 Christopher Canales. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class addEditItemViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var m_fromHome:itemModel?
    var theTV: UITableView?
    var selectedLoc:MKMapItem?
    
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UITextField!
    @IBOutlet weak var itemPriceLabel: UITextField!
    @IBOutlet weak var aLocationLabel: UILabel!
    @IBOutlet weak var addEditPhotoLabel: UILabel!
    @IBOutlet weak var mapIcon: UIButton!
    @IBOutlet weak var cameraIcon: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        itemNameLabel.addDoneButtonOnKeyboard()
        itemPriceLabel.addDoneButtonOnKeyboard()
        itemImage.image = nil
        self.addPhoto()
        if let aLoc = selectedLoc{
            aLocationLabel.text = aLoc.name
        }
    }
    @IBAction func addEditPhoto(_ sender: UIButton) {
        addPhoto()
    }
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        if (itemNameLabel.text?.count)! > 0 {
            let ent = NSEntityDescription.entity(forEntityName: "Item", in: (m_fromHome?.managedObjectContext)!)
            let newItem = Item(entity: ent!, insertInto: m_fromHome?.managedObjectContext)
            newItem.itemName = itemNameLabel.text
            if (itemPriceLabel.text?.count)! > 0 {
                newItem.itemPrice = Double(itemPriceLabel.text!)!
            }
            if let aLoc = selectedLoc{
                newItem.itemLocation = aLoc.placemark.title!
            }
            if let anImage = itemImage.image {
                newItem.itemImage = anImage.pngData()
            }
            
            do {
                try m_fromHome?.managedObjectContext.save()
            } catch _ {
                print("This doesn't work")
            }
            print((m_fromHome?.fetchRecord().count)!)
            theTV?.reloadData()
            goBackfunc()
        }
        else{
            let alert = UIAlertController(title: "Must Add Item Name", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    @IBAction func fromLocVC(segue: UIStoryboardSegue){
        
        if let sourceView = segue.source as? locationViewController  {
            selectedLoc = sourceView.selectedLoc
            if let aLoc = selectedLoc{
                aLocationLabel.text = aLoc.name
                aLocationLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
                
            }
            else{
                let alert = UIAlertController(title: "You didn't chose Location", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    func addPhoto(){

        let alert = UIAlertController(title: "Add a Photo", message: nil, preferredStyle: .alert)
        
        let useLibrary = UIAlertAction(title: "Photo Library", style: .default) { (aciton) in
        let picker = UIImagePickerController ()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        }
        let useCamera = UIAlertAction(title: "Camera", style: .default){
            (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let picker = UIImagePickerController ()
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerController.SourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                self.present(picker, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "No Camera Available", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
        alert.addAction(useLibrary)
        alert.addAction(useCamera)
        alert.addAction(UIAlertAction(title: "Skip", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker .dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            itemImage.image = image
            addEditPhotoLabel.text = "Change Photo"
            addEditPhotoLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        }
    }
    
    func goBackfunc(){
        navigationController?.popViewController(animated: true)
    }
}


/*---------------------------------*/
extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}



