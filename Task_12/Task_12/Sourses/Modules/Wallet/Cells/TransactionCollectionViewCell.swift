//
//  TransactionCollectionViewCell.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 22.10.2021.
//

import UIKit

class TransactionCollectionViewCell: UICollectionViewCell {
    
    private enum Paddings {
        
        static let horizontalInset: CGFloat = 27
        
        enum MainView {
            static let horizontalInset: CGFloat = 20
            static let verticalInset: CGFloat = 20
            static let size: CGFloat = 50
        }
        enum Name {
            static let horizontalInset: CGFloat = 20
        }
        enum Balance {
            static let horizontalInset: CGFloat = 32
        }
        enum DateOfLastChange {
            static let topInset: CGFloat = 5
            static let horizontalInset: CGFloat = 20
            static let bottomInset: CGFloat = 20
        }
        enum Chevron {
            static let rightInset: CGFloat = 30
            static let leftInset: CGFloat = 5
        }
    }
    
    static let reusedId = "TransactionCollectionViewCell"
    
    private var containerView = UIView(frame: .zero)
    private var mainView = UIView(frame: .zero)
    private var name = UILabel(frame: .zero)
    private var balance = UILabel(frame: .zero)
    private var dateOfLastChange = UILabel(frame: .zero)
    private var chevron = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUICell()
    }
    
    private func setupUICell() {
        setupContainerView()
        setupMainView()
        setupName()
        setupBalance()
        setupDateOfLastChange()
        setupChevron()
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
    
    private func setupMainView() {
        mainView.layer.cornerRadius = 10
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor.black.cgColor
        mainView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(mainView)
    }
    
    private func setupName() {
        name.font = UIFont(name: "Montserrat-SemiBold", size: 18)
        name.textColor = .black
        name.minimumScaleFactor = 0.5
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
    }
    
    private func setupBalance() {
        balance.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        balance.textColor = UIColor(named: "Amaranth Red")
        balance.minimumScaleFactor = 0.5
        balance.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(balance)
    }
    private func setupDateOfLastChange() {
        dateOfLastChange.font = UIFont(name: "Montserrat-Regular", size: 14)
        dateOfLastChange.textColor = .black
        dateOfLastChange.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateOfLastChange)
    }
    
    private func setupChevron() {
        chevron.image = UIImage(named: "chevron")
        chevron.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chevron)
    }
    
    private func setupLayoutCell() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
//                                                   , constant: Paddings.horizontalInset),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
//                                                    , constant: -Paddings.horizontalInset),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            mainView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            mainView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.MainView.horizontalInset),
            mainView.heightAnchor.constraint(equalToConstant: Paddings.MainView.size),
            mainView.widthAnchor.constraint(equalToConstant: Paddings.MainView.size),
            
            name.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.Name.horizontalInset),
            name.leadingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: Paddings.Name.horizontalInset),
            
            dateOfLastChange.topAnchor.constraint(equalTo: name.bottomAnchor, constant: Paddings.DateOfLastChange.topInset),
            dateOfLastChange.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            dateOfLastChange.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            dateOfLastChange.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Paddings.DateOfLastChange.bottomInset),
            
            balance.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            balance.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: Paddings.Balance.horizontalInset),
            
            chevron.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            chevron.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Paddings.Chevron.rightInset),
            chevron.leadingAnchor.constraint(equalTo: balance.trailingAnchor, constant: Paddings.Chevron.leftInset)
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
    
    func configure (model: Transaction) {
        name.text = model.title
        balance.text = String(model.change) + " " + model.codeCurrency
        if model.change < 0 {
            balance.textColor = UIColor(named: "Amaranth Red")
        } else {
            balance.textColor = UIColor(named: "Celadon")
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        dateOfLastChange.text = formatter.string(from: model.date)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
