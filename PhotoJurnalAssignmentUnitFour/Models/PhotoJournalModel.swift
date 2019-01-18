//
//  PhotoJournalModel.swift
//  PhotoJurnalAssignmentUnitFour
//
//  Created by Elizabeth Peraza  on 1/14/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

final class PhotoJournalModel {
  
  static let filename = "PhotoJournalList.plist"
  private static var photoItems = [PhotoJournal]()
  
  private init() {}
  
  static func savePhotoJournal() {
    let path = DataPersistenceManager.filePathToDocumentsDirectory(filename: filename)
    print(path)
    do {
      let data = try PropertyListEncoder().encode(photoItems)
      try data.write(to: path, options: Data.WritingOptions.atomic)
    } catch {
      print("property list encoding error: \(error)")
    }
  }
  
  static func getPhotoJournal() -> [PhotoJournal] {
    let path = DataPersistenceManager.filePathToDocumentsDirectory(filename: filename).path
    if FileManager.default.fileExists(atPath: path){
      if let data = FileManager.default.contents(atPath: path) {
        do {
          photoItems = try PropertyListDecoder().decode([PhotoJournal].self, from: data)
        } catch {
          print("property list decoding error: \(error)")
        }
      } else {
        print("getPhotoJournal: data in nil")
      }
    } else {
      print("\(filename) does not exist")
    }
    photoItems = photoItems.sorted { $0.date > $1.date }
    return photoItems
  }
  
  static func addIEntry(item: PhotoJournal) {
    photoItems.append(item)
    savePhotoJournal()
  }
  
  static func delete(atIndex index: Int) {
    photoItems.remove(at: index)
    savePhotoJournal()
  }
  
  static func updateItem(updatedItem: PhotoJournal, atIndex index: Int) {
    photoItems[index] = updatedItem
    savePhotoJournal()
  }
}
