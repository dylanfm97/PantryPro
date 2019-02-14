//
//  IndividualRecipeViewController.swift
//  PantryPro
//
//  Created by Dylan Martinez on 2/9/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import UIKit

class IndividualRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet var tableView: UITableView!
  var recipe: Recipe!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.delegate = self
    self.tableView.dataSource = self
    
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3;
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else if section == 1 {
      return 1
    } else if  section == 2 {
      return 1
    } else {
      return 0
    }
    
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerCell = tableView.dequeueReusableCell(withIdentifier: "recipeHeaderCell") as! RecipeHeaderCell
    
    switch(section) {
    case 0 :
      headerCell.nameLabel.text = "Name:"
    case 1:
      headerCell.nameLabel.text = "Ingredients:"
    case 2:
      headerCell.nameLabel.text = "Directions:"
    default:
      headerCell.nameLabel.text = ""
    }
    return headerCell
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "recipeNameCell", for: indexPath) as! RecipeNameCell
      cell.selectionStyle = .none
      cell.nameTextField.text = self.recipe.name
      
      return cell
    } else if indexPath.section == 1 {
      var cell:IngredientListCell? = tableView.dequeueReusableCell(withIdentifier: "ingredientListCell") as! IngredientListCell?
      if cell == nil {
       cell = IngredientListCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ingredientListCell")
      }
      cell?.recipe = self.recipe
      cell?.selectionStyle = .none
      return cell!
    } else if indexPath.section == 2 {
      var cell:DirectionsListCell? = tableView.dequeueReusableCell(withIdentifier: "directionsListCell") as! DirectionsListCell?
      if cell == nil {
        cell = DirectionsListCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "directionsListCell")
      }
      cell?.recipe = self.recipe
      cell?.selectionStyle = .none
      return cell!
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientListCell") as! IngredientListCell
      return cell
    }
  }
}
