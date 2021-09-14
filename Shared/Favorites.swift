//
//  Favorites.swift
//  SnowSeeker
//
//  Created by saj panchal on 2021-09-13.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    let userDefault = UserDefaults.standard
    init() {
        
        self.resorts = []
        if let decodedData = userDefault.object(forKey: "favorites") as? Data {
            let decoder = JSONDecoder()
            if let data = try? decoder.decode(Set<String>.self, from: decodedData) {
                self.resorts = data
            }
            else {
                fatalError("can't load data")
            }
        }
        
    }
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(resorts) {
            
            userDefault.set(encoded, forKey: "favorites")
        }
    }
}
