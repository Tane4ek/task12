//
//  HeaderCollectionReusableView.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    private enum Paddings {
        static let headerInset: CGFloat = 40
        static let horizontalInset : CGFloat = 47
    }
    
    var headerName = UILabel(frame: .zero)
    
    //  MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHeader() {
        setupUI()
        setupLayout()
    }

// MARK: - SetupUI
    func setupUI() {
        headerName.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        headerName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerName)
    }

// MARK: - Layout
    func setupLayout() {
        NSLayoutConstraint.activate([
            headerName.topAnchor.constraint(equalTo: topAnchor, constant: Paddings.headerInset),
            headerName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.horizontalInset),
        ])
    }
    
}
