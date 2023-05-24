//
//  Prospect.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-24.
//


import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var memberNumber = "Anonymous"
    var couponNumber = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var memberArray: [Prospect]
    let saveKey = "SavedData"

    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
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

    func add(_ prospect: Prospect) {
        memberArray.append(prospect)
        save()
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
