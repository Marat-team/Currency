//
//  ListRouter.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 09.06.2023.
//

import UIKit

@objc protocol ListRoutingLogic {
//    func routeToOptions(segue: UIStoryboardSegue?)
}

protocol ListDataPassing {
    var dataStore: ListDataStore? { get }
}

class ListRouter: NSObject, ListRoutingLogic, ListDataPassing {
    weak var viewController: ListViewController?
    var dataStore: ListDataStore?
    
//    func routeToOptions(segue: UIStoryboardSegue?) {
//        <#code#>
//    }
}
