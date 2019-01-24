//
//  ListViewController.swift
//  PantryPro
//
//  Created by Dylan Martinez on 1/23/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var lists: [List]?
  @IBOutlet var tableView: UITableView!
  
  @IBAction func newListOnClick(_ sender: Any) {
    let alertController = UIAlertController(title: "New List", message: "enter the name of your list", preferredStyle: .alert)
    alertController.addTextField { (textField : UITextField!) -> Void in
      textField.placeholder = "New List"
    }
    let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
      
    }
    let create = UIAlertAction(title: "Create", style: .default) { (UIAlertAction) in
      let nameField = alertController.textFields![0] as UITextField
      let newList = List(name: nameField.text ?? "")
      if(self.lists == nil){
        self.lists = [newList]
      } else {
        self.lists?.append(newList)
      }
      self.tableView.reloadData()
    }
    alertController.addAction(cancel)
    alertController.addAction(create)

    self.present(alertController, animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.delegate = self
    self.tableView.dataSource = self
    

    
        // Do any additional setup after loading the view.
    }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if(section == 0){
      return self.lists?.count ?? 0
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "List Cell", for: indexPath) as! ListCell
    let thisList = self.lists?[indexPath.row]
    cell.nameLabel.text = thisList?.name
    return cell
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
