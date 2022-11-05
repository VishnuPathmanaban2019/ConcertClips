//
//  Clip.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/5/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Clip: Identifiable, Comparable, Codable {
    
  // MARK: Fields
  @DocumentID var id: String?
  var name: String
  var event: String
  var user: String
  var section: String
  var song: String
  var likes: Int
  
  // MARK: Codable
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case event
    case user
    case section
    case song
    case likes
  }
  
  // MARK: Comparable
  static func ==(lhs: Clip, rhs: Clip) -> Bool {
    return lhs.name == rhs.name
  }
  
  static func <(lhs: Clip, rhs: Clip) -> Bool {
    return lhs.name < rhs.name
  }
  
}
