//
//  CurrentCurrencyCollectionViewCell.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 18.10.2021.
//

import UIKit

class CurrentCurrencyCollectionViewCell: UICollectionViewCell {
    
    private enum Paddings {
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
    
    static let reusedId = "CurrentCurrencyCollectionViewCell"
    
    private var containerView = UIView(frame: .zero)
    private var labelContinerView = UIView(frame: .zero)
    private var labelCurrency = UILabel(frame: .zero)
    private var chevron = UIImageView(frame: .zero)
    
    var delegate: TextFieldButtonCollectionViewCellDelegate?
    var index: Int?
    
// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUICell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - setupUI
    private func setupUICell() {
        setupContainerView()
        setupLabelContinerView()
        setupLabelCurrency()
        setupChevron()
        setupLayout()
    }
    
    private func setupContainerView() {
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1.5
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.backgroundColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.55)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
    }
    
    private func setupLabelContinerView() {
        labelContinerView.layer.cornerRadius = 20
        labelContinerView.layer.borderWidth = 1.5
        labelContinerView.layer.borderColor = UIColor.white.cgColor
        labelContinerView.backgroundColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.55)
        labelContinerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelContinerView)
    }
    
    private func setupLabelCurrency() {
        labelCurrency.text = "USD $"
        labelCurrency.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        labelCurrency.textColor = .black
        labelCurrency.translatesAutoresizingMaskIntoConstraints = false
        labelCurrency.alpha = 1
        contentView.addSubview(labelCurrency)
    }
    
    private func setupChevron() {
        chevron.image = UIImage(named: "chevron")
        chevron.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chevron)
    }
    
 // MARK: - Layout
    private func setupLayout() {
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
 
// MARK: - Configure
    func configure (model: Wallet) {
        labelCurrency.text = model.codeCurrency
    }
}
