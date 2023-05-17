//
//  MemberModel.swift
//  Lakerslakejer
//
//  Created by Mouhammad Azroun on 2023-05-16.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id : String?

    var accountType: String = "member"
    var name: String
    var email: String
    var admin: Bool = false
}
