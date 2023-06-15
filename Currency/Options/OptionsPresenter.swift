//
//  OptionsPresenter.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 15.06.2023.
//

protocol OptionsPresentationLogic {
    func presentList(response: OptionsResponse)
}

class OptionsPresenter: OptionsPresentationLogic {
    weak var viewController: OptionsDisplayLogic?
    
    func presentList(response: OptionsResponse) {
        var rows: [OptionsCellViewModel] = []
        response.valutes.forEach { rows.append(OptionsCellViewModel(valute: $0)) }
        let viewModel = OptionsViewModel(rows: rows)
        viewController?.displayList(viewModel: viewModel)
    }
}
