//
//  DataManager.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 08.05.2023.
//

import UIKit

class DataManager {
    static let shared = DataManager()
    
    let flag = ["armenia", "australia", "azerbaijan", "belarus", "brazil",
                "bulgaria", "canada", "china", "czech", "denmark", "euro",
                "great britain", "hong kong", "hungary", "india", "japan",
                "kazakhstan", "kyrgyzstan", "moldova", "norway", "poland",
                "romania", "singapore", "south africa", "south korea",
                "sweden", "switzerland", "tajikistan", "turkey", "turkmenistan",
                "ukraine", "usa", "uzbekistan"]
    
    let charCode = ["AMD", "AUD", "AZN", "BYN", "BRL", "BGN", "CAD", "CNY",
                    "CZK", "DKK", "EUR", "GBP", "HKD", "HUF", "INR", "JPY",
                    "KZT", "KGS", "MDL", "NOK", "PLN", "RON", "SGD", "ZAR",
                    "KRW", "SEK", "CHF", "TJS", "TRY", "TMT", "UAH", "USD",
                    "UZS"]
    
    let name = ["Армянский драм", "Австралийский доллар", "Азербайджанский манат",
                "Беларусский рубль", "Бразильский реал", "Болгарский лев",
                "Канадский доллар", "Китайский юань", "Чешская крона",
                "Датская крона", "Евро", "Английский фунт", "Гонконгский доллар",
                "Венгерский форинт", "Индийская рупия", "Японская иена",
                "Казахстанский тенге", "Киргизский сом",
                "Молдавский лей", "Новержская крона", "Польский злотый",
                "Румынский лей", "Сингапурский доллар", "Южноафриканский рэнд",
                "Южнокорейская вона", "Шведская крона",
                "Швейцарский франк", "Таджикский сомони", "Турецкая лира",
                "Туркменский манат", "Украинская гривна", "Доллар США",
                "Узбекский сум"]
    
    private init() {}
}
