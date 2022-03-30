//
//  TextViewCollectionViewCell.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 23.10.2021.
//

import UIKit

class TextViewCollectionViewCell: UICollectionViewCell {
    
    private enum Paddings {
        static let horizontalInset: CGFloat = 17
        
        enum TextView {
            static let horizontalInset: CGFloat = 20
            static let topInset: CGFloat = 62
            static let bottomInset: CGFloat = 20
        }
        
        enum ButtonSave {
            static let inset: CGFloat = 20
            static let width: CGFloat = 70
        }
    }
    
    static let reusedId = "TextViewCollectionViewCell"
    
    private var containerView = UIView(frame: .zero)
    var textView = UITextView(frame: .zero)
    var delegate: TextInputCollectionViewCellDelegate?
    var textViewIndex: Int?
    var buttonSave = UIButton(frame: .zero)
    
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
        setuptextView()
        setupButtonSave()
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
    
    private func setuptextView() {
        textView.text = "Start here..."
        textView.textColor = UIColor.black
        textView.textAlignment = .left
        textView.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 1.5
        textView.layer.borderColor = UIColor(named: "Rick Black FOGRA 29")?.cgColor
        textView.backgroundColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.55)
        textView.textContainerInset = UIEdgeInsets(top: 26, left: 20, bottom: 0, right: 0)
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textView)
    }
    
    private func setupButtonSave() {
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.layer.cornerRadius = 10
        buttonSave.layer.borderWidth = 1.5
        buttonSave.layer.borderColor = UIColor(named: "Green Blue Crayola")?.cgColor
        buttonSave.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        buttonSave.setTitleColor(UIColor(named: "Green Blue Crayola"), for: .normal)
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonSave)
    }
    
// MARK: - Layout
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.horizontalInset),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.horizontalInset),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            buttonSave.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonSave.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Paddings.TextView.bottomInset),
            buttonSave.widthAnchor.constraint(equalToConstant: Paddings.ButtonSave.width),
            
            textView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.TextView.topInset),
            textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.TextView.horizontalInset),
            textView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Paddings.TextView.horizontalInset),
            textView.bottomAnchor.constraint(equalTo: buttonSave.topAnchor, constant: -Paddings.TextView.bottomInset),
            
        ])
    }
  
// MARK: - Configure
    func configure (model: Transaction) {
        textView.text = model.note
        if model.note == "" {
            textView.textColor = UIColor.lightGray
            textView.text = "Start here..."
        }
    }
}

// MARK: - UITextViewDelegate
extension TextViewCollectionViewCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text.isEmpty {
            textView.text = "Start here..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        if let delegate = delegate {
            delegate.getData(data: updatedText, index: textViewIndex ?? 0)
        }
        if text == "\n" {
            textView.resignFirstResponder()
            if let delegate = delegate {
                delegate.dataTransfer(index: textViewIndex ?? 0)
            }
            
            return false
        }
        return updatedText.count <= 250
    }
}
