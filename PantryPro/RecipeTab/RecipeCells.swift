//
//  RecipeCells.swift
//  PantryPro
//
//  Created by Dylan Martinez on 2/9/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import Foundation
import UIKit

//Cell within a tableview within a cell
class IngredientCell: UITableViewCell {
  
  @IBOutlet var ingredientLabel: UILabel!
  
  override func awakeFromNib(){
    super.awakeFromNib()
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
}

class DirectionCell: UITableViewCell {
  
  @IBOutlet var directionLabel: UILabel!
  
  override func awakeFromNib(){
    super.awakeFromNib()
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
}
//-------------------------------------


class IngredientListCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
  
  var recipe: Recipe?
  @IBOutlet var tableView: UITableView!
  @IBOutlet var editButton: UIButton!
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style , reuseIdentifier: reuseIdentifier)
    self.recipe = Recipe(name: "")
    self.setUpTable()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  //  fatalError("init(coder:) has not been implemented")
    self.setUpTable()
  }
  
  override func awakeFromNib(){
    super.awakeFromNib()
    self.setUpTable()
    self.tableView.reloadData()
    
    NotificationCenter.default.addObserver(self, selector: #selector(appearedFromPopUp), name: Notification.Name(rawValue: "popUpGone"), object: nil)
  }
  
  @objc func appearedFromPopUp() {
    self.tableView.reloadData()
  }
  
  func setUpTable() {
    self.tableView?.dataSource = self
    self.tableView?.delegate = self
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      if(self.recipe != nil){
        return self.recipe!.ingredients.count
      } else {
        return 0
      }
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientCell
    cell.ingredientLabel.text = self.recipe?.ingredients[indexPath.row].item
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let thisItem = self.recipe?.ingredients[indexPath.row]
      let title = "Delete\(thisItem?.item)?"
      let message = "Are you sure you want to delete this item?"
      let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      ac.addAction(cancelAction)
      let deleteAction = UIAlertAction(title: "Delete",
                                       style: .destructive,
                                       handler: {
                                        (action) -> Void in
                                        self.recipe?.removeIngredient(item:(thisItem ?? nil)!)
                                        tableView.deleteRows(at: [indexPath], with: .automatic)
      })
      ac.addAction(deleteAction)
      UIApplication.shared.keyWindow?.rootViewController?.present(ac, animated: true, completion: nil)
    }
  }
  
  @IBAction func editButtonOnClick(_ sender: Any) {
    if (self.tableView.isEditing == true) {
      self.tableView.isEditing = false
      self.editButton.setTitle("Edit", for: .normal)
    } else {
      self.tableView.isEditing = true
      self.editButton.setTitle("Done", for: .normal)    }
  }
  
  @IBAction func addIngredientOnClick(_ sender: Any) {
    let newListItem = ListItem(quantity: 1, item: "")
    self.recipe?.ingredients.append(newListItem)
    self.tableView.reloadData()
    
    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "ListItemPopUp") as! ItemPopUpViewController
    vc.listItem = self.recipe!.ingredients[self.recipe!.ingredients.count-1]
    vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated:true, completion:nil)
  }
}
//------------------------------------------------------

class DirectionsListCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
  
  var recipe: Recipe?
  @IBOutlet var tableView: UITableView!
  @IBOutlet var editButton: UIButton!
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.recipe = Recipe(name: "")
    self.setUpTable()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    //fatalError("init(coder:) has not been implemented")
    self.setUpTable()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setUpTable()
    self.tableView.reloadData()
    
    NotificationCenter.default.addObserver(self, selector: #selector(appearedFromPopUp), name: Notification.Name(rawValue: "popUpGone"), object: nil)
  }
  
  @objc func appearedFromPopUp() {
    self.tableView.reloadData()
  }
  
  func setUpTable() {
    self.tableView?.dataSource = self
    self.tableView?.delegate = self
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (self.recipe != nil) {
      return recipe!.directions.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "directionCell", for: indexPath) as! DirectionCell
    cell.directionLabel.text = self.recipe?.directions[indexPath.row]
    cell.directionLabel.numberOfLines = 0;
    cell.selectionStyle = .none
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let thisItem = self.recipe?.directions[indexPath.row]
      let title = "Delete\(thisItem)?"
      let message = "Are you sure you want to delete this item?"
      let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      ac.addAction(cancelAction)
      let deleteAction = UIAlertAction(title: "Delete",
                                       style: .destructive,
                                       handler: {
                                        (action) -> Void in
                                        self.recipe?.removeDirection(direction: thisItem!)
                                        tableView.deleteRows(at: [indexPath], with: .automatic)
      })
      ac.addAction(deleteAction)
      UIApplication.shared.keyWindow?.rootViewController?.present(ac, animated: true, completion: nil)
    }
  }
  
  @IBAction func editButtonOnClick(_ sender: Any) {
    if (self.tableView.isEditing == true) {
      self.tableView.isEditing = false
      self.editButton.setTitle("Edit", for: .normal)
    } else {
      self.tableView.isEditing = true
      self.editButton.setTitle("Done", for: .normal)    }
  }
  
  @IBAction func addDirectionOnClick(_ sender: Any) {
    self.tableView.reloadData()
    
    let alertController = UIAlertController(title: "Add Step", message: "type your directions", preferredStyle: .alert)
    alertController.addTextField { (textField:UITextField!) -> Void in
      textField.placeholder = "New Step"
    }
    let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in}
    let create = UIAlertAction(title: "Create", style: .default) { (UIAlertAction) in
      let setField = alertController.textFields![0] as UITextField
    self.recipe?.directions.append(setField.text ?? "")
      self.tableView.reloadData()
      
    }
    alertController.addAction(cancel)
    alertController.addAction(create)
    
    UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    
    
  }
  
}
// ------------------------------------------------

class RecipeNameCell: UITableViewCell {
  
  @IBOutlet var nameTextField: UITextField!
  
  override func awakeFromNib(){
    super.awakeFromNib()
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  
}



class RecipeHeaderCell: UITableViewCell {
  
  @IBOutlet var nameLabel: UILabel!
  
  override func awakeFromNib(){
    super.awakeFromNib()
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  
}
