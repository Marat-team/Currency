//
//  OptionsInteractor.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 15.06.2023.
//

protocol OptionsBusinessLogic {
    func fetchData()
    func deleteCheckmark(request: OptionsRequest)
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
    
    func deleteCheckmark(request: OptionsRequest) {
        let valutes = checkmarkValutes(rows: request.rows)
        let checkValutes = checkmarkToggle(index: request.indexPath, valutes: valutes)
        responseValutes(valutes: checkValutes)
    }
    
    func checkmarkValutes(rows: [OptionsCellViewModel]) -> [Valute] {
        var valutes: [Valute] = []
        rows.forEach { row in
            let valute = Valute(flag: row.image,
                                charCode: row.labelCharCode,
                                name: row.labelCurrency,
                                checkmark: row.checkmark)
            valutes.append(valute)
        }
        return valutes
    }
    
    func checkmarkToggle(index: Int, valutes: [Valute]) -> [Valute] {
        var valutes = valutes
        valutes[index].checkmark.toggle()
        return valutes
    }
    
    func responseValutes(valutes: [Valute]) {
        let response = OptionsResponse(valutes: valutes)
        presenter?.checkmarkData(response: response)
    }
}
