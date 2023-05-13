//
//  ListViewController.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 08.05.2023.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private lazy var listCurrency: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemCyan
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var dataExchanges = Valute.getList()
    private var dataFromAPI: [DataCurrency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupDesign()
        setupConstraints()
        fetchData(from: URLS.currencyapi.rawValue)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataExchanges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        cell.image.image = UIImage(named: dataExchanges[indexPath.row].flag)
        cell.labelCurrency.text = dataExchanges[indexPath.row].name
        cell.labelCharCode.text = dataExchanges[indexPath.row].charCode
        cell.labelValue.text = string(dataExchanges[indexPath.row].value)
        cell.labelPrevoius.text = checkCharacter(dataExchanges[indexPath.row].value,
                                                 dataExchanges[indexPath.row].previous) +
        string(subtract(dataExchanges[indexPath.row].value, dataExchanges[indexPath.row].previous))
        cell.labelPrevoius.textColor = checkPrevious(dataExchanges[indexPath.row].value,
                                                     dataExchanges[indexPath.row].previous)
        cell.selectionStyle = .none
        
        return cell
    }
    
    private func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupNavigationController() {
        title = "Currency"
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearence = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
    }
    
    private func setupDesign() {
        setupSubviews(subviews: listCurrency)
        listCurrency.rowHeight = 70
    }
    
    private func fetchData(from url: String) {
        NetworkManager.shared.fetchData(from: url) { date, exchange in
            DispatchQueue.main.async {
                self.dataFromAPI = exchange
                self.setupDataCell()
                self.listCurrency.reloadData()
            }
        }
    }
    
    private func string(_ data: Double) -> String {
        String(format: "%.2f", data)
    }
    
    private func checkCharacter(_ value: Double,_ previous: Double) -> String {
        value - previous > 0 ? "+ " : "- "
    }
    
    private func checkPrevious(_ value: Double,_ previous: Double) -> UIColor {
        value - previous > 0 ? .systemGreen : .systemRed
    }
    
    private func subtract(_ value: Double,_ previous: Double) -> Double {
        abs(value - previous)
    }
    
    private func setupDataCell() {
        let charCodeAPI = dataFromAPI.map{ $0.CharCode }
        let iteraction = dataExchanges.count
        
        for indexFromList in 0..<iteraction {
            guard let indexCharCode = charCodeAPI.firstIndex(of: dataExchanges[indexFromList].charCode) else { return }
            guard let value = dataFromAPI[indexCharCode].Value else { return }
            guard let previous = dataFromAPI[indexCharCode].Previous else { return }
            
            dataExchanges[indexFromList].value = value
            dataExchanges[indexFromList].previous = previous
        }
    }
}

extension ListViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            listCurrency.topAnchor.constraint(equalTo: view.topAnchor),
            listCurrency.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listCurrency.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listCurrency.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

