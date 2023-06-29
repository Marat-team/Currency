//
//  OptionsRouter.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 27.06.2023.
//

import Foundation

protocol OptionsRoutingLogic {
    func deleteCheckmark(valute: Valute)
}

protocol OptionsDataPassing {
    var dataStore: OptionsDataStore? { get }
}

class OptionsRouter: NSObject, OptionsRoutingLogic, OptionsDataPassing {
    weak var viewController: OptionsViewController?
    var dataStore: OptionsDataStore?
    
    func deleteCheckmark(valute: Valute) {
        <#code#>
    }
}
