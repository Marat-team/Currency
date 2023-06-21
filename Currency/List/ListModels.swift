//
//  ListModels.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 09.06.2023.
//

import Foundation

typealias ListCellViewModel = List.ShowList.ViewModel.ListCellViewModel
typealias Request = List.ShowList.Request
typealias Response = List.ShowList.Response
typealias ResponseCheckmark = List.ShowList.Response.ResponseCheckmark
typealias ViewModel = List.ShowList.ViewModel

protocol CellIdentifible {
    var identifier: String { get }
    var height: CGFloat { get }
    var headerHeight: CGFloat { get }
    var numberSection: Int { get }
}

enum List {
    // MARK: - Use cases
    enum ShowList {
        struct Request {
            let index: Int
            let rows: [ListCellViewModel]
        }
        
        struct Response {
            let valutes: [Valute]
            let dataCurrency: [DataCurrency]
            
            struct ResponseCheckmark {
                let rows: [ListCellViewModel]
            }
        }
        
        struct ViewModel {
            struct ListCellViewModel: CellIdentifible {
                let image: String
                let labelCurrency: String
                let labelCharCode: String
                let labelValue: Double
                let labelPrevoius: Double
                
                var identifier: String {
                    "cell"
                }
                var height: CGFloat {
                    80
                }
                var headerHeight: CGFloat {
                    5
                }
                var numberSection: Int {
                    1
                }
                
                init(valute: Valute) {
                    self.image = valute.flag
                    self.labelCurrency = valute.name
                    self.labelCharCode = valute.charCode
                    self.labelValue = valute.value ?? 0
                    self.labelPrevoius = valute.previous ?? 0
                }
            }
            
            let rows: [ListCellViewModel]
        }
    }
}
