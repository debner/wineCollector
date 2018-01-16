//
//  CollectionViewController.swift
//  wineCollector
//
//  Created by Daniel Debner on 1/16/18.
//  Copyright © 2018 Daniel Debner. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var tableView: UITableView!
	
	var wines : [Wine] = []
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	
		tableView.dataSource = self
		tableView.delegate = self
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
		do {
		wines = try context.fetch(Wine.fetchRequest())
			print(wines)
			tableView.reloadData()
		} catch {
			print("Error")
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return wines.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		
		let wine = wines[indexPath.row] // Customization
		cell.textLabel?.text = wine.type
		cell.imageView?.image = UIImage(data: wine.image as! Data) // Need to reconvert from PNG to UIImage
		
		return cell
	}
	
}

