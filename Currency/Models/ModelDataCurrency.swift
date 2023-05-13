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
    var value: Double
    var previous: Double
}

extension Valute {
    static func getList() -> [Valute] {
        var dataManager: [Valute] = []
        
        let flags = DataManager.shared.flag
        let charCodes = DataManager.shared.charCode
        let names = DataManager.shared.name
        var value: [Double] = []
        var previous: [Double] = []
        
        let iteration = min(flags.count, charCodes.count, names.count)
        
        for index in 0..<iteration {
            value.append(0)
            previous.append(0)
            
            let data = Valute(
                flag: flags[index],
                charCode: charCodes[index],
                name: names[index],
                value: value[index],
                previous: previous[index])
            dataManager.append(data)
        }
        
        return dataManager
    }
}
