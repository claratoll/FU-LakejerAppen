//
//  AdminModel.swift
//  Lakerslakejer
//
//  Created by Mouhammad Azroun on 2023-05-16.
//

import Foundation


import FirebaseFirestoreSwift

struct Admin: Codable, Identifiable {
    var id : String
    var accountType: String = "admin"
    var email: String
}
