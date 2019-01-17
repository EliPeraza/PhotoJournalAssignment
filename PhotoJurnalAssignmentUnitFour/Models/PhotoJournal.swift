//
//  PhotoJournal.swift
//  PhotoJurnalAssignmentUnitFour
//
//  Created by Elizabeth Peraza  on 1/15/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

struct PhotoJournal: Codable {
  let createdAt: String
  let imageData: Data
  let description: String
  
  public var dateFormattedString: String {
    let isoDateFormatter = ISO8601DateFormatter()
    var formattedDate = createdAt
    if let date = isoDateFormatter.date(from: createdAt) {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MMMM d, yyyy hh:mm a"
      formattedDate = dateFormatter.string(from: date)
    }
    return formattedDate
  }
  public var date: Date {
    let isoDateFormatter = ISO8601DateFormatter()
    var formattedDate = Date()
    if let date = isoDateFormatter.date(from: createdAt) {
      formattedDate = date
    }
    return formattedDate
  }
}
