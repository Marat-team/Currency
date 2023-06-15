//
//  StorageManager.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 16.05.2023.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let valuteKey = "valutes"
    private let selectKey = "select"
    
    func saveValute(valute: Valute) {
        fetchValutes { valutes in
            var valutes = valutes
            valutes.append(valute)
            guard let data = try? JSONEncoder().encode(valutes) else { return }
            self.userDefaults.set(data, forKey: self.valuteKey)
        }
    }
    
    func deleteValute(valute: Int) {
        fetchValutes { valutes in
            var valutes = valutes
            valutes.remove(at: valute)
            guard let data = try? JSONEncoder().encode(valutes) else { return }
            self.userDefaults.set(data, forKey: self.valuteKey)
        }
    }
    
    func fetchValutes(complition: @escaping ([Valute]) -> Void) {
        guard let data = userDefaults.object(forKey: valuteKey) as? Data else { return }
        guard let valutes = try? JSONDecoder().decode([Valute].self, from: data) else { return }
        complition(valutes)
    }
    
    func saveList(valutes: [Valute]) {
        guard let data = try? JSONEncoder().encode(valutes) else { return }
        userDefaults.set(data, forKey: selectKey)
    }
    
    func fetchList(complition: @escaping ([Valute]) -> Void) {
        guard let data = userDefaults.object(forKey: selectKey) as? Data else { return }
        guard let valutes = try? JSONDecoder().decode([Valute].self, from: data) else { return }
        complition(valutes)
    }
}
