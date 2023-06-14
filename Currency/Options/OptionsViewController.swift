//
//  OptionsViewController.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 15.05.2023.
//

import UIKit

class OptionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private lazy var listOptions: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CustomCellOptions.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var delegate: AddNewValuteDelegate!
    
    private var dataExchanges: [Valute] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupDesign()
        setupBarButton()
        setupConstraints()
        fetchList()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataExchanges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellOptions
        
        cell.image.image = UIImage(named: dataExchanges[indexPath.row].flag)
        cell.labelCurrency.text = dataExchanges[indexPath.row].name
        cell.labelCharCode.text = dataExchanges[indexPath.row].charCode
        cell.accessoryType = dataExchanges[indexPath.row].checkmark ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if dataExchanges[indexPath.row].checkmark {
            dataExchanges[indexPath.row].checkmark.toggle()
            StorageManager.shared.saveList(valutes: dataExchanges)
            delegate.deleteValute(valute: dataExchanges[indexPath.row])
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            dataExchanges[indexPath.row].checkmark.toggle()
            StorageManager.shared.saveList(valutes: dataExchanges)
            delegate.saveValute(valute: dataExchanges[indexPath.row])
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func deleteCheckmark(valute: Valute) {
        fetchList()
        let charCodes = dataExchanges.map { $0.charCode }
        guard let index = charCodes.firstIndex(of: valute.charCode) else { return }
        dataExchanges[index].checkmark.toggle()
        StorageManager.shared.saveList(valutes: dataExchanges)
        listOptions.reloadData()
    }
    
    private func setupNavigationController() {
        title = "Options"
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearence = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
    }
    
    private func setupDesign() {
        listOptions.rowHeight = 50
        setupSubviews(subviews: listOptions)
    }
    
    private func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupBarButton() {
        let cancelBarButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(done))
        
        navigationItem.rightBarButtonItem = cancelBarButton
    }
    
    @objc private func done() {
        dismiss(animated: true)
    }
    
    private func fetchList() {
        dataExchanges = StorageManager.shared.fetchList()
    }
}

extension OptionsViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            listOptions.topAnchor.constraint(equalTo: view.topAnchor),
            listOptions.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listOptions.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listOptions.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
