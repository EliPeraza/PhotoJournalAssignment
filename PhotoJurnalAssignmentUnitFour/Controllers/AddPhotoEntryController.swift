//
//  AddPhotoEntryController.swift
//  PhotoJurnalAssignmentUnitFour
//
//  Created by Elizabeth Peraza  on 1/14/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class AddPhotoEntryController: UIViewController {
  
  
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  
  @IBOutlet weak var addImage: UIImageView!
  
  @IBOutlet weak var addDescription: UITextView!
  
  private var addDescriptionPlaceHolder = "Add description here..."
  
  private var imagePickerController: UIImagePickerController!
  
  var photoSelected = UIImage()
  override func viewDidLoad() {
    super.viewDidLoad()
    setupPhotoViewController()
    
  }
  
//  private func updateUI() {
//    if let photo = PhotoJournalModel.getPhotoJournal() {
//     let image = UIImage(data: photo.imageData)
//    } else {
//     print("photo journal does not exist")
//    }
//
//  }
  
  private func setupPhotoViewController() {
    imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    if !UIImagePickerController.isSourceTypeAvailable(.camera) {
      cameraButton.isSpringLoaded = false
    }
  }
  
  
  private func showImagePickerController() {
    present(imagePickerController, animated:  true, completion: nil)
  }
  
//  private func savePhotoJournal(image: UIImage) {
//    if let imageData = image.jpegData(compressionQuality: 0.5) {
//      let photoJournal = PhotoJournal.init(createdAt: "no date", imageData: imageData, description: "Cool Wall Paper")
//      PhotoJournalModel.savePhotoJournal()
//    }
//  }

  
  @IBAction func savePhotoButtonPressed(_ sender: UIButton) {
    guard let textCaption = addDescription.text else {return}
    guard let photo = addImage.image else {return}
    let date = Date()
    let isoDateFormatter = ISO8601DateFormatter()
    isoDateFormatter.formatOptions = [.withFullDate, .withFullTime, .withInternetDateTime, .withTimeZone, .withDashSeparatorInDate]
    let timestamp = isoDateFormatter.string(from: date)
    if let imageData = photo.jpegData(compressionQuality: 0.5) {
      let photoJournal = PhotoJournal.init(createdAt:timestamp, imageData: imageData, description: textCaption)
      PhotoJournalModel.savePhotoJournal()
    }
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func cancelButtonPressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
    imagePickerController.sourceType = .camera
    showImagePickerController()
    
  }
  
  
  @IBAction func photoLibraryButtonPressed(_ sender: UIBarButtonItem) {
    imagePickerController.sourceType = .photoLibrary
    showImagePickerController()
  }

  
  
}

extension AddPhotoEntryController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
  
  }
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//      savePhotoJournal(image: image)
      addImage.image = image
      photoSelected = image
    } else {
     print("original image is nil")
    }
    dismiss(animated: true, completion: nil)
  }
}
