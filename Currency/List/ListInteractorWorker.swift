//
//  ListInteractorWorker.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 15.06.2023.
//

import Foundation

protocol InteractorWorkerInput {
    func fetchDataNetwork(valutes: [Valute])
    func deleteCheckmark(rows: [ListCellViewModel], row: ListCellViewModel)
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
    
    func deleteCheckmark(rows: [ListCellViewModel], row: ListCellViewModel) {
        StorageManager.shared.fetchList { list in
            let charCodeList = list.map { $0.charCode }
            self.interactor?.fetchCharCode(rows: rows, row: row, charCodes: charCodeList, list: list)
        }
    }
}
