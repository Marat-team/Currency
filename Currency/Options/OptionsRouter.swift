//
//  OptionsRouter.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 27.06.2023.
//

import Foundation

@objc protocol OptionsRoutingLogic {
    
}

protocol OptionsDataPassing {
    var dataStore: OptionsDataStore? { get }
}

class OptionsRouter: NSObject, OptionsRoutingLogic, OptionsDataPassing {
    weak var viewController: OptionsViewController?
    var dataStore: OptionsDataStore?
}
