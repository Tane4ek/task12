//
//  CurrenciesCollectionViewCell.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 05.11.2021.
//

import UIKit

class CurrenciesCollectionViewCell: UICollectionViewCell {
    
    static let reusedId = "CurrenciesCollectionViewCell"
    
    enum Paddings {
        static let horizontalInset: CGFloat = 17
        static let subViewHorizontalInset: CGFloat = 30
    }
    
    var containerView = UIView(frame: .zero)
    var name = UILabel(frame: .zero)
    var code = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUICell()
    }
    
    func setupUICell() {
        setupContainerView()
        setupName()
        setupCode()
        setupLayoutCell()
        setupGradient()
    }
    
    func setupContainerView() {
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1.5
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
    }
    
    func setupName() {
        name.text = "American Dollar"
        name.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        name.textColor = .black
        name.numberOfLines = 1
        name.adjustsFontSizeToFitWidth = true
        name.minimumScaleFactor = 0.5
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
    }
    
    func setupCode() {
        code.text = "USD"
        code.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        code.textColor = .black
        code.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(code)
    }
    
    func setupLayoutCell() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.horizontalInset),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.horizontalInset),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            name.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.subViewHorizontalInset),
            name.trailingAnchor.constraint(equalTo: code.leadingAnchor, constant: -Paddings.horizontalInset),
            
            code.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            code.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Paddings.subViewHorizontalInset),
            code.widthAnchor.constraint(equalToConstant: 65),
        ])
    }
    func setupGradient() {
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
    
    func configure (model: Currency) {
        name.text = model.name
        code.text = model.code
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
