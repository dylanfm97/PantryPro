//
//  IndividualListViewController.swift
//  PantryPro
//
//  Created by Dylan Martinez on 1/24/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import UIKit

class IndividualListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var list: List!
  @IBOutlet var tableView: UITableView!

  @IBAction func addItemOnClick(_ sender: Any) {
    let newListItem = ListItem(quantity: 1, item: "")
    list.addItem(item: newListItem)
    self.tableView.reloadData()
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
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
