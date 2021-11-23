//
//  TextFieldCollectionViewCell.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 17.10.2021.
//

import UIKit

class TextFieldButtonCollectionViewCell: UICollectionViewCell {
    
    static let reusedId = "TextFieldButtonCollectionViewCell"
    
    enum Paddings {
        static let horizontalInset: CGFloat = 17
        
        enum textField {
            static let horizontalInset: CGFloat = 20
            static let topInset: CGFloat = 62
        }
        
        enum buttonSave {
            static let inset: CGFloat = 20
            static let width: CGFloat = 70
        }
    }
    
    var containerView = UIView(frame: .zero)
    var textField = UITextField(frame: .zero)
    var buttonSave = UIButton(frame: .zero)
    var delegate: TextFieldButtonCollectionViewCellDelegate?
    var textFieldIndex: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUICell()
    }
    
    func setupUICell() {
        
        setupContainerView()
        setuptextField()
        setupButtonSave()
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
    
    func setuptextField() {
        textField.placeholder = "Start here..."
        textField.textAlignment = .left
        textField.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor(named: "Rick Black FOGRA 29")?.cgColor
        textField.backgroundColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.55)
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textField)
    }
    
    func setupButtonSave() {
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        buttonSave.setTitleColor(UIColor(named: "Green Blue Crayola"), for: .normal)
        buttonSave.layer.cornerRadius = 10
        buttonSave.layer.borderColor = UIColor(named: "Green Blue Crayola")?.cgColor
        buttonSave.layer.borderWidth = 1.5
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonSave)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.horizontalInset),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.horizontalInset),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.textField.topInset),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.textField.horizontalInset),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Paddings.textField.horizontalInset),
            
            buttonSave.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Paddings.buttonSave.inset),
            buttonSave.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonSave.widthAnchor.constraint(equalToConstant: Paddings.buttonSave.width),
            buttonSave.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Paddings.buttonSave.inset),
            
        ])
    }
    
    func configure (model: Wallet) {
        textField.text = model.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextFieldButtonCollectionViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }

            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if let delegate = delegate {
                delegate.getData(data: updatedText)
        }
        
            return updatedText.count <= 20
    }
}
