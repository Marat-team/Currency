//
//  OptionsViewController.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 15.05.2023.
//

import UIKit

protocol OptionsDisplayLogic: AnyObject {
    func displayList(viewModel: OptionsViewModel)
}

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
    var interactor: OptionsBusinessLogic?
    
    private var rows: [OptionsCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OptionsConfigurator.shared.configure(with: self)
        setupNavigationController()
        setupDesign()
        setupBarButton()
        setupConstraints()
        fetchList()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rows[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.identifier, for: indexPath) as! CustomCellOptions
        cell.accessoryType = rows[indexPath.row].checkmark ? .checkmark : .none
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if rows[indexPath.row].checkmark {
            let request = OptionsRequest(indexPath: indexPath.row, rows: rows)
            interactor?.checkmarkData(request: request)
//            delegate.deleteValute(valute: dataExchanges[indexPath.row])
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            let request = OptionsRequest(indexPath: indexPath.row, rows: rows)
            interactor?.checkmarkData(request: request)
//            delegate.saveValute(valute: dataExchanges[indexPath.row])
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    /*
    func deleteCheckmark(valute: Valute) {
        fetchList()
        let charCodes = dataExchanges.map { $0.charCode }
        guard let index = charCodes.firstIndex(of: valute.charCode) else { return }
        dataExchanges[index].checkmark.toggle()
        StorageManager.shared.saveList(valutes: dataExchanges)
        listOptions.reloadData()
    }
    */
    private func setupNavigationController() {
        title = "Options"
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearence = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
    }
    
    private func setupDesign() {
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
        interactor?.fetchData()
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

extension OptionsViewController: OptionsDisplayLogic {
    func displayList(viewModel: OptionsViewModel) {
        rows = viewModel.rows
    }
}
