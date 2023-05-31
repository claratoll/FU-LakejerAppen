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

/*
@MainActor class Members: ObservableObject {
    @Published private(set) var memberArray: [BookedUser]
    let saveKey = "SavedData"

    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([BookedUser].self, from: data) {
                memberArray = decoded
                return
            }
        }

        // no saved data!
        memberArray = []
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(memberArray) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    func add(_ prospect: BookedUser) {
        memberArray.append(prospect)
        save()
    }

    
}
*/
