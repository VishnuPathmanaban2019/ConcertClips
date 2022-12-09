//
//  User.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/5/22.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Comparable, Codable {
    
    // MARK: Fields
    @DocumentID var id: String?
    var username: String
    var myClips: [String] = []
    
    // MARK: Codable
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case myClips
    }
    
    // MARK: Comparable
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.username == rhs.username
    }
    
    static func <(lhs: User, rhs: User) -> Bool {
        return lhs.username < rhs.username
    }
    
}
