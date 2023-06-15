//
//  ListInteractorWorker.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 15.06.2023.
//

import Foundation

protocol InteractorWorkerInput {
    func fetchDataNetwork(valutes: [Valute])
}

class ListInteractorWorker: InteractorWorkerInput {
    let url = URLS.currencyapi.rawValue
    weak var interactor: InteractorWorkerOutput?
    var dataNetwork: [DataCurrency] = []
    
    func fetchDataNetwork(valutes: [Valute]) {
        NetworkManager.shared.fetchData(from: url) { exchange, dataCurrency in
            self.dataNetwork = dataCurrency
            self.interactor?.acceptData(dataCurrency: self.dataNetwork)
        }
    }
}
