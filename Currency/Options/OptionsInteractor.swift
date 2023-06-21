//
//  OptionsInteractor.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 15.06.2023.
//

protocol OptionsBusinessLogic {
    func fetchData()
    func checkmarkData(request: OptionsRequest)
}

protocol OptionsDataStore {
    var dataStorage: [Valute] { get }
}

class OptionsInteractor: OptionsBusinessLogic, OptionsDataStore {
    var presenter: OptionsPresentationLogic?
    var dataStorage: [Valute] = []
    
    func fetchData() {
        StorageManager.shared.fetchList { list in
            self.dataStorage = list
            let response = OptionsResponse(valutes: list)
            self.presenter?.presentList(response: response)
        }
    }
    
    func checkmarkData(request: OptionsRequest) {
        var valutes: [Valute] = []
        request.rows.forEach { row in
            let valute = Valute(flag: row.image,
                                charCode: row.labelCharCode,
                                name: row.labelCurrency,
                                checkmark: row.checkmark)
            valutes.append(valute)
        }
        valutes[request.indexPath].checkmark.toggle()
        let response = OptionsResponse(valutes: valutes)
        presenter?.checkmarkData(response: response)
    }
}
