//
//  CustomCell.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 08.05.2023.
//

import UIKit

protocol CellModelRepresentable {
    var viewModel: CellIdentifible? { get set }
}

class CustomCell: UITableViewCell {
    var viewModel: CellIdentifible? {
        didSet {
            configure()
        }
    }
    
    let image = UIImageView()
    let labelCurrency = UILabel()
    let labelCharCode = UILabel()
    let labelValue = UILabel()
    let labelPrevoius = UILabel()
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        configure()
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    private func configure() {
        guard let viewModel = viewModel as? ListCellViewModel else { return }
        
        image.layer.cornerRadius = 5
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
        image.clipsToBounds = true
        image.image = UIImage(named: viewModel.image)
        
        labelCurrency.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        labelCurrency.textAlignment = .left
        labelCurrency.text = viewModel.labelCurrency
        
        labelCharCode.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        labelCharCode.text = viewModel.labelCharCode
        
        labelValue.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        labelValue.textAlignment = .right
        labelValue.text = string(viewModel.labelValue)
        
        labelPrevoius.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        labelPrevoius.textAlignment = .right
        labelPrevoius.text = checkCharacter(viewModel.labelValue, viewModel.labelPrevoius) +
        string(subtract(viewModel.labelValue, viewModel.labelPrevoius))
        labelPrevoius.textColor = checkPrevious(viewModel.labelValue, viewModel.labelPrevoius)
        
        addSubviews(subviews: image, labelCurrency, labelCharCode, labelValue, labelPrevoius)
        
        setupConstraints()
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
    
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            contentView.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 35),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            labelCurrency.widthAnchor.constraint(equalToConstant: 200),
            labelCurrency.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            labelCurrency.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            labelCharCode.topAnchor.constraint(equalTo: labelCurrency.bottomAnchor, constant: 6),
            labelCharCode.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            labelValue.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            labelValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            labelPrevoius.topAnchor.constraint(equalTo: labelValue.bottomAnchor, constant: 1),
            labelPrevoius.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}
