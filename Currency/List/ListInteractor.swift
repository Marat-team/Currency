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
    var worker: ListInteractorWorker?
    var dataStorage: [Valute] = []
    
    func fetchData() {
        worker = ListInteractorWorker()
        StorageManager.shared.fetchValutes { valutes in
            self.dataStorage = valutes
            self.worker?.fetchDataNetwork(valutes: self.dataStorage)
            print("1. Interactor is activate")
        }
    }
}

extension ListInteractor: InteractorWorkerOutput {
    func acceptData(dataCurrency: [DataCurrency]) {
        print("3. Worker of interactor output to interactor")
        let response = Response(valutes: dataStorage, dataCurrency: dataCurrency)
        presenter?.fetchData(response: response)
    }
}
