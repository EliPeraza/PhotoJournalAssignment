//
//  ViewController.swift
//  PhotoJurnalAssignmentUnitFour
//
//  Created by Elizabeth Peraza  on 1/14/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class PhotoJournalMainController: UIViewController {

  private var imagePickerViewController: UIImagePickerController!
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }

  
  
  @IBAction func addPhotoEntry(_ sender: Any) {
    // this is where I present the add/edit controller 
    
    
  }
  

  @IBAction func editButtonPressed(_ sender: UIButton) {
    
    let actionSheet = UIAlertController(title: "XXXX", message: "Choose an option", preferredStyle: .actionSheet)
    let deleteAction = UIAlertAction(title: "Delete", style: .default)
//    UIAlertAction(title: <#T##String?#>, style: <#T##UIAlertAction.Style#>) { (<#UIAlertAction#>) in
//      <#code#>
//    }
    let editAction = UIAlertAction(title: "Edit", style: .default)
    let saveAction = UIAlertAction(title: "Save", style: .default)
    let cancelAction = UIAlertAction(title: "Cancel", style: .default)
    
    actionSheet.addAction(deleteAction)
    actionSheet.addAction(editAction)
    actionSheet.addAction(saveAction)
    actionSheet.addAction(cancelAction)
    
    self.present(actionSheet, animated: true, completion: nil)
    
  }
}

//extension PhotoJournalMainController: UICollectionViewDataSource {
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//  }
//
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//  }
  

//}

//extension PhotoJournalMainController: UICollectionViewDelegate {
//
//}

