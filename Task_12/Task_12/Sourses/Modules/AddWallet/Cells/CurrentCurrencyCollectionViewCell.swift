//
//  CurrentCurrencyCollectionViewCell.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 18.10.2021.
//

import UIKit

class CurrentCurrencyCollectionViewCell: UICollectionViewCell {
    
    static let reusedId = "CurrentCurrencyCollectionViewCell"
    
    enum Paddings {
        static let horizontalInset: CGFloat = 17
        
        enum labelContinerView {
            static let horizontalInset: CGFloat = 20
            static let bottomInset: CGFloat = 20
            static let topInset: CGFloat = 62
        }
        
        enum labelCurrency {
            static let horizontalInset: CGFloat = 20
        }
    }
    
    var containerView = UIView(frame: .zero)
    var labelContinerView = UIView(frame: .zero)
    var labelCurrency = UILabel(frame: .zero)
    var chevron = UIImageView(frame: .zero)
    
    var delegate: TextFieldButtonCollectionViewCellDelegate?
    var index: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUICell()
    }
    
    func setupUICell() {
        setupContainerView()
        setupLabelContinerView()
        setupLabelCurrency()
        setupChevron()
        setupLayout()
    }
    
    func setupContainerView() {
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1.5
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.backgroundColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.55)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
    }
    
    func setupLabelContinerView() {
        labelContinerView.layer.cornerRadius = 20
        labelContinerView.layer.borderWidth = 1.5
        labelContinerView.layer.borderColor = UIColor.white.cgColor
        labelContinerView.backgroundColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.55)
        labelContinerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelContinerView)
    }
    
    func setupLabelCurrency() {
        labelCurrency.text = "USD $"
        labelCurrency.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        labelCurrency.textColor = .black
        labelCurrency.translatesAutoresizingMaskIntoConstraints = false
        labelCurrency.alpha = 1
        contentView.addSubview(labelCurrency)
    }
    
    func setupChevron() {
        chevron.image = UIImage(named: "chevron")
        chevron.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chevron)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.horizontalInset),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.horizontalInset),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            labelContinerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.labelContinerView.topInset),
            labelContinerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.labelContinerView.horizontalInset),
            labelContinerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Paddings.labelContinerView.horizontalInset),
            labelContinerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Paddings.labelContinerView.bottomInset),
            
            labelCurrency.leadingAnchor.constraint(equalTo: labelContinerView.leadingAnchor, constant: Paddings.labelCurrency.horizontalInset),
            labelCurrency.centerYAnchor.constraint(equalTo: labelContinerView.centerYAnchor),
            
            chevron.trailingAnchor.constraint(equalTo: labelContinerView.trailingAnchor, constant: -Paddings.labelCurrency.horizontalInset),
            chevron.centerYAnchor.constraint(equalTo: labelContinerView.centerYAnchor),
        ])
    }
    
    func configure (model: Wallet) {
        labelCurrency.text = model.codeCurrency
        
        print("валюта из кошелька", labelCurrency.text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
