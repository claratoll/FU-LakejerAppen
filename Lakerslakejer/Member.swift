//
//  MemberModel.swift
//  Lakerslakejer
//
//  Created by Mouhammad Azroun on 2023-05-16.
//

import Foundation
import FirebaseFirestoreSwift

struct Member: Codable {
    var id: String
    var accountType: String = "member"
    var name: String
    var email: String
}
