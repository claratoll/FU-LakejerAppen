//
//  Prospect.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-24.
//


import SwiftUI
import FirebaseFirestoreSwift

struct BookedUser: Identifiable, Codable {
    @DocumentID var id : String?
    var memberNumber : Int
    var couponNumber : Int
    var booked: Bool = false
    var scanned: Bool = false
}
