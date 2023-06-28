//
//  OptionsConfigurator.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 15.06.2023.
//

import Foundation

class OptionsConfigurator {
    static let shared = OptionsConfigurator()
    
    private init() {}
    
    func configure(with viewController: OptionsViewController) {
        let interactor = OptionsInteractor()
        let presenter = OptionsPresenter()
        let router = OptionsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
