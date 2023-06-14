//
//  ListPresenter.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 09.06.2023.
//

protocol ListPresentationLogic {
    func fetchData(response: Response)
}

protocol PresenterWorkerOutput: AnyObject {
    func listPresent(valutes: [Valute])
}

class ListPresenter: ListPresentationLogic {
    weak var viewController: ListDisplayLogic?
    var worker: ListPresenterWorker?
    
    func fetchData(response: Response) {
        let charCodeAPI = response.dataCurrency.map { $0.CharCode }
        let iteraction = response.valutes.count
        let valutes = response.valutes
        let dataCurrency = response.dataCurrency
        worker?.fetchCharCode(charCodeAPI, iteraction, valutes, dataCurrency)
    }
}

extension ListPresenter: PresenterWorkerOutput {
    func listPresent(valutes: [Valute]) {
        var rows: [ListCellViewModel] = []
        valutes.forEach { rows.append(ListCellViewModel(valute: $0)) }
        let viewModel = ViewModel(rows: rows)
        viewController?.displayList(viewModel: viewModel)
    }
}
