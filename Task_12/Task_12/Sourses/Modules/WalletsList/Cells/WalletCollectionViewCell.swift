//
//  WalletCollectionViewCell.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 12.10.2021.
//

import UIKit

class WalletCollectionViewCell: UICollectionViewCell {
    
    private enum Paddings {
        static let horizontalInset: CGFloat = 17
        static let subviewHorizontalInset: CGFloat = 30
        enum Name {
            static let topInset: CGFloat = 20
        }
        enum Balance {
            static let topInset: CGFloat = 30
        }
        enum LabelDateOfLastChange {
            static let topInset: CGFloat = 40
        }
        enum DateOfLastChange {
            static let topInset: CGFloat = 10
            static let bottomInset: CGFloat = 20
        }
    }
    
    static let reusedId = "WalletCollectionViewCell"
    
    private var containerView = UIView(frame: .zero)
    private var name = UILabel(frame: .zero)
    private var chevron = UIImageView(frame: .zero)
    private var balance = UILabel(frame: .zero)
    private var labelDateOfLastChange = UILabel(frame: .zero)
    private var dateOfLastChange = UILabel(frame: .zero)
    
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
        setupName()
        setupChevron()
        setupBalance()
        setupLabelDateOfLastChange()
        setupDateOfLastChange()
        setupLayoutCell()
        setupGradient()
    }
    
    private func setupContainerView() {
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1.5
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
    }
    
    private func setupName() {
        name.text = "Name"
        name.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        name.textColor = .black
        name.minimumScaleFactor = 0.5
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
    }
    
    private func setupChevron() {
        chevron.image = UIImage(named: "chevron")
        chevron.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chevron)
    }
    
    private func setupBalance() {
        balance.text = "12 $"
        balance.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        balance.textColor = .black
        balance.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(balance)
    }
    
    private func setupLabelDateOfLastChange() {
        labelDateOfLastChange.text = "Last change"
        labelDateOfLastChange.font = UIFont(name: "Montserrat-SemiBold", size: 18)
        labelDateOfLastChange.textColor = .black
        labelDateOfLastChange.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelDateOfLastChange)
    }
    
    private func setupDateOfLastChange() {
        dateOfLastChange.text = "September 10, 2021"
        dateOfLastChange.font = UIFont(name: "Montserrat-Regular", size: 18)
        dateOfLastChange.textColor = .black
        dateOfLastChange.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateOfLastChange)
    }
   
// MARK: - Layout
    private func setupLayoutCell() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.horizontalInset),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.horizontalInset),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            name.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.Name.topInset),
            name.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.subviewHorizontalInset),
            
            chevron.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.Name.topInset),
            chevron.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Paddings.subviewHorizontalInset),
            
            balance.topAnchor.constraint(equalTo: name.bottomAnchor, constant: Paddings.Balance.topInset),
            balance.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.subviewHorizontalInset),
            
            labelDateOfLastChange.topAnchor.constraint(equalTo: balance.bottomAnchor, constant: Paddings.LabelDateOfLastChange.topInset),
            labelDateOfLastChange.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.subviewHorizontalInset),
            
            dateOfLastChange.topAnchor.constraint(equalTo: labelDateOfLastChange.bottomAnchor, constant: Paddings.DateOfLastChange.topInset),
            dateOfLastChange.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.subviewHorizontalInset),
            dateOfLastChange.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Paddings.DateOfLastChange.bottomInset)
        ])
    }
    private func setupGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        let rightColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.55)
        let leftColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.15)
        gradient.colors = [leftColor!.cgColor, rightColor!.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: 380, height: 220)
        containerView.layer.insertSublayer(gradient, at: 0)
        containerView.clipsToBounds = true
    }
  
// MARK: - Configure
    func configure (model: Wallet) {
        name.text = model.name
        balance.text = String(model.balance) + " " + model.codeCurrency
        containerView.backgroundColor = UIColor(named: model.colorName)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        dateOfLastChange.text = formatter.string(from: model.dateOfLastChange)
    }
}


