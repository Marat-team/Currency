//
//  ListViewController.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 08.05.2023.
//

import UIKit

protocol ListDisplayLogic: AnyObject {
    func displayList(viewModel: ViewModel)
}

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
    
    var interactor: ListBusinessLogic?
    var router: (NSObjectProtocol & ListRoutingLogic & ListDataPassing)?
    
    private var rows: [ListCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListConfigurator.shared.configure(with: self)
        setupNavigationController()
        setupDesign()
        setupBarButton()
        setupConstraints()
        fetchData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rows[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = rows[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.identifier, for: indexPath) as! CustomCell
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let request = Request(index: indexPath.section, rows: rows)
            interactor?.deleteCheckmark(request: request)
//            deleteCheckmark(valute: dataExchanges[indexPath.section])
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
        listCurrency.sectionHeaderHeight = 5
        setupSubviews(subviews: listCurrency)
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
    /*
    private func deleteCheckmark(valute: Valute) {
        let optionsVC = OptionsViewController()
        optionsVC.deleteCheckmark(valute: valute)
    }
    */
    private func fetchData() {
        interactor?.fetchData()
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
//        dataExchanges.append(valute)
//        StorageManager.shared.saveValute(valute: valute)
//        setupDataCell()
//        listCurrency.reloadData()
    }
    
    func deleteValute(valute: Valute) {
//        let charCodes = dataExchanges.map { $0.charCode }
//        guard let index = charCodes.firstIndex(of: valute.charCode) else { return }
//        dataExchanges.remove(at: index)
//        StorageManager.shared.deleteValute(valute: index)
//        setupDataCell()
//        listCurrency.reloadData()
    }
}

extension ListViewController: ListDisplayLogic {
    func displayList(viewModel: ViewModel) {
        rows = viewModel.rows
        DispatchQueue.main.async {
            self.listCurrency.reloadData()
        }
    }
}
