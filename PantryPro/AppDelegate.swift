//
//  AppDelegate.swift
//  PantryPro
//
//  Created by Dylan Martinez on 1/23/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  let listStore = ListStore()
  let recipeStore = RecipeStore()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    let tabBarController = window!.rootViewController as! UITabBarController
    
    let tabBar = tabBarController.tabBar;
    tabBar.items?[0].title = "Recipes";
    tabBar.items?[1].title = "Camera";
    tabBar.items?[2].title = "Lists";
    
    
    let recipeNavController = tabBarController.viewControllers![0] as! UINavigationController
    let recipeController = recipeNavController.topViewController as! RecipeViewController
    recipeController.recipeStore = self.recipeStore
    
    
    let listNavController = tabBarController.viewControllers![2] as! UINavigationController
    let listController = listNavController.topViewController as! ListViewController
    listController.listStore = self.listStore
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    let success = listStore.saveChanges()
    let recipeSuccess = recipeStore.saveChanges()
    if (success && recipeSuccess) {
      print("Saved all of the Items")
    } else {
      print("Could not save any of the Items")
    }
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    let success = listStore.saveChanges()
    let recipeSuccess = recipeStore.saveChanges()
    if (success && recipeSuccess) {
      print("Saved all of the Items")
    } else {
      print("Could not save any of the Items")
    }
  }


}

