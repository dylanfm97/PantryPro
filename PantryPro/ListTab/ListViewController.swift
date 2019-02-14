//
//  ListViewController.swift
//  PantryPro
//
//  Created by Dylan Martinez on 1/23/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var listStore: ListStore!
  @IBOutlet var tableView: UITableView!
  @IBOutlet var editButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.editButton.title = "Edit"
    
//    let rightButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("showEditing:")))
   // self.navigationItem.rightBarButtonItem = // Do any additional setup after loading the view.
    navigationItem.leftBarButtonItem = editButtonItem
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
  
  @IBAction func newListOnClick(_ sender: Any) {
    let alertController = UIAlertController(title: "New List", message: "enter the name of your list", preferredStyle: .alert)
    alertController.addTextField {
      (textField : UITextField!) -> Void in
      textField.placeholder = "New List"
    }
    let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in}
    let create = UIAlertAction(title: "Create", style: .default) { (UIAlertAction) in
      let nameField = alertController.textFields![0] as UITextField
      let newList = List(name: nameField.text ?? "")
      self.listStore.addList(newList: newList)
      
      self.tableView.reloadData()
    }
    alertController.addAction(cancel)
    alertController.addAction(create)
    self.present(alertController, animated: true, completion: nil)
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if(section == 0){
      return self.listStore.allLists.count 
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "List Cell", for: indexPath) as! ListCell
    let thisList = self.listStore.allLists[indexPath.row]
    cell.nameLabel.text = thisList.name
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let thisList = self.listStore.allLists[indexPath.row]
      let title = "Delete \(thisList.name)?"
      let message = "Are you sure you want to delete this item?"
      let ac = UIAlertController(title: title,
                                 message: message,
                                 preferredStyle: .actionSheet)
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      ac.addAction(cancelAction)
      let deleteAction = UIAlertAction(title: "Delete", style: .destructive,
                                       handler: { (action) -> Void in
                                        self.listStore.removeList(thisList)
                                        tableView.deleteRows(at: [indexPath], with: .automatic)
      })
      ac.addAction(deleteAction)
      present(ac, animated: true, completion: nil)
    }
  }
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let movedList = self.listStore.allLists[sourceIndexPath.row];
    self.listStore.allLists.remove(at: sourceIndexPath.row)
    self.listStore.allLists.insert(movedList, at: destinationIndexPath.row)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "editList" {
      let indexPath = self.tableView.indexPathForSelectedRow
      if let i = indexPath {
        let c = segue.destination as! IndividualListViewController
        c.list = self.listStore.allLists[i.row]
      }
    }
  }

}
