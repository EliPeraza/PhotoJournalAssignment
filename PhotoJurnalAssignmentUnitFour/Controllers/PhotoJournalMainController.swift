//
//  ViewController.swift
//  PhotoJurnalAssignmentUnitFour
//
//  Created by Elizabeth Peraza  on 1/14/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class PhotoJournalMainController: UIViewController {
  
  var arrayOfPhotoItems = [PhotoJournal] () {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  private var imagePickerViewController: UIImagePickerController!
  
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    arrayOfPhotoItems = PhotoJournalModel.getPhotoJournal()
    dump(arrayOfPhotoItems)
    collectionView.dataSource = self
    collectionView.delegate = self
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    collectionView.reloadData()
  }
  
  
  
  @IBAction func addPhotoEntry(_ sender: Any) {
    // this is where I present the add/edit controller 
    
    
  }
  
  
  @IBAction func editButtonPressed(_ sender: UIButton) {
    
    let actionSheet = UIAlertController(title: "XXXX", message: "Choose an option", preferredStyle: .actionSheet)
    let deleteAction = UIAlertAction(title: "Delete", style: .destructive)
    
    let editAction = UIAlertAction(title: "Edit", style: .default, handler:
    {
      (alert:UIAlertAction!) -> Void in
      //code goes here
      print("hi")
    })
    
    
    
    
    let saveAction = UIAlertAction(title: "Save", style: .default)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    
    actionSheet.addAction(deleteAction)
    actionSheet.addAction(editAction)
    actionSheet.addAction(saveAction)
    actionSheet.addAction(cancelAction)
    
    self.present(actionSheet, animated: true, completion: nil)
    
  }
}

extension PhotoJournalMainController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrayOfPhotoItems.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoJournalCell", for: indexPath) as? PhotoJournalCellCollectionViewCell else {return UICollectionViewCell()}
    
    let itemToPost = arrayOfPhotoItems[indexPath.item]
    cell.title.text = itemToPost.description
    cell.date.text = itemToPost.dateFormattedString
    cell.photoImage.image = UIImage(data: itemToPost.imageData)
    
    return cell
  }
  
  
}

extension PhotoJournalMainController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize.init(width: collectionView.bounds.width, height: collectionView.bounds.height)
    
  }
}

