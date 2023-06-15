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
        let presenterWorker = ListPresenterWorker()
        let router = ListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = interactorWorker
        interactorWorker.interactor = interactor
        presenter.viewController = viewController
        presenter.worker = presenterWorker
        presenterWorker.presenter = presenter
        router.viewController = viewController
        router.dataStore = interactor
    }
}
