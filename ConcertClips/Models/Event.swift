//
//  Event.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/4/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Event: Identifiable, Comparable, Codable, Hashable {
    
  // MARK: Fields
  @DocumentID var id: String?
  var name: String
  
  // MARK: Codable
  enum CodingKeys: String, CodingKey {
    case id
    case name
  }
  
  // MARK: Comparable
  static func ==(lhs: Event, rhs: Event) -> Bool {
    return lhs.name == rhs.name
  }
  
  static func <(lhs: Event, rhs: Event) -> Bool {
    return lhs.name < rhs.name
  }
  
}
