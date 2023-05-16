//
//  ModelDataCurrency.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 08.05.2023.
//

struct Valute: Codable {
    let flag: String
    let charCode: String
    let name: String
    var value: Double
    var previous: Double
    var checkmark: Bool
}

extension Valute {
    static func getList() -> [Valute] {
        var dataManager: [Valute] = []
        
        let flags = DataManager.shared.flag
        let charCodes = DataManager.shared.charCode
        let names = DataManager.shared.name
        var value: [Double] = []
        var previous: [Double] = []
        var checkmark: [Bool] = []
        
        let iteration = min(flags.count, charCodes.count, names.count)
        
        for index in 0..<iteration {
            value.append(0)
            previous.append(0)
            checkmark.append(false)
            
            let data = Valute(
                flag: flags[index],
                charCode: charCodes[index],
                name: names[index],
                value: value[index],
                previous: previous[index],
                checkmark: checkmark[index])
            dataManager.append(data)
        }
        
        return dataManager
    }
}
