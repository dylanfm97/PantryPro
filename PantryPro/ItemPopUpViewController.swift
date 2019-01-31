//
//  ItemPopUpViewController.swift
//  PantryPro
//
//  Created by Dylan Martinez on 1/29/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import UIKit

class ItemPopUpViewController: UIViewController, UITextFieldDelegate {

  var listItem: ListItem!
  
  @IBOutlet var quantityTextField: UITextField!
  @IBOutlet var itemTextField: UITextField!
  var itemQuantity: Int = 0
  

  override func viewDidLoad() {
    super.viewDidLoad()
    self.itemTextField.text = listItem.item
    self.quantityTextField.text = String(listItem.quantity)
    
    self.itemTextField.delegate = self
    self.quantityTextField.delegate = self
    
    self.itemQuantity = self.listItem.quantity
    // Do any additional setup after loading the view.
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    self.listItem.item = self.itemTextField.text ?? ""
    self.listItem.quantity = Int(self.quantityTextField.text!)!
    
    NotificationCenter.default.post(name: Notification.Name(rawValue: "popUpGone"), object: nil)
  }
    
  @IBAction func dismiss(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
  
  @IBAction func incrementOnClick(_ sender: Any) {
    self.itemQuantity += 1
    self.quantityTextField.text = String(self.itemQuantity)
  }
  @IBAction func decrementOnClick(_ sender: Any) {
    self.itemQuantity -= 1
    if(self.itemQuantity < 0) { self.itemQuantity = 0 }
    self.quantityTextField.text = String(self.itemQuantity)

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
