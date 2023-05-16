//
//  ListViewController.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 08.05.2023.
//

import UIKit

protocol AddNewValuteDelegate {
    func saveValute(valute: Valute)
    func deleteValute(valute: Valute)
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private lazy var listCurrency: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var dataExchanges: [Valute] = []
    private var dataFromAPI: [DataCurrency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupDesign()
        setupBarButton()
        setupConstraints()
        fetchData(from: URLS.currencyapi.rawValue)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataExchanges.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        cell.image.image = UIImage(named: dataExchanges[indexPath.section].flag)
        cell.labelCurrency.text = dataExchanges[indexPath.section].name
        cell.labelCharCode.text = dataExchanges[indexPath.section].charCode
        cell.labelValue.text = string(dataExchanges[indexPath.section].value)
        cell.labelPrevoius.text = checkCharacter(dataExchanges[indexPath.section].value,
                                                 dataExchanges[indexPath.section].previous) +
        string(subtract(dataExchanges[indexPath.section].value, dataExchanges[indexPath.section].previous))
        cell.labelPrevoius.textColor = checkPrevious(dataExchanges[indexPath.section].value,
                                                     dataExchanges[indexPath.section].previous)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteCheckmark(valute: dataExchanges[indexPath.section])
            StorageManager.shared.deleteValute(valute: indexPath.section)
            dataExchanges.remove(at: indexPath.section)
            let indexSet = IndexSet(arrayLiteral: indexPath.section)
            tableView.deleteSections(indexSet, with: .fade)
        }
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
        listCurrency.rowHeight = 80
        listCurrency.sectionHeaderHeight = 5
        setupSubviews(subviews: listCurrency)
    }
    
    private func fetchData(from url: String) {
        dataExchanges = StorageManager.shared.fetchValutes()
        NetworkManager.shared.fetchData(from: url) { date, exchange in
            DispatchQueue.main.async {
                self.dataFromAPI = exchange
                self.setupDataCell()
                self.listCurrency.reloadData()
            }
        }
    }
    
    private func setupBarButton() {
        let addBarButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addValute))
        
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    @objc private func addValute() {
        let optionsVC = OptionsViewController()
        let navigationVC = UINavigationController(rootViewController: optionsVC)
        optionsVC.delegate = self
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: true)
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
        let charCodeAPI = dataFromAPI.map { $0.CharCode }
        let iteraction = dataExchanges.count
        
        for indexFromList in 0..<iteraction {
            guard let indexCharCode = charCodeAPI.firstIndex(of: dataExchanges[indexFromList].charCode) else { return }
            guard let value = dataFromAPI[indexCharCode].Value else { return }
            guard let previous = dataFromAPI[indexCharCode].Previous else { return }
            
            dataExchanges[indexFromList].value = value
            dataExchanges[indexFromList].previous = previous
        }
    }
    
    private func deleteCheckmark(valute: Valute) {
        let optionsVC = OptionsViewController()
        optionsVC.deleteCheckmark(valute: valute)
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

extension ListViewController: AddNewValuteDelegate {
    func saveValute(valute: Valute) {
        dataExchanges.append(valute)
        StorageManager.shared.saveValute(valute: valute)
        setupDataCell()
        listCurrency.reloadData()
    }
    
    func deleteValute(valute: Valute) {
        let charCodes = dataExchanges.map { $0.charCode }
        guard let index = charCodes.firstIndex(of: valute.charCode) else { return }
        dataExchanges.remove(at: index)
        StorageManager.shared.deleteValute(valute: index)
        setupDataCell()
        listCurrency.reloadData()
    }
}
