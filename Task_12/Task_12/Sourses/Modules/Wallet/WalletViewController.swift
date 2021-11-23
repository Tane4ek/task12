//
//  WalletViewController.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 13.10.2021.
//

import UIKit

class WalletViewController: UIViewController {
    
    private let presenter: WalletViewOutput
    
    init(presenter: WalletViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewWallet = UIView(frame: .zero)
    var labelName = UILabel(frame: .zero)
    var buttonSettings = UIButton(frame: .zero)
    var buttonBackToWallets = UIButton(frame: .zero)
    
    var labelBalance = UILabel(frame: .zero)
    
    var viewTransaction = UIView(frame: .zero)
    var labelTransaction = UILabel(frame: .zero)
    var buttonAllTransaction = UIButton(frame: .zero)
    var transactionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    var buttonAddTransaction = UIButton(frame: .zero)
    
    enum Paddings {
        enum ButtonsWallet {
            static let horizontalInset: CGFloat = 30
        }
        enum ViewWallet {
            static let topInset: CGFloat = 60
            static let horizontalInset: CGFloat = 17
            static let height: CGFloat = 75
        }
        enum LabelName {
            static let horizontalInset: CGFloat = 20
        }
        enum LabelBalance {
            static let horizontalInset: CGFloat = 17
            static let topInset: CGFloat = 40
            static let height: CGFloat = 100
        }
        enum ViewTransaction {
            static let topInset: CGFloat = 20
            static let horizontalInset: CGFloat = 17
            static let bottomInset: CGFloat = 30
        }
        enum LabelTransaction {
            static let topInset: CGFloat = 24
            static let horizontalInset: CGFloat = 36
        }
        enum ButtonAllTransaction {
            static let topInset: CGFloat = 20
            static let horizontalInset: CGFloat = 28
            static let width: CGFloat = 114
        }
        enum TransactioncollectionView {
            static let topInset: CGFloat = 20
            static let horizontalInset: CGFloat = 27
            static let bottomInset: CGFloat = 10
        }
        enum ButtonAddTransaction {
            static let bottomInset: CGFloat = 20
            static let width: CGFloat = 211
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
        setupGradient()
    }
    
    func setupUI() {
        view.backgroundColor = .gray
        setupViewWallet()
        setupLabelWallet()
        setupButtonSettings()
        setupButtonBackToWallets()
        setupLabelBalance()
        setupTransactionView()
        setupLabelTransaction()
        setupButtonAllTransaction()
        setupButtonAddTransaction()
        setupTransactionCollectionView()
        setupLayout()
    }
    
    func setupViewWallet() {
        viewWallet = viewStyle()
        view.addSubview(viewWallet)
    }
    
    func setupLabelWallet() {
        labelName.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        labelName.textColor = .black
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.minimumScaleFactor = 0.5
        viewWallet.addSubview(labelName)
    }
    
    func setupButtonSettings() {
        buttonSettings.setImage(UIImage(named: "settings"), for: .normal)
        buttonSettings.translatesAutoresizingMaskIntoConstraints = false
        buttonSettings.addTarget(self, action: #selector(buttonSettingsTapped(_:)), for: .touchUpInside)
        viewWallet.addSubview(buttonSettings)
    }
    
    func setupButtonBackToWallets() {
        buttonBackToWallets.setImage(UIImage(named: "wallets"), for: .normal)
        buttonBackToWallets.translatesAutoresizingMaskIntoConstraints = false
        buttonBackToWallets.addTarget(self, action: #selector(buttonBackToWalletsTapped(_:)), for: .touchUpInside)
        viewWallet.addSubview(buttonBackToWallets)
    }
    
    func setupLabelBalance() {
        labelBalance.font = UIFont(name: "Montserrat-SemiBold", size: 36)
        labelBalance.textColor = .black
        labelBalance.textAlignment = .center
        labelBalance.layer.cornerRadius = 20
        labelBalance.layer.borderWidth = 1.5
        labelBalance.layer.borderColor = UIColor.white.cgColor
        labelBalance.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelBalance)
    }
    
    func setupTransactionView() {
        viewTransaction = viewStyle()
        view.addSubview(viewTransaction)
    }
    
    func setupLabelTransaction() {
        labelTransaction.text = "Transaction"
        labelTransaction.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        labelTransaction.textColor = .black
        labelTransaction.translatesAutoresizingMaskIntoConstraints = false
        viewTransaction.addSubview(labelTransaction)
    }
    
    func setupButtonAllTransaction() {
        buttonAllTransaction = buttonStyle()
        buttonAllTransaction.setTitle("See all", for: .normal)
        buttonAllTransaction.addTarget(self, action: #selector(buttonAllTransactionTapped(_:)), for: .touchUpInside)
        viewTransaction.addSubview(buttonAllTransaction)
    }
    
    
    
    func setupButtonAddTransaction() {
        buttonAddTransaction = buttonStyle()
        buttonAddTransaction.setTitle("Add Transaction", for: .normal)
        buttonAddTransaction.addTarget(self, action: #selector(buttonAddTransactionTapped(_:)), for: .touchUpInside)
        viewTransaction.addSubview(buttonAddTransaction)
    }
    
    func setupTransactionCollectionView() {
        transactionCollectionView.register(TransactionCollectionViewCell.self, forCellWithReuseIdentifier: TransactionCollectionViewCell.reusedId)
        layout.scrollDirection = .vertical
        transactionCollectionView.backgroundColor = UIColor.clear
        transactionCollectionView.setCollectionViewLayout(layout, animated: true)
        transactionCollectionView.delegate = self
        transactionCollectionView.dataSource = self
        transactionCollectionView.isScrollEnabled = false
        layout.minimumLineSpacing = 20
        transactionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        viewTransaction.addSubview(transactionCollectionView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            viewWallet.topAnchor.constraint(equalTo: view.topAnchor, constant: Paddings.ViewWallet.topInset),
            viewWallet.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Paddings.ViewWallet.horizontalInset),
            viewWallet.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Paddings.ViewWallet.horizontalInset),
            viewWallet.heightAnchor.constraint(equalToConstant: Paddings.ViewWallet.height),
            
            buttonBackToWallets.centerYAnchor.constraint(equalTo: viewWallet.centerYAnchor),
            buttonBackToWallets.leadingAnchor.constraint(equalTo: viewWallet.leadingAnchor, constant: Paddings.ButtonsWallet.horizontalInset),
            
            labelName.centerYAnchor.constraint(equalTo: viewWallet.centerYAnchor),
            labelName.leadingAnchor.constraint(equalTo: buttonBackToWallets.trailingAnchor, constant: Paddings.LabelName.horizontalInset),
//            labelName.trailingAnchor.constraint(equalTo: buttonSettings.leadingAnchor, constant: Paddings.LabelName.horizontalInset),
            
            buttonSettings.centerYAnchor.constraint(equalTo: viewWallet.centerYAnchor),
            buttonSettings.trailingAnchor.constraint(equalTo: viewWallet.trailingAnchor, constant: -Paddings.ButtonsWallet.horizontalInset),
//            buttonSettings.leadingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: Paddings.LabelName.horizontalInset),
            
            labelBalance.topAnchor.constraint(equalTo: viewWallet.bottomAnchor, constant: Paddings.LabelBalance.topInset),
            labelBalance.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Paddings.LabelBalance.horizontalInset),
            labelBalance.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Paddings.LabelBalance.horizontalInset),
            labelBalance.heightAnchor.constraint(equalToConstant: Paddings.LabelBalance.height),
            
            viewTransaction.topAnchor.constraint(equalTo: labelBalance.bottomAnchor, constant: Paddings.ViewTransaction.topInset),
            viewTransaction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Paddings.ViewTransaction.horizontalInset),
            viewTransaction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Paddings.ViewTransaction.horizontalInset),
            viewTransaction.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Paddings.ViewTransaction.bottomInset),
            
            labelTransaction.topAnchor.constraint(equalTo: viewTransaction.topAnchor, constant: Paddings.LabelTransaction.topInset),
            labelTransaction.leadingAnchor.constraint(equalTo: viewTransaction.leadingAnchor, constant: Paddings.LabelTransaction.horizontalInset),
            
            buttonAllTransaction.topAnchor.constraint(equalTo: viewTransaction.topAnchor, constant: Paddings.ButtonAllTransaction.topInset),
            buttonAllTransaction.trailingAnchor.constraint(equalTo: viewTransaction.trailingAnchor, constant: -Paddings.ButtonAllTransaction.horizontalInset),
            buttonAllTransaction.widthAnchor.constraint(equalToConstant: Paddings.ButtonAllTransaction.width),
            
            buttonAddTransaction.bottomAnchor.constraint(equalTo: viewTransaction.bottomAnchor, constant: -Paddings.ButtonAddTransaction.bottomInset),
            buttonAddTransaction.centerXAnchor.constraint(equalTo: viewTransaction.centerXAnchor),
            buttonAddTransaction.widthAnchor.constraint(equalToConstant: Paddings.ButtonAddTransaction.width),
            
            transactionCollectionView.topAnchor.constraint(equalTo: buttonAllTransaction.bottomAnchor, constant: Paddings.TransactioncollectionView.topInset),
            transactionCollectionView.leadingAnchor.constraint(equalTo: viewTransaction.leadingAnchor, constant: Paddings.TransactioncollectionView.horizontalInset),
            transactionCollectionView.trailingAnchor.constraint(equalTo: viewTransaction.trailingAnchor, constant: -Paddings.TransactioncollectionView.horizontalInset),
            transactionCollectionView.bottomAnchor.constraint(equalTo: buttonAddTransaction.topAnchor, constant: -Paddings.TransactioncollectionView.bottomInset)
            
        ])
    }
    
    func viewStyle() -> UIView {
        let viewStyle = UIView()
        viewStyle.layer.cornerRadius = 20
        viewStyle.layer.borderWidth = 1.5
        viewStyle.layer.borderColor = UIColor.white.cgColor
        viewStyle.translatesAutoresizingMaskIntoConstraints = false
        return viewStyle
    }
    
    func buttonStyle() -> UIButton {
        let buttonStyle = UIButton()
        buttonStyle.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 20)
        buttonStyle.setTitleColor(UIColor(named: "Green Blue Crayola"), for: .normal)
        buttonStyle.backgroundColor = UIColor.white.withAlphaComponent(0.55)
        buttonStyle.layer.cornerRadius = 20
        buttonStyle.layer.borderWidth = 1.5
        buttonStyle.layer.borderColor = UIColor.white.cgColor
        buttonStyle.translatesAutoresizingMaskIntoConstraints = false
        return buttonStyle
    }
    
    func setupGradient() {
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
    
    @objc func buttonSettingsTapped(_ sender: UIButton) {
        presenter.buttonSettingsTapped()
        print("button tapped")
    }
    
    @objc func buttonBackToWalletsTapped(_ sender: UIButton) {
        presenter.buttonBackTapped()
    }
    
    @objc func buttonAllTransactionTapped(_ sender: UIButton) {
        presenter.buttonAllTapped()
    }
    
    @objc func buttonAddTransactionTapped(_ sender: UIButton) {
        presenter.buttonAddTapped()
    }
}

extension WalletViewController: WalletViewInput {
    func reloadUI() {
        transactionCollectionView.reloadData()
        labelName.text = presenter.currentModel().name
        labelBalance.text = String(presenter.currentModel().balance) + " " + presenter.currentModel().codeCurrency
        view.backgroundColor = UIColor(named: presenter.currentModel().colorName)
    }
}

// MARK: - UICollectionViewDelegate
extension WalletViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                presenter.didSelectRowAt(index: indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource
extension WalletViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = transactionCollectionView.dequeueReusableCell(withReuseIdentifier: TransactionCollectionViewCell.reusedId, for: indexPath) as! TransactionCollectionViewCell
        let modelOfIndex = presenter.modelOfIndex(index: indexPath.row)
        cell.configure(model: modelOfIndex)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WalletViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: viewTransaction.frame.width - 2 * Paddings.TransactioncollectionView.horizontalInset, height: 90)
    }
}


