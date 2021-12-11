//
//  AddWalletViewController.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 13.10.2021.
//

import UIKit

class AddWalletViewController: UIViewController {
    
    private enum Paddings {
        static let subviewHorizontalInset: CGFloat = 30
        
        enum viewWallet {
            static let topInset: CGFloat = 60
            static let horizontalInset: CGFloat = 17
            static let height: CGFloat = 75
        }
        enum addWallet {
            static let horizontalInset: CGFloat = 20
        }
        enum AddWalletCollectionView {
            static let topInset: CGFloat = 20
        }
        enum Buttons {
            static let width: CGFloat = 40
        }
    }
    
    private enum AddWalletSection: Int {
        case colorTheme = 0
        case currency
        case title
    }
    
    private let presenter: AddWalletViewOutput
    
    init(presenter: AddWalletViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewWallet = UIView(frame: .zero)
    private var labelAddWallet = UILabel(frame: .zero)
    private var buttonBack = UIButton(frame: .zero)
    private var buttonDelete = UIButton(frame: .zero)
    
    private var addWalletCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    private let collectionViewHeaderReuseIdentifier = "HeaderCollectionReusableView"
    
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
        if presenter.currentModel().name == "" {
            buttonDelete.isHidden = true
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .gray
        setupViewWallet()
        setupLabelWallet()
        setupButtonBack()
        setupButtonDelete()
        setupAddWalletCollectionView()
        registerForKeyboardNotification()
        setupLayout()
    }
    
    private func setupViewWallet() {
        viewWallet.layer.cornerRadius = 20
        viewWallet.layer.borderWidth = 1.5
        viewWallet.layer.borderColor = UIColor.white.cgColor
        viewWallet.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewWallet)
    }
    
    private func setupLabelWallet() {
        labelAddWallet.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        labelAddWallet.textColor = .black
        labelAddWallet.translatesAutoresizingMaskIntoConstraints = false
        viewWallet.addSubview(labelAddWallet)
    }
    
    private func setupButtonBack() {
        buttonBack.setImage(UIImage(named: "back"), for: .normal)
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        viewWallet.addSubview(buttonBack)
    }
    
    private func setupButtonDelete() {
        buttonDelete.setImage(UIImage(named: "delete"), for: .normal)
        buttonDelete.translatesAutoresizingMaskIntoConstraints = false
        buttonDelete.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        viewWallet.addSubview(buttonDelete)
    }
    
    private func setupAddWalletCollectionView() {
        addWalletCollectionView.register(ColorThemeCollectionViewCell.self, forCellWithReuseIdentifier: ColorThemeCollectionViewCell.reusedId)
        addWalletCollectionView.register(CurrentCurrencyCollectionViewCell.self, forCellWithReuseIdentifier: CurrentCurrencyCollectionViewCell.reusedId)
        addWalletCollectionView.register(TextFieldButtonCollectionViewCell.self, forCellWithReuseIdentifier: TextFieldButtonCollectionViewCell.reusedId)
        addWalletCollectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: collectionViewHeaderReuseIdentifier)
        layout.scrollDirection = .vertical
        addWalletCollectionView.setCollectionViewLayout(layout, animated: true)
        addWalletCollectionView.delegate = self
        addWalletCollectionView.dataSource = self
        addWalletCollectionView.backgroundColor = UIColor.clear
        layout.minimumLineSpacing = 29
        addWalletCollectionView.keyboardDismissMode = .interactive
        view.addSubview(addWalletCollectionView)
        addWalletCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            viewWallet.topAnchor.constraint(equalTo: view.topAnchor, constant: Paddings.viewWallet.topInset),
            viewWallet.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Paddings.viewWallet.horizontalInset),
            viewWallet.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Paddings.viewWallet.horizontalInset),
            viewWallet.heightAnchor.constraint(equalToConstant: Paddings.viewWallet.height),
            
            buttonBack.centerYAnchor.constraint(equalTo: viewWallet.centerYAnchor),
            buttonBack.leadingAnchor.constraint(equalTo: viewWallet.leadingAnchor, constant: Paddings.subviewHorizontalInset),
            buttonBack.widthAnchor.constraint(equalToConstant: Paddings.Buttons.width),
            
            buttonDelete.centerYAnchor.constraint(equalTo: viewWallet.centerYAnchor),
            buttonDelete.trailingAnchor.constraint(equalTo: viewWallet.trailingAnchor, constant: -Paddings.subviewHorizontalInset),
            buttonDelete.widthAnchor.constraint(equalToConstant: Paddings.Buttons.width),
            
            labelAddWallet.centerYAnchor.constraint(equalTo: viewWallet.centerYAnchor),
            labelAddWallet.leadingAnchor.constraint(equalTo: buttonBack.trailingAnchor, constant: Paddings.addWallet.horizontalInset),
            labelAddWallet.trailingAnchor.constraint(equalTo: buttonDelete.leadingAnchor, constant: -Paddings.addWallet.horizontalInset),
            
            addWalletCollectionView.topAnchor.constraint(equalTo: viewWallet.bottomAnchor, constant: Paddings.AddWalletCollectionView.topInset),
            addWalletCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            addWalletCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            addWalletCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        presenter.buttonBackTapped()
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        presenter.buttonDeleteTapped()
    }
    
    
    private func setupGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        let rightColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.55)
        let leftColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.15)
        gradient.colors = [leftColor!.cgColor, rightColor!.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: viewWallet.frame.size.width, height: viewWallet.frame.size.height)
        viewWallet.layer.insertSublayer(gradient, at: 0)
        viewWallet.clipsToBounds = true
    }
    
    private func registerForKeyboardNotification() {
        self.registerForKeyboardWillShowNotification(self.addWalletCollectionView)
        self.registerForKeyboardWillHideNotification(self.addWalletCollectionView)
    }
    
    
}

extension AddWalletViewController: AddWalletViewInput {
    func reloadUI() {
        addWalletCollectionView.reloadData()
        labelAddWallet.text = presenter.currentLabel()
        view.backgroundColor = UIColor(named: presenter.currentModel().colorName)
    }
}

// MARK: - UICollectionViewDelegate
extension AddWalletViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == AddWalletSection.colorTheme.rawValue {
            presenter.showCurrentColorModule()
        } else if indexPath.section == AddWalletSection.currency.rawValue {
            presenter.showCurrencyModule()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension AddWalletViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return AddWalletSection.title.rawValue + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = addWalletCollectionView.dequeueReusableCell(withReuseIdentifier: ColorThemeCollectionViewCell.reusedId, for: indexPath) as! ColorThemeCollectionViewCell
            cell.configure(model: presenter.currentModel())
            return cell
        } else if indexPath.section == 1{
            let cell = addWalletCollectionView.dequeueReusableCell(withReuseIdentifier: CurrentCurrencyCollectionViewCell.reusedId, for: indexPath) as! CurrentCurrencyCollectionViewCell
            cell.configure(model: presenter.currentModel())
            cell.index = indexPath.section
            return cell
        } else {
            let cell = addWalletCollectionView.dequeueReusableCell(withReuseIdentifier: TextFieldButtonCollectionViewCell.reusedId, for: indexPath) as! TextFieldButtonCollectionViewCell
            cell.buttonSave.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
            cell.configure(model: presenter.currentModel())
            cell.textFieldIndex = indexPath.section
            cell.delegate = self
            return cell
        }
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        print("button Save tapped")
        presenter.buttonSaveTapped()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = addWalletCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionViewHeaderReuseIdentifier, for: indexPath) as! HeaderCollectionReusableView
        if let currentNameOfSection = AddWalletSection(rawValue: indexPath.section) {
            switch currentNameOfSection {
            case .colorTheme:
                headerView.headerName.text = "Color theme"
            case .currency:
                headerView.headerName.text = "Currency"
            case .title:
                headerView.headerName.text = "Title"
            }
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 20)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AddWalletViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var heightOfRow = CGSize(width: 0, height: 0)
        if let currentNumberOfSection = AddWalletSection(rawValue: indexPath.section) {
            switch currentNumberOfSection {
                
            case .colorTheme:
                heightOfRow = CGSize(width: view.frame.width, height: 262)
            case .currency:
                heightOfRow = CGSize(width: view.frame.width, height: 157)
            case .title:
                heightOfRow = CGSize(width: view.frame.width, height: 205)
            }
        }
        return heightOfRow
    }
}

//MARK: - registerForKeyboardNotification
extension AddWalletViewController {
    func registerForKeyboardWillShowNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            self.addWalletCollectionView.setContentInsetAndScrollIndicatorInsets(UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 100, right: 0))
        })
    }
    
    func registerForKeyboardWillHideNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { notification -> Void in
            self.addWalletCollectionView.setContentInsetAndScrollIndicatorInsets(UIEdgeInsets.zero)
        })
    }
}

//extension UIScrollView {
//    func setContentInsetAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {
//        self.contentInset = edgeInsets
//        self.scrollIndicatorInsets = edgeInsets
//    }
//}

//MARK: - textFieldDelegate
extension AddWalletViewController: UITextFieldDelegate {
    
}

extension AddWalletViewController: TextFieldButtonCollectionViewCellDelegate {
    func getData(data: String) {
        
                presenter.addData(data: data)
    }
}
