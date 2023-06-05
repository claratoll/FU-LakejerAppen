//
//  MemberModel.swift
//  Lakerslakejer
//
//  Created by Mouhammad Azroun on 2023-05-16.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id : String?
    var name: String
    var email: String
    var admin: Bool = false
    var memberNr: Int
    var coupons: Int = 0
    var lastCouponUsed : Date?
}
