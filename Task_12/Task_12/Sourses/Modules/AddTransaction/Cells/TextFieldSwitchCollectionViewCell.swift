//
//  TextFieldSwitchCollectionViewCell.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 23.10.2021.
//

import UIKit

class TextFieldSwitchCollectionViewCell: UICollectionViewCell {
    
    static let reusedId = "TextFieldSwitchCollectionViewCell"
    
    private enum Paddings {
        static let horizontalInset: CGFloat = 17
        
        enum TextField {
            static let horizontalInset: CGFloat = 20
            static let topInset: CGFloat = 86
            static let bottomInset: CGFloat = 20
        }
        enum SegmentControl {
            static let horizontalInset: CGFloat = 20
            static let topInset: CGFloat = 15
        }
    }
    
    private var containerView = UIView(frame: .zero)
    var textField = UITextField(frame: .zero)
    private var segmentedControl = UISegmentedControl()
    var delegate: TextInputCollectionViewCellDelegate?
    var textFieldIndex: Int?
    
    private var textFieldSign: String = " "
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUICell()
    }
    
    private func setupUICell() {
        
        setupContainerView()
        setuptextField()
        setupSegmentedControl()
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
        textField.placeholder = "Type here..."
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
    
    private func setupSegmentedControl() {
        segmentedControl = UISegmentedControl(items: ["Outcome", "Income"])
        segmentedControl.backgroundColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.55)
        segmentedControl.layer.cornerRadius = 9
        segmentedControl.layer.borderColor = UIColor.white.cgColor
        segmentedControl.layer.borderWidth = 1
        segmentedControl.setWidth(90, forSegmentAt: 0)
        segmentedControl.setWidth(90, forSegmentAt: 1)
        for (index, view) in segmentedControl.subviews.enumerated() {
            if index == 0 {
                view.subviews.forEach { label in
                    (label as! UILabel).textColor = UIColor(named: "Amaranth Red")
                }
            } else {
                view.subviews.forEach { label in
                    (label as! UILabel).textColor = UIColor(named: "Celadon")
                }
            }
        }
        segmentedControl.addTarget(self, action: #selector(selectedValue), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(segmentedControl)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.horizontalInset),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.horizontalInset),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.TextField.topInset),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.TextField.horizontalInset),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Paddings.TextField.horizontalInset),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Paddings.TextField.bottomInset),
            
            segmentedControl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.SegmentControl.topInset),
            segmentedControl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Paddings.SegmentControl.horizontalInset),
        ])
    }
    
    func configure (model: Transaction) {
        textField.text = String(model.change)
        if model.change == 0.0 {
            textField.text = ""
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectedValue(target: UISegmentedControl) {
        
        if target == self.segmentedControl {
            if target.selectedSegmentIndex == 0 {
                if !(textField.text!.hasPrefix("-")) {
                    textField.text?.insert("-", at: textField.text?.startIndex ?? textFieldSign.startIndex)
                }
                if let delegate = delegate {
                    delegate.getData(data: textField.text!, index: textFieldIndex ?? 0)
                }
            } else {
                if textField.text!.hasPrefix("-") {
                    textField.text?.remove(at: textField.text?.startIndex ?? textFieldSign.startIndex)
                    textFieldSign = ""
                    print("incoming tapped", textFieldSign)
                    if let delegate = delegate {
                        delegate.getData(data: textField.text!, index: textFieldIndex ?? 0)
                    }
                }
            }
        }
    }
}

extension TextFieldSwitchCollectionViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let delegate = delegate {
            delegate.dataTransfer(index: textFieldIndex ?? 0)
        }
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowCharacters = CharacterSet(charactersIn: "-0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        let shouldReplace = allowCharacters.isSuperset(of: characterSet)
        if !shouldReplace {
            return false
        }
        
        guard let currentText = textField.text else {return false}
        print("текст со знаком", currentText)
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        if updatedText.count > 9 {
            return false
        }
        
        var minusCount = 0
        var firstMinus = false
        var i = 0
        for ch in updatedText {
            if ch == "-" {
                minusCount += 1
                if i == 0 {
                    firstMinus = true
                }
            }
            i += 1
        }
        
        if minusCount > 1 {
            return false
        }
        
        if minusCount == 1 && !firstMinus {
            return false
        }
        
        if let delegate = delegate {
            delegate.getData(data: updatedText, index: textFieldIndex ?? 0)
        }
        return true
    }
}
