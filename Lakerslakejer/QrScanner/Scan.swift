//
//  Prospect.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-24.
//


import SwiftUI

class Scan: Identifiable, Codable {
    var id = UUID()
    var memberNumber = "0000"
    var couponNumber = "0"
    //fileprivate(set) var isContacted = false
}


@MainActor class Members: ObservableObject {
    @Published private(set) var memberArray: [Scan]
    let saveKey = "SavedData"

    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Scan].self, from: data) {
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

    func add(_ prospect: Scan) {
        memberArray.append(prospect)
        save()
    }

    
}
