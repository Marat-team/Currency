//
//  ModelDataCurrency.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 08.05.2023.
//

struct Valute {
    let flag: String
    let charCode: String
    let name: String
}

extension Valute {
    static func getList() -> [Valute] {
        var dataManager: [Valute] = []
        
        let flags = DataManager.shared.flag
        let charCodes = DataManager.shared.charCode
        let names = DataManager.shared.name
        
        let iteration = min(flags.count, charCodes.count, names.count)
        
        for index in 0..<iteration {
            let data = Valute(
                flag: flags[index],
                charCode: charCodes[index],
                name: names[index])
            dataManager.append(data)
        }
        
        return dataManager
    }
}
