//
//  SearchForRecipesViewController.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 11/12/2018.
//  Copyright © 2018 VBoulanger. All rights reserved.
//

import UIKit

class SearchForRecipesViewController: UIViewController {
	
	//===================================
	// -MARK : OUTLETS
	//===================================
	@IBOutlet weak var searchIngredientsTextField: UITextField!
	@IBOutlet weak var addButtonOutlet: UIButton!
	@IBOutlet weak var clearButtonOutlet: UIButton!
	@IBOutlet weak var ingredientsTableView: UITableView!
	@IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var searchForRecipesButton: UIButton!
	
	let recipeAPIService = RecipeAPIService()
	var userListIngredient = [String]()
	var ingredientList = [RecipeAPIResult]()
	var matches: [Match]!
	
	func addIngredientToDisplay() {
		if searchIngredientsTextField.text == "" {
			presentAlert(title: "An Omission ?", message: "You must enter an ingredient ! ")
			return
		} else {
			guard let userIngredients = searchIngredientsTextField.text?.changeToArray else {return}
			for i in userIngredients {				userListIngredient.append(i.firstUppercased)
			}
			ingredientsTableView.reloadData()
			hideKeyboard()
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "segueRecipesToDisplay" {
			if let matches = matches {
				let successVC = segue.destination as! ResultListRecipeViewController
				successVC.matches = matches
			}
		}
	}
	
	func requestSearchForRecipes() {
		//toggleActivityIndicator(shown: true)
		print("requestSearchForRecipes")
		recipeAPIService.requestRecipes(recipeList: userListIngredient) { (success, dataYum) in
			if success {
				print("test success")
				guard let dataYum = dataYum else {return}
				self.matches = dataYum.matches
				print(dataYum.matches)
				print(dataYum.totalMatchCount)
				self.performSegue(withIdentifier: "segueRecipesToDisplay", sender: nil)
			}
		}
	}
	//===================================
	// -MARK : IBACTION
	//===================================
	
	@IBAction func addButtonIBAction(_ sender: UIButton) {
		print("add ingredient button")
		addIngredientToDisplay()
		searchIngredientsTextField.text = ""
		ingredientsTableView.reloadData()
	}
	@IBAction func clearButtonIBAction(_ sender: UIButton) {
		print("clear ingredient button")
		userListIngredient.removeAll()
		searchIngredientsTextField.text = ""
		ingredientsTableView.reloadData()
	}
	
	@IBAction func searchForRecipeIBActionButton(_ sender: UIButton) {
		print("searchForRecipeIBActionButton")
	//	toggleActivityIndicator(shown: true)
		requestSearchForRecipes()
	}
	
	//================================
	// MARK : - Animation
	//================================
	func toggleActivityIndicator(shown: Bool) {
		searchForRecipesButton.isHidden = shown
		ActivityIndicator.isHidden = !shown
	}
	//================================
	// MARK : - ToolBar
	//================================
	private func createToolbar() {
		let toolBar = UIToolbar()
		toolBar.sizeToFit()
		toolBar.barTintColor = .black
		toolBar.tintColor = .white
		let searchRecipeButton = UIBarButtonItem(title: "Recherche une recette", style: .plain, target: self, action: #selector(SearchForRecipesViewController.searchForRecipeIBActionButton))
		toolBar.setItems ([searchRecipeButton], animated: false)
		toolBar.isUserInteractionEnabled = true
		searchIngredientsTextField.inputAccessoryView = toolBar
	}
	//================================
	// MARK : - ViewDidLoad
	//================================

		override func viewDidLoad() {
			super.viewDidLoad()
			ingredientsTableView.dataSource = self
			
//			toggleActivityIndicator(shown: false)
			createToolbar()
			addButtonOutlet.layer.cornerRadius = 5
			clearButtonOutlet.layer.cornerRadius = 5
			searchForRecipesButton.layer.cornerRadius = 5
			// call userfault
			//let ingredient1 = UserDefaults.standard.object(forKey: "ingredient1") as? String
			
			//let ingredientsRequestData: NSFetchRequest<IngredientCD> = IngredientCD.fetchRequest() //creation de la requete ingredient dans CoreData
			//guard let ingredients = try? AppDelegate.viewContext.fetch(ingredientsRequestData) else {return} // recupération des infos ingredienst en bdd Core Data
		}
	
	override func viewWillAppear(_ animated: Bool) {
		toggleActivityIndicator(shown: false)
		//ingredientsCD = IngredientCD.all // rechargement visuel de la liste dans Core Data
	//	ingredientsTableView.reloadData()
	}
}
extension SearchForRecipesViewController: UITableViewDataSource {

	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return userListIngredient.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)
		let recipe = userListIngredient[indexPath.row]
		//let ingredientsSaved = UserDefaults.standard.string(forKey: "ingredientsSaved") ?? "€"
		cell.textLabel?.text = "\(recipe)"
		return cell
	}
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		userListIngredient.remove(at: indexPath.row)
		ingredientsTableView.deleteRows(at: [indexPath], with: .automatic) // je confirme la suppression
		ingredientsTableView.reloadData()
	}
}


extension SearchForRecipesViewController : UITextFieldDelegate {
	func hideKeyboard() {
		searchIngredientsTextField.resignFirstResponder()
	}
	@IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
		hideKeyboard()
	}
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		print("Return Pressed")
		addIngredientToDisplay()
		hideKeyboard()
		return true
	}
}
