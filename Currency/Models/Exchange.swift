//
//  Exchange.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 08.05.2023.
//

import Foundation

struct Exchange: Decodable {
    let Date: String
    var Valute: [String: DataCurrency]
}

struct DataCurrency: Decodable {
    let CharCode: String
    let Nominal: Int
    let Value: Double?
    let Previous: Double?
}

enum URLS: String {
    case currencyapi = "https://www.cbr-xml-daily.ru/daily_json.js"
}
