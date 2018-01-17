//
//  CreateEntryViewController.swift
//  wineCollector
//
//  Created by Daniel Debner on 1/16/18.
//  Copyright © 2018 Daniel Debner. All rights reserved.
//

import UIKit

class CreateEntryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	@IBOutlet weak var addUpdateButton: UIButton!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var deleteButton: UIButton!
	
	var imagePicker = UIImagePickerController()
	var wine : Wine? = nil
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		imagePicker.delegate = self // delegate, like in tableView, an object uses a delegate to pull information it needs

		if wine != nil {
			imageView.image = UIImage(data: wine!.image as! Data)
			titleTextField.text = wine!.type
			
			addUpdateButton.setTitle("Update", for: .normal)
		} else {
			deleteButton.isHidden = true
		}
		
	}
	
	@IBAction func photosTapped(_ sender: Any) {
	
		imagePicker.sourceType = .photoLibrary
		
		present(imagePicker, animated: true, completion: nil)
		
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		let image = info[UIImagePickerControllerOriginalImage] as! UIImage // UIImage is data about image file
		
		imageView.image = image
		
		imagePicker.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func cameraTapped(_ sender: Any) {
	
		imagePicker.sourceType = .camera
		
	}
	
	@IBAction func addTapped(_ sender: Any) {
	
		if wine != nil {
		
			wine!.type = titleTextField.text
			wine!.image = UIImagePNGRepresentation(imageView.image!)
			
		} else {
		
		let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
		
		let wine = Wine(context: context)
		wine.type = titleTextField.text
		
		// Turn image into PNG
		
		wine.image = UIImagePNGRepresentation(imageView.image!)
		
		}
			
		(UIApplication.shared.delegate as! AppDelegate).saveContext()
		
		navigationController!.popViewController(animated: true)
		
	}
	
	@IBAction func deleteTapped(_ sender: Any) {
		let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
		
		context.delete(wine!)
		
		(UIApplication.shared.delegate as! AppDelegate).saveContext()
		
		navigationController!.popViewController(animated: true)
		
	}
	
}
