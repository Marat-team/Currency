//
//  OptionsModels.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 15.06.2023.
//

import Foundation

typealias OptionsCellViewModel = Options.ShowList.ViewModel.OptionsCellViewModel
typealias OptionsRequest = Options.ShowList.Request
typealias OptionsResponse = Options.ShowList.Response
typealias OptionsViewModel = Options.ShowList.ViewModel

protocol OptionsCellIdentifible {
    var identifier: String { get }
    var height: CGFloat { get }
}

enum Options {
    // MARK: - Use cases
    enum ShowList {
        struct Request {
            let indexPath: Int
            let rows: [OptionsCellViewModel]
        }
        
        struct Response {
            let valutes: [Valute]
        }
        
        struct ViewModel {
            struct OptionsCellViewModel: OptionsCellIdentifible {
                let image: String
                let labelCurrency: String
                let labelCharCode: String
                let checkmark: Bool
                
                var identifier: String {
                    "cell"
                }
                var height: CGFloat {
                    50
                }
                
                init(valute: Valute) {
                    self.image = valute.flag
                    self.labelCurrency = valute.name
                    self.labelCharCode = valute.charCode
                    self.checkmark = valute.checkmark
                }
            }
            
            let rows: [OptionsCellViewModel]
        }
    }
}
