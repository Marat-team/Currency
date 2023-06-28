//
//  ListInteractor.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 09.06.2023.
//

protocol ListBusinessLogic {
    func fetchData()
    func deleteCheckmark(request: Request)
}

protocol ListDataStore {
    var dataStorage: [Valute] { get }
}

protocol InteractorWorkerOutput: AnyObject {
    func acceptData(dataCurrency: [DataCurrency])
    func fetchCharCode(rows: [ListCellViewModel], row: ListCellViewModel, charCodes: [String], list: [Valute])
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
    
    func deleteCheckmark(request: Request) {
        StorageManager.shared.deleteValute(valute: request.index)
        let row = request.rows[request.index]
        var rows = request.rows
        rows.remove(at: request.index)
        worker?.deleteCheckmark(rows: rows, row: row)
    }
}

extension ListInteractor: InteractorWorkerOutput {
    func acceptData(dataCurrency: [DataCurrency]) {
        let response = Response(valutes: dataStorage, dataCurrency: dataCurrency)
        presenter?.fetchData(response: response)
    }
    
    func fetchCharCode(rows: [ListCellViewModel], row: ListCellViewModel, charCodes: [String], list: [Valute]) {
        guard let indexCharCode = charCodes.firstIndex(of: row.labelCharCode) else { return }
        dataStorage = list
        dataStorage[indexCharCode].checkmark.toggle()
        let response = ResponseCheckmark(rows: rows, valutes: dataStorage)
        presenter?.saveList(response: response)
    }
}
