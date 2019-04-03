//
//  FavoriteDetailVC.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 07/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import UIKit
import CoreData

class FavoriteDetailVC: UIViewController {
	@IBOutlet weak var backViewRateAndTime: UIView!
	@IBOutlet weak var imageRecipe: UIImageView!
	@IBOutlet weak var rateLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var recipeName: UILabel!
	@IBOutlet weak var instructionsTableView: UITableView!
	@IBOutlet weak var getDirections: UIButton!
	@IBOutlet weak var favoriteButton: UIBarButtonItem!
	var recipe = Recipe.fetchAll()
	var recipeDetail: Recipe?
	var instructions: Instruction?
	// reception du segue
	
	@IBAction func favoriteButtonAction(_ sender: UIBarButtonItem) {
		print("unlike favorite")
		guard let recipeID = recipeDetail?.id else {return}
		if Recipe.checkFavoriteID(id: recipeID) {
			Recipe.deleteFavoriteID(id: recipeID)
			favoriteButton.tintColor = .white
			try? AppDelegate.viewContext.save()
		} else {
			print("erreur (Recipe.checkFavoriteID)")
			favoriteButton.tintColor = .red
		}
		try? AppDelegate.viewContext.save()
		//Go controller précédent
		//navigationController?.popViewController(animated: true)
	}
	@IBAction func getRecipeDirection(_ sender: UIButton) {
		print("getRecipeDirection Detail")
		print("getRecipeDirection")
//		guard let recipeID = recipeDetail?.id else {return}
//		print("recipe ID favorite direction \(recipeID)")
//		//if Recipe.checkFavoriteID(id: recipeID) {
//			guard let urlSource = recipeDetail?.url else {return}
//			print("source : \(urlSource)")
//			guard let url = URL(string: urlSource) else {return}
//			UIApplication.shared.open(url)
//		} else {
//			print("error url favorite")
//		}
		
	}
	func designButton() {
		backViewRateAndTime.layer.cornerRadius = 5
		getDirections.layer.cornerRadius = 5
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		print("viewDidLoad Favorites")
		self.navigationItem.title = "Favorites"
		designButton()
		recipe = Recipe.fetchAll()
		instructionsTableView.dataSource = self
		instructionsTableView.reloadData()
		favoriteButton.tintColor = .red
		
		
	}
	override func viewWillAppear(_ animated: Bool) {
		recipe = Recipe.fetchAll()
		instructionsTableView.reloadData()
	}
	var test = ["test1","test2","test3","test4","test5"]
	var allInstruction = Instruction.all
}


extension FavoriteDetailVC: UITableViewDataSource {
	
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		
		return allInstruction.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteIngredientDetailCell", for: indexPath)
		guard let recipeID = recipeDetail?.id else {return cell}
		print("\(recipeID )recipeID")
		print(allInstruction[indexPath.row].name)
//		for i in allInstruction {
//			cell.textLabel?.text = i
//		}
		
		if Recipe.checkFavoriteID(id: recipeID) == false {
			print("recipe ID false")
		} else {
//			let instructionsEntityAllObjects = allInstruction[indexPath.row] as? [Instrution] //recipeDetail?.instructions?.allObjects as? [Recipe]
//			let instructions = instructionsEntityAllObjects?.map({$0.name ?? ""}) ?? []
			print("error recipe ID")
		}
		
		
		//cell.textLabel?.text = instructionsString.firstUppercased
		
		//recipeName.text = instructionsString.firstUppercased
		//guard let name = instructionsString.firstUppercased //recipe[indexPath.row].name else {return cell}
		//recipeName.text = test.description
//		guard let time = Int(recipe[indexPath.row].totalTime!) else {return cell}
//		timeLabel.text = String("\(time.convertIntToTime)")
//		guard let rate = recipe[indexPath.row].rate else {return cell}
//		rateLabel.text = rate + " / 5 "
		print("================ instruction entity")
//let test = recipe
		//let recipeInstructionsAllObjects = recipeDetail?.instructions?.allObjects as? [Instruction]
		//guard let resultInstructions = recipeInstructionsAllObjects else {return cell}
		//let instructions = resultInstructions.map({$0.name ?? ""})
		
		return cell
	}
}

