//
//  ListInteractor.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 09.06.2023.
//

protocol ListBusinessLogic {
    func fetchData()
}

protocol ListDataStore {
    var dataStorage: [Valute] { get }
}

protocol InteractorWorkerOutput: AnyObject {
    func acceptData(dataCurrency: [DataCurrency])
}

class ListInteractor: ListBusinessLogic, ListDataStore {
    var presenter: ListPresentationLogic?
    var worker: InteractorWorkerInput?
    var dataStorage: [Valute] = []
    
    func fetchData() {
        StorageManager.shared.fetchValutes { valutes in
            self.dataStorage = valutes
            self.worker?.fetchDataNetwork(valutes: self.dataStorage)
        }
    }
}

extension ListInteractor: InteractorWorkerOutput {
    func acceptData(dataCurrency: [DataCurrency]) {
        let response = Response(valutes: dataStorage, dataCurrency: dataCurrency)
        presenter?.fetchData(response: response)
    }
}
