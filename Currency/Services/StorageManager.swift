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
        var valutes = fetchValutes()
        valutes.append(valute)
        guard let data = try? JSONEncoder().encode(valutes) else { return }
        userDefaults.set(data, forKey: valuteKey)
    }
    
    func deleteValute(valute: Int) {
        var valutes = fetchValutes()
        valutes.remove(at: valute)
        guard let data = try? JSONEncoder().encode(valutes) else { return }
        userDefaults.set(data, forKey: valuteKey)
    }
    
    func fetchValutes() -> [Valute] {
        guard let data = userDefaults.object(forKey: valuteKey) as? Data else { return [] }
        guard let valutes = try? JSONDecoder().decode([Valute].self, from: data) else { return [] }
        return valutes
    }
    
    func saveList(valutes: [Valute]) {
        guard let data = try? JSONEncoder().encode(valutes) else { return }
        userDefaults.set(data, forKey: selectKey)
    }
    
    func fetchList() -> [Valute] {
        guard let data = userDefaults.object(forKey: selectKey) as? Data else { return Valute.getList() }
        guard let valutes = try? JSONDecoder().decode([Valute].self, from: data) else { return Valute.getList() }
        return valutes
    }
}
