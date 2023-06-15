//
//  OptionsInteractor.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 15.06.2023.
//

protocol OptionsBusinessLogic {
    func fetchData()
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
}
