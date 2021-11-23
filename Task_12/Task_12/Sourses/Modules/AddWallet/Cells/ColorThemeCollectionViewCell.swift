//
//  ColorThemeCollectionViewCell.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import UIKit

class ColorThemeCollectionViewCell: UICollectionViewCell {
    
    static let reusedId = "ColorThemeCollectionViewCell"
    
    enum Paddings {
        static let horizontalInset: CGFloat = 17
        
        enum ImageContinerView {
            static let horizontalInset: CGFloat = 20
            static let bottomInset: CGFloat = 30
            static let topInset: CGFloat = 72
        }
        
        enum ColorView {
            static let leftInset: CGFloat = 25
            static let rightInset: CGFloat = 32
            static let verticalInset: CGFloat = 30
        }
        
        enum Chevron {
            static let rightInset: CGFloat = 20
        }
    }
    
    var containerView = UIView(frame: .zero)
    var imageContinerView = UIView(frame: .zero)
    var colorView = UIImageView(frame: .zero)
    var chevron = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUICell()
    }
    
    func setupUICell() {
        setupContainerView()
        setupimageContinerView()
        setupColorView()
        setupChevron()
        setupLayout()
    }
    
    func setupContainerView() {
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1.5
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.backgroundColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.55)
//        containerView.alpha = 0.55
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
    }
    
    func setupimageContinerView() {
        imageContinerView.layer.cornerRadius = 20
        imageContinerView.layer.borderWidth = 1.5
        imageContinerView.layer.borderColor = UIColor.white.cgColor
        imageContinerView.backgroundColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.55)
        imageContinerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageContinerView)
    }
    
    func setupColorView() {
        colorView.backgroundColor = UIColor.lightGray
        colorView.translatesAutoresizingMaskIntoConstraints = false
        imageContinerView.addSubview(colorView)
    }
    
    func setupChevron() {
        chevron.image = UIImage(named: "chevron")
        chevron.translatesAutoresizingMaskIntoConstraints = false
        imageContinerView.addSubview(chevron)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.horizontalInset),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.horizontalInset),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageContinerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.ImageContinerView.topInset),
            imageContinerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.ImageContinerView.horizontalInset),
            imageContinerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Paddings.ImageContinerView.horizontalInset),
            imageContinerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Paddings.ImageContinerView.bottomInset),
            
            colorView.topAnchor.constraint(equalTo: imageContinerView.topAnchor, constant: Paddings.ColorView.verticalInset),
            colorView.leadingAnchor.constraint(equalTo: imageContinerView.leadingAnchor, constant: Paddings.ColorView.leftInset),
            colorView.trailingAnchor.constraint(equalTo: imageContinerView.trailingAnchor, constant: -Paddings.ColorView.rightInset),
            colorView.bottomAnchor.constraint(equalTo: imageContinerView.bottomAnchor, constant: -Paddings.ColorView.verticalInset),
            
            chevron.centerYAnchor.constraint(equalTo: imageContinerView.centerYAnchor),
            chevron.trailingAnchor.constraint(equalTo: imageContinerView.trailingAnchor, constant: -Paddings.Chevron.rightInset)
        ])
    }
    
    func configure(model: Wallet) {
        colorView.backgroundColor = UIColor(named: model.colorName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
