//
//  ListConfigurator.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 09.06.2023.
//

import Foundation

class ListConfigurator {
    static let shared = ListConfigurator()
    
    private init() {}
    
    func configure(with viewController: ListViewController) {
        let interactor = ListInteractor()
        let interactorWorker = ListInteractorWorker()
        let presenter = ListPresenter()
        let router = ListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactorWorker.interactor = interactor
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
