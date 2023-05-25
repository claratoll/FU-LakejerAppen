//
//  Game.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-25.
//


import Foundation
import FirebaseFirestoreSwift

struct Game: Codable, Identifiable {
    @DocumentID var id : String?
    var awayDate: Date
    var awayName: String
    var firstBookDate: Date
    var lastBookDate: Date
    var users: [User]
}
