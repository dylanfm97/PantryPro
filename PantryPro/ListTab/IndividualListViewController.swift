//
//  IndividualListViewController.swift
//  PantryPro
//
//  Created by Dylan Martinez on 1/24/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import UIKit

class IndividualListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet var editButton: UIBarButtonItem!
  var list: List!
  var didAppear = Notification.Name("didAppear")

  @IBOutlet var tableView: UITableView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.allowsSelectionDuringEditing = true
    
    
    NotificationCenter.default.addObserver(self, selector: #selector(appearedFromPopUp), name: Notification.Name(rawValue: "popUpGone"), object: nil)

    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.tableView.reloadData()
  }
  
  @objc func appearedFromPopUp() {
    self.tableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0{
      return list.items.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath) as! ListItemCell
    cell.quantityLabel.text = String(self.list.items[indexPath.row].quantity)
    cell.itemLabel.text = self.list.items[indexPath.row].item
    cell.selectionStyle = .none
    //cell.itemLabel.text = "I'M REALLY SORRY I REALLY AM"
    return cell
  }

  //button click handlers ------------ //
  @IBAction func addItemOnClick(_ sender: Any) {
    let newListItem = ListItem(quantity: 1, item: "")
    self.list.addItem(item: newListItem)
    self.tableView.reloadData()
    
    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "ListItemPopUp") as! ItemPopUpViewController
    vc.listItem = self.list.items[self.list.items.count-1]
    vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    present(vc, animated: true, completion:nil)
  }
  
  @IBAction func editButtonOnClick(_ sender: Any) {
    if(self.tableView.isEditing == true)
    {
      self.tableView.isEditing = false
      self.editButton.title = "Edit"
    }
    else
    {
      self.tableView.isEditing = true
      self.editButton.title = "Done"
    }
  }
  //---------------//
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let thisItem = self.list.items[indexPath.row]
      let title = "Delete \(thisItem.item)?"
      let message = "Are you sure you want to delete this item?"
      let ac = UIAlertController(title: title,
                                 message: message,
                                 preferredStyle: .actionSheet)
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      ac.addAction(cancelAction)
      let deleteAction = UIAlertAction(title: "Delete",
                                       style: .destructive,
                                       handler: {
                                        (action) -> Void in
                                        self.list.removeItem(item: thisItem)
                                        tableView.deleteRows(at: [indexPath], with: .automatic)
      })
      ac.addAction(deleteAction)
      present(ac, animated: true, completion: nil)
    }
  }
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let movedItem = self.list.items[sourceIndexPath.row]
    self.list.items.remove(at: sourceIndexPath.row)
    self.list.items.insert(movedItem, at: destinationIndexPath.row)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "editListItem" {
      let indexPath = tableView.indexPathForSelectedRow
      if let i = indexPath {
        let c = segue.destination as! ItemPopUpViewController
        c.listItem = self.list.items[i.row]
      }
    }
  }
  
  @IBAction func dismissPopUp(_ sender: Any) {
    print("Is this code being called?")
    self.presentedViewController?.dismiss(animated: true, completion: nil)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if self.tableView.isEditing {
      if  indexPath.section == 0 {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ListItemPopUp") as! ItemPopUpViewController
        vc.listItem = self.list.items[indexPath.row]
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        present(vc, animated: true, completion:nil)
      }
    } else { //not in editing mode
      if self.tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
        self.tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
      } else {
        self.tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
      }
    }
  }

}
