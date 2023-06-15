//
//  CustomCellOptions.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 15.05.2023.
//

import UIKit

protocol OptionsCellRepresebtable {
    var viewModel: OptionsCellIdentifible? { get set }
}

class CustomCellOptions: UITableViewCell, OptionsCellRepresebtable {
    var viewModel: OptionsCellIdentifible? {
        didSet {
            configure()
        }
    }
    
    let image = UIImageView()
    let labelCurrency = UILabel()
    let labelCharCode = UILabel()
    
    private func configure() {
        guard let viewModel = viewModel as? OptionsCellViewModel else { return }
        
        image.layer.cornerRadius = 5
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
        image.clipsToBounds = true
        image.image = UIImage(named: viewModel.image)
        
        labelCurrency.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        labelCurrency.text = viewModel.labelCurrency
        
        labelCharCode.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        labelCharCode.text = viewModel.labelCharCode
        
        addSubviews(subviews: image, labelCurrency, labelCharCode)
        
        setupConstraints()
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
            labelCurrency.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            labelCurrency.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            labelCharCode.topAnchor.constraint(equalTo: labelCurrency.bottomAnchor),
            labelCharCode.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15)
        ])
    }
}
