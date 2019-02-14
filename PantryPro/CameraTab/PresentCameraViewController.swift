//
//  PresentCameraViewController.swift
//  PantryPro
//
//  Created by Dylan Martinez on 2/12/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import UIKit

class PresentCameraViewController: UIViewController {
  
  let cameraController = CameraController()
  
  @IBOutlet var captureButton: UIButton!
  @IBOutlet var capturePreviewView: UIView!
  
  override func viewDidLoad() {
    func configureCameraController() {
      cameraController.prepare {(error) in
        if let error = error {
          print(error)
        }
        
        try? self.cameraController.displayPreview(on: self.capturePreviewView)
      }
    }
    
    configureCameraController()
  }
  
 

}
