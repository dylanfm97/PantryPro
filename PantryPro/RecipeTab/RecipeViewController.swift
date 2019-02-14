//
//  RecipeViewController.swift
//  PantryPro
//
//  Created by Dylan Martinez on 2/4/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var recipeStore: RecipeStore!
  @IBOutlet var tableView: UITableView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.delegate = self
    self.tableView.dataSource = self
    // Do any additional setup after loading the view.
  }
  
  @IBAction func newRecipeOnClick(_ sender: Any) {
    let alertController = UIAlertController(title: "New Recipe", message: "enter the name of your recipe", preferredStyle: .alert)
    alertController.addTextField { (textField : UITextField!) in
      textField.placeholder = "New Recipe"
    }
    let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in}
    let create = UIAlertAction(title: "Create", style: .default) { (UIAlertAction) in
      let nameField = alertController.textFields![0] as UITextField
      let newRecipe = Recipe(name: nameField.text ?? "")
      self.recipeStore.addRecipe(recipe: newRecipe)
      
      self.tableView.reloadData()
    }
    alertController.addAction(cancel)
    alertController.addAction(create)
    self.present(alertController, animated: true, completion: nil)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if(section == 0){
      return self.recipeStore.allRecipes.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "Recipe Cell", for: indexPath) as! RecipeCell
    let thisRecipe = self.recipeStore.allRecipes[indexPath.row]
    cell.recipeNameLabel.text = thisRecipe.name
    
    return cell
  }

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "recipeSegue" {
      let indexPath = self.tableView.indexPathForSelectedRow
      if let i = indexPath {
        let c = segue.destination as! IndividualRecipeViewController
        c.recipe = self.recipeStore.allRecipes[i.row]
        
      }
    }
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
