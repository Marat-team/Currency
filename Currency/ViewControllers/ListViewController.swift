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
    
    private let dataExchanges = Valute.getList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupDesign()
        setupConstraints()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataExchanges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        cell.image.image = UIImage(named: dataExchanges[indexPath.row].flag)
        cell.labelCurrency.text = dataExchanges[indexPath.row].name
        cell.labelCharCode.text = dataExchanges[indexPath.row].charCode
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

