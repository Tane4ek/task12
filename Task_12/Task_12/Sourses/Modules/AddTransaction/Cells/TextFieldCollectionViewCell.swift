//
//  TextFieldCollectionViewCell.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 23.10.2021.
//

import UIKit

class TextFieldCollectionViewCell: UICollectionViewCell {
    
    private enum Paddings {
        static let horizontalInset: CGFloat = 17
        
        enum textField {
            static let horizontalInset: CGFloat = 20
            static let topInset: CGFloat = 62
            static let bottomInset: CGFloat = 20
        }
        
        enum buttonSave {
            static let inset: CGFloat = 20
            static let width: CGFloat = 70
        }
    }
    
    static let reusedId = "TextFieldCollectionViewCell"
    
    private var containerView = UIView(frame: .zero)
    var textField = UITextField(frame: .zero)
    var delegate: TextInputCollectionViewCellDelegate?
    var textFieldIndex: Int?

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
        setuptextField()
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
    
    private func setuptextField() {
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

// MARK: - Layout
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.horizontalInset),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.horizontalInset),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.textField.topInset),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.textField.horizontalInset),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Paddings.textField.horizontalInset),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Paddings.textField.bottomInset),
            
        ])
    }

// MARK: - Configure
    func configure (model: Transaction) {
        textField.text = model.title
    }
    
    
}

// MARK: - UITextFieldDelegate
extension TextFieldCollectionViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if let delegate = delegate {
            delegate.dataTransfer(index: textFieldIndex ?? 0)
        }
        
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if let delegate = delegate {
            delegate.getData(data: updatedText, index: textFieldIndex ?? 0)
        }
        
        return updatedText.count <= 20
    }
}
