//
//  ListPresenterWorker.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 12.06.2023.
//

import Foundation

class ListPresenterWorker {
    weak var presenter: PresenterWorkerOutput?
    var dataValutes: [Valute] = []
    
    func fetchCharCode(_ charCodeAPI: [String],_ iteraction: Int,_ valutes: [Valute],_ dataCurrency: [DataCurrency]) {
        dataValutes = valutes
        
        for indexFromList in 0..<iteraction {
            guard let indexCharCode = charCodeAPI.firstIndex(of: dataValutes[indexFromList].charCode) else { return }
            guard let value = dataCurrency[indexCharCode].Value else { return }
            guard let previous = dataCurrency[indexCharCode].Previous else { return }
            
            dataFromCurrency(indexFromList, value, previous)
        }
        
        sendData(valutes: dataValutes)
    }
    
    func dataFromCurrency(_ index: Int,_ value: Double,_ previous: Double) {
        dataValutes[index].value = value
        dataValutes[index].previous = previous
    }
    
    func sendData(valutes: [Valute]) {
        presenter?.listPresent(valutes: valutes)
    }
}
