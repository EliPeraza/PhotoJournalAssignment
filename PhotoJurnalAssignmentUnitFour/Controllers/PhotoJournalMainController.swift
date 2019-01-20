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
    setPhotosFromModel()
    dump(arrayOfPhotoItems)
    collectionView.dataSource = self
    collectionView.delegate = self
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setPhotosFromModel()
    collectionView.reloadData()
    
  }
  
  func setPhotosFromModel() {
    self.arrayOfPhotoItems = PhotoJournalModel.getPhotoJournal()
  }
  
  @IBAction func addPhotoEntry(_ sender: Any) {
    let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
    guard let vc = storyBoard.instantiateViewController(withIdentifier: "EditController") as? AddPhotoEntryController else { return }
    self.present(vc, animated: true, completion: nil)
    
  }
  
  
  @IBAction func editButtonPressed(_ sender: UIButton) {
    
    let actionSheet = UIAlertController(title: "Change Entry", message: "Choose an option", preferredStyle: .actionSheet)
    
    let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {
      _ in
      PhotoJournalModel.delete(atIndex: sender.tag)
      self.arrayOfPhotoItems = PhotoJournalModel.getPhotoJournal()
    })
    
    let editAction = UIAlertAction(title: "Edit", style: .default) { _ in
      let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
      guard let vc = storyBoard.instantiateViewController(withIdentifier: "EditController") as? AddPhotoEntryController else { return }
      vc.isEditingPhotoJournal = true 
      vc.imageIndex = sender.tag
      vc.photoEntryBeingEdited = self.arrayOfPhotoItems[sender.tag]
      self.present(vc, animated: true, completion: nil)
      
      
    }
    
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
      self.dismiss(animated: true, completion: nil)
    }
    
    let shareOption = UIAlertAction(title: "Share", style: .default, handler: {(share) in
      let shareText =  self.arrayOfPhotoItems[sender.tag].description
      if let image = UIImage.init(data: self.arrayOfPhotoItems[sender.tag].imageData) {
        let viewController = UIActivityViewController(activityItems: [shareText, image], applicationActivities: [])
        self.present(viewController, animated: true)
      }
    })
    
    actionSheet.addAction(deleteAction)
    actionSheet.addAction(editAction)
    actionSheet.addAction(cancelAction)
    actionSheet.addAction(shareOption)
    
    
    self.present(actionSheet, animated: true, completion: nil)
    
  }
}

extension PhotoJournalMainController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrayOfPhotoItems.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoJournalCell", for: indexPath) as? PhotoJournalCellCollectionViewCell else {return UICollectionViewCell()}
    
    let itemToPost = arrayOfPhotoItems[indexPath.row]
    
    cell.title.text = itemToPost.description
    cell.date.text = itemToPost.dateFormattedString
    cell.photoImage.image = UIImage(data: itemToPost.imageData)
    cell.optionsButton.tag = indexPath.row
    cell.layer.cornerRadius = 40
    
    return cell
  }
  
}

extension PhotoJournalMainController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize.init(width: collectionView.bounds.width, height: collectionView.bounds.height)
  }
  

}

