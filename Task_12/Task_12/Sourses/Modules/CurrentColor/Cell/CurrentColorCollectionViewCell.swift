//
//  CurrentColorCollectionViewCell.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.11.2021.
//

import UIKit

class CurrentColorCollectionViewCell: UICollectionViewCell {
    
    static let reusedId = "CurrentColorCollectionViewCell"
    
    enum Paddings {
        
//        enum ContinerView {
//            static let horizontalInset: CGFloat = 20
//            static let bottomInset: CGFloat = 30
//            static let topInset: CGFloat = 72
//        }
        
        enum ColorView {
            static let horizontalInset: CGFloat = 20
            static let verticallInset: CGFloat = 30
        }
    }
    
    var containerView = UIView(frame: .zero)
    var colorView = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUICell()
    }
    
    func setupUICell() {
        setupContainerView()
        setupColorView()
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
    
    func setupColorView() {
        colorView.backgroundColor = UIColor.lightGray
        colorView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(colorView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            colorView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.ColorView.verticallInset),
            colorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.ColorView.horizontalInset),
            colorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Paddings.ColorView.horizontalInset),
            colorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Paddings.ColorView.verticallInset),
        ])
    }
    
    func configure (model: Color) {
        colorView.backgroundColor = UIColor(named: model.name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
