//
//  CustomCell.swift
//  Currency
//
//  Created by Marat Shagiakhmetov on 08.05.2023.
//

import UIKit

class CustomCell: UITableViewCell {
    let image = UIImageView()
    let labelCurrency = UILabel()
    let labelCharCode = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        image.layer.cornerRadius = 5
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
        image.clipsToBounds = true
        
        labelCurrency.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        labelCurrency.textAlignment = .left
        
        labelCharCode.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        labelCharCode.textAlignment = .right
        
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
            labelCurrency.widthAnchor.constraint(equalToConstant: 200),
            labelCurrency.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            labelCurrency.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            labelCharCode.topAnchor.constraint(equalTo: labelCurrency.bottomAnchor, constant: 6),
            labelCharCode.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15)
        ])
    }
}
