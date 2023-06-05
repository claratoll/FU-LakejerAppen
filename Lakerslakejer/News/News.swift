//
//  News.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-16.
//


import Foundation
import SwiftUI
import FirebaseFirestoreSwift


struct News : Codable, Identifiable, Equatable {
    @DocumentID var id: String?
    var date : Date? = Date()
    var headLine : String?
    var content : String?
    var newsText : String?
    var images : String?
}
