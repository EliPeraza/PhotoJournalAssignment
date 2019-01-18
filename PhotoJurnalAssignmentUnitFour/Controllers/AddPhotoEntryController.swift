//
//  AddPhotoEntryController.swift
//  PhotoJurnalAssignmentUnitFour
//
//  Created by Elizabeth Peraza  on 1/14/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

/*TODO:
 When edit I can't go back into photo library to change the picture
I need to reflect instantly when I delete the images
*/

class AddPhotoEntryController: UIViewController {
  var imageIndex: Int?
  
  var isEditingPhotoJournal = false
  
  var photoEntryBeingEdited: PhotoJournal!
  
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  
  @IBOutlet weak var addImage: UIImageView!
  
  @IBOutlet weak var addDescription: UITextView!
  
  private var addDescriptionPlaceHolder = "Add description here..."
  
  private var imagePickerController: UIImagePickerController!
  
  var photoSelected = UIImage()
  override func viewDidLoad() {
    super.viewDidLoad()
    addDescription.becomeFirstResponder()
    if isEditingPhotoJournal {
      setupPhotoBeingEdited()
    }  else {
      setupPhotoViewController()
      setUpTextViews()
    }
    addDescription.delegate = self
  }
  
  
  private func setupPhotoBeingEdited(){
    addDescription.text = photoEntryBeingEdited.description
    addImage.image = UIImage.init(data: photoEntryBeingEdited.imageData)
  }
  
  private func setUpTextViews() {
    addDescription.text = addDescriptionPlaceHolder
    addDescription.textColor = .lightGray
  }
  
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
  
  
  @IBAction func savePhotoButtonPressed(_ sender: UIButton) {
    guard let textCaption = addDescription.text else {return}
    guard let photo = addImage.image else {return}
    let date = Date()
    let isoDateFormatter = ISO8601DateFormatter()
    isoDateFormatter.formatOptions = [.withFullDate, .withFullTime, .withInternetDateTime, .withTimeZone, .withDashSeparatorInDate]
    let timestamp = isoDateFormatter.string(from: date)
    if let imageData = photo.jpegData(compressionQuality: 0.5) {
      
      let photoItemToSave = PhotoJournal.init(createdAt:timestamp, imageData: imageData, description: textCaption)
      if let imageIndex = imageIndex {
        PhotoJournalModel.updateItem(updatedItem: photoItemToSave, atIndex: imageIndex)
      } else {
        PhotoJournalModel.addIEntry(item: photoItemToSave)
      }
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
    //TODO: When edit I can't go back into photo library to change the picture
    imagePickerController.sourceType = .photoLibrary
    showImagePickerController()
  }
  
  
  
}

extension AddPhotoEntryController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    
  }
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      addImage.image = image
      photoSelected = image
    } else {
      print("original image is nil")
    }
    dismiss(animated: true, completion: nil)
  }
}

extension AddPhotoEntryController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if addDescription.text == addDescriptionPlaceHolder {
      textView.text = ""
      textView.textColor = .black
    }
  }
}



