//
//  AddTransactionViewController.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 23.10.2021.
//

import UIKit

class AddTransactionViewController: UIViewController {
    
    private let presenter: AddTransactionViewOutput
    
    init(presenter: AddTransactionViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewTransaction = UIView(frame: .zero)
    var labelAddTransaction = UILabel(frame: .zero)
    var buttonBack = UIButton(frame: .zero)
    
    var addTransactionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    let collectionViewHeaderReuseIdentifier = "HeaderCollectionReusableView"
    
    enum Paddings {
        static let subviewHorizontalInset: CGFloat = 30
        
        enum ViewTransaction {
            static let topInset: CGFloat = 60
            static let horizontalInset: CGFloat = 17
            static let height: CGFloat = 75
        }
        enum LabelAddTransaction {
            static let horizontalInset: CGFloat = 20
        }
        enum AddWalletCollectionView {
            static let topInset: CGFloat = 20
        }
    }
    
    enum AddTransactionSection: Int {
        case title = 0
        case change
        case note
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    
    func setupUI() {
        view.backgroundColor = .gray
        setupViewTransaction()
        setupLabelTransaction()
        setupButtonBack()
        setupAddTransactionCollectionView()
        registerForKeyboardNotification()
        setupLayout()
    }
    
    func setupViewTransaction() {
        viewTransaction.layer.cornerRadius = 20
        viewTransaction.layer.borderWidth = 1.5
        viewTransaction.layer.borderColor = UIColor.white.cgColor
        viewTransaction.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewTransaction)
    }
    
    func setupLabelTransaction() {
        //        labelAddTransaction.text = "Add transaction"
        labelAddTransaction.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        labelAddTransaction.textColor = .black
        labelAddTransaction.translatesAutoresizingMaskIntoConstraints = false
        viewTransaction.addSubview(labelAddTransaction)
    }
    
    func setupButtonBack() {
        buttonBack.setImage(UIImage(named: "back"), for: .normal)
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        viewTransaction.addSubview(buttonBack)
    }
    
    func setupAddTransactionCollectionView() {
        addTransactionCollectionView.register(TextFieldCollectionViewCell.self, forCellWithReuseIdentifier: TextFieldCollectionViewCell.reusedId)
        addTransactionCollectionView.register(TextFieldSwitchCollectionViewCell.self, forCellWithReuseIdentifier: TextFieldSwitchCollectionViewCell.reusedId)
        addTransactionCollectionView.register(TextViewCollectionViewCell.self, forCellWithReuseIdentifier: TextViewCollectionViewCell.reusedId)
        addTransactionCollectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: collectionViewHeaderReuseIdentifier)
        layout.scrollDirection = .vertical
        addTransactionCollectionView.setCollectionViewLayout(layout, animated: true)
        addTransactionCollectionView.delegate = self
        addTransactionCollectionView.dataSource = self
        addTransactionCollectionView.backgroundColor = UIColor.clear
        layout.minimumLineSpacing = 29
        addTransactionCollectionView.keyboardDismissMode = .interactive
        addTransactionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addTransactionCollectionView)
    }
    
    
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            viewTransaction.topAnchor.constraint(equalTo: view.topAnchor, constant: Paddings.ViewTransaction.topInset),
            viewTransaction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Paddings.ViewTransaction.horizontalInset),
            viewTransaction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Paddings.ViewTransaction.horizontalInset),
            viewTransaction.heightAnchor.constraint(equalToConstant: Paddings.ViewTransaction.height),
            
            buttonBack.centerYAnchor.constraint(equalTo: viewTransaction.centerYAnchor),
            buttonBack.leadingAnchor.constraint(equalTo: viewTransaction.leadingAnchor, constant: Paddings.subviewHorizontalInset),
            
            labelAddTransaction.centerYAnchor.constraint(equalTo: viewTransaction.centerYAnchor),
            labelAddTransaction.leadingAnchor.constraint(equalTo: buttonBack.trailingAnchor, constant: Paddings.LabelAddTransaction.horizontalInset),
            
            addTransactionCollectionView.topAnchor.constraint(equalTo: viewTransaction.bottomAnchor, constant: Paddings.AddWalletCollectionView.topInset),
            addTransactionCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            addTransactionCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            addTransactionCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        presenter.buttonBackTapped(wallet: presenter.currentUserWallet())
    }
    
    func setupGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        let rightColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.55)
        let leftColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.15)
        gradient.colors = [leftColor!.cgColor, rightColor!.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: viewTransaction.frame.size.width, height: viewTransaction.frame.size.height)
        viewTransaction.layer.insertSublayer(gradient, at: 0)
        viewTransaction.clipsToBounds = true
    }
    
    func registerForKeyboardNotification() {
        self.registerForKeyboardWillShowNotification(self.addTransactionCollectionView)
        self.registerForKeyboardWillHideNotification(self.addTransactionCollectionView)
    }
}

extension AddTransactionViewController: AddTransactionViewInput {
    func reloadUI() {
        addTransactionCollectionView.reloadData()
        labelAddTransaction.text = presenter.currentLabel()
        view.backgroundColor = UIColor(named: presenter.currentUserWallet().colorName)
    }
}

// MARK: - UICollectionViewDelegate
extension AddTransactionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - UICollectionViewDataSource
extension AddTransactionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return AddTransactionSection.note.rawValue + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == AddTransactionSection.title.rawValue {
            let cell = addTransactionCollectionView.dequeueReusableCell(withReuseIdentifier: TextFieldCollectionViewCell.reusedId, for: indexPath) as! TextFieldCollectionViewCell
            cell.delegate = self
            cell.textFieldIndex = indexPath.section
            cell.configure(model: presenter.currentModel())
            return cell
        } else if indexPath.section == AddTransactionSection.change.rawValue {
            let cell = addTransactionCollectionView.dequeueReusableCell(withReuseIdentifier: TextFieldSwitchCollectionViewCell.reusedId, for: indexPath) as! TextFieldSwitchCollectionViewCell
            cell.delegate = self
            cell.textFieldIndex = indexPath.section
            cell.textField.keyboardType = .numbersAndPunctuation
//            cell.segmentedControl.addTarget(self, action: #selector(segmentControlTapped(_:)), for: .valueChanged)
            cell.configure(model: presenter.currentModel())
            return cell
        } else {
            let cell = addTransactionCollectionView.dequeueReusableCell(withReuseIdentifier: TextViewCollectionViewCell.reusedId, for: indexPath) as! TextViewCollectionViewCell
            cell.delegate = self
            cell.textViewIndex = indexPath.section
            cell.configure(model: presenter.currentModel())
            return cell
        }
    }
    
//    @objc func segmentControlTapped(_ sender: UISegmentedControl) {
//        presenter.segmentControlTapped()
//    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = addTransactionCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionViewHeaderReuseIdentifier, for: indexPath) as! HeaderCollectionReusableView
        if let currentNameOfSection = AddTransactionSection(rawValue: indexPath.section) {
            switch currentNameOfSection {
            case .title:
                headerView.headerName.text = "Title"
            case .change:
                headerView.headerName.text = "Change"
            case .note:
                headerView.headerName.text = "Note"
            }
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 20)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AddTransactionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var heightOfRow = CGSize(width: 0, height: 0)
        if let currentNumberOfSection = AddTransactionSection(rawValue: indexPath.section) {
            switch currentNumberOfSection {
                
            case .title:
                heightOfRow = CGSize(width: view.frame.width, height: 155)
            case .change:
                heightOfRow = CGSize(width: view.frame.width, height: 175)
            case .note:
                heightOfRow = CGSize(width: view.frame.width, height: 300)
            }
        }
        return heightOfRow
    }
}

//MARK: - registerForKeyboardNotification
extension AddTransactionViewController {
    func registerForKeyboardWillShowNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            self.addTransactionCollectionView.setContentInsetAndScrollIndicatorInsets(UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0))
            self.addTransactionCollectionView.scrollToItem(at: IndexPath(row: 0, section: AddTransactionSection.note.rawValue), at: .top, animated: true)
        })
    }
    
    func registerForKeyboardWillHideNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { notification -> Void in
            self.addTransactionCollectionView.setContentInsetAndScrollIndicatorInsets(UIEdgeInsets.zero)
        })
    }
}

//MARK: - textFieldDelegate
//extension AddTransactionViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        let frame = self.addTransactionCollectionView.convert(textField.bounds, from: textField)
//        let cellCenter = CGPoint(x: frame.midX, y: frame.midY)
//        let indexPath = self.addTransactionCollectionView.indexPathForItem(at: cellCenter)
//        guard let indexPath = indexPath else {
//            return false
//        }
//
//        if indexPath.section == TransactionSections.title.rawValue {
//            let nextCell = self.addTransactionCollectionView.cellForItem(at: IndexPath.init(row: 0, section: TransactionSections.change.rawValue)) as! TextFieldSwitchCollectionViewCell
//            nextCell.textField.becomeFirstResponder()
//        }
//        else if indexPath.section == TransactionSections.change.rawValue {
//            let nextCell = self.addTransactionCollectionView.cellForItem(at: IndexPath.init(row: 0, section: TransactionSections.note.rawValue)) as! TextViewCollectionViewCell
//            nextCell.textView.becomeFirstResponder()
//        }
//
//        return true
//    }
//}

extension AddTransactionViewController: TextInputCollectionViewCellDelegate {
    func dataTransfer(index: Int) {
        if index == AddTransactionSection.title.rawValue {
            let nextCell = self.addTransactionCollectionView.cellForItem(at: IndexPath.init(row: 0, section: AddTransactionSection.change.rawValue)) as! TextFieldSwitchCollectionViewCell
            nextCell.textField.becomeFirstResponder()
        }
        else if index == AddTransactionSection.change.rawValue {
            let nextCell = self.addTransactionCollectionView.cellForItem(at: IndexPath.init(row: 0, section: AddTransactionSection.note.rawValue)) as! TextViewCollectionViewCell
            nextCell.textView.becomeFirstResponder()
        }
    }
    
    
    func getData(data: String, index: Int) {
        if index == AddTransactionSection.title.rawValue {
            presenter.addTitle(title: data)
        } else if index == AddTransactionSection.change.rawValue {
            presenter.addChange(change: Double(data) ?? 0)
        } else if index == AddTransactionSection.note.rawValue {
            presenter.addNote(note: data)
        }
    }
}

