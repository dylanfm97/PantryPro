//
//  listStore.swift
//  PantryPro
//
//  Created by Dylan Martinez on 1/24/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import Foundation

class ListStore {
  var allLists = [List]()
  
  let listArchiveURL: URL = {
    let documentsDirectories =
      FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = documentsDirectories.first!
    return documentDirectory.appendingPathComponent("lists.archive")
  }()
  
  init(){
    if let archivedLists =
      NSKeyedUnarchiver.unarchiveObject(withFile: listArchiveURL.path) as? [List] {
      allLists = archivedLists
    }
  }
  
  func saveChanges() -> Bool {
    print("Saving items to: \(listArchiveURL.path)")
    return NSKeyedArchiver.archiveRootObject(allLists, toFile: listArchiveURL.path)
  }
  
  @discardableResult func addList(name: String, items: [ListItem]?) -> List{
    let newList = List(name: name, listItems: items!)
    allLists.append(newList)
    return newList
  }
  
  @discardableResult func addList(newList: List) -> List{
    allLists.append(newList)
    return newList
  }
  
  func removeList(_ list: List){
    if let index = self.allLists.index(of: list){
      self.allLists.remove(at: index)
    }
  }
  
  
}
