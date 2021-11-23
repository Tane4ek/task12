//
//  TransactionHistoryViewController.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 23.10.2021.
//

import UIKit

class TransactionHistoryViewController: UIViewController {
    
    private let presenter: TransactionHistoryViewOutput
    
    init(presenter: TransactionHistoryViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewTransaction = UIView(frame: .zero)
    var labelTransaction = UILabel(frame: .zero)
    var buttonBackToWallet = UIButton(frame: .zero)
    
    var transactionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    enum Paddings {
        enum ButtonBack {
            static let horizontalInset: CGFloat = 30
        }
        enum ViewTransaction {
            static let topInset: CGFloat = 60
            static let horizontalInset: CGFloat = 17
            static let height: CGFloat = 75
        }
        enum LabelName {
            static let horizontalInset: CGFloat = 20
        }
        
        enum TransactioncollectionView {
            static let topInset: CGFloat = 40
            static let horizontalInset: CGFloat = 17
            static let bottomInset: CGFloat = 30
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewWillAppear()
        setupGradient()
        
    }
    
    func setupUI() {
        view.backgroundColor = .gray
        setupViewTransaction()
        setupLabelTransaction()
        setupButtonBackToWallet()
        setupTransactionCollectionView()
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
        labelTransaction.text = "Transaction"
        labelTransaction.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        labelTransaction.textColor = .black
        labelTransaction.translatesAutoresizingMaskIntoConstraints = false
        viewTransaction.addSubview(labelTransaction)
    }
    
    func setupButtonBackToWallet() {
        buttonBackToWallet.setImage(UIImage(named: "back"), for: .normal)
        buttonBackToWallet.translatesAutoresizingMaskIntoConstraints = false
        buttonBackToWallet.addTarget(self, action: #selector(buttonBackToWalletTapped(_:)), for: .touchUpInside)
        viewTransaction.addSubview(buttonBackToWallet)
    }
    
    func setupTransactionCollectionView() {
        transactionCollectionView.register(TransactionCollectionViewCell.self, forCellWithReuseIdentifier: TransactionCollectionViewCell.reusedId)
        layout.scrollDirection = .vertical
        transactionCollectionView.backgroundColor = UIColor.clear
        transactionCollectionView.setCollectionViewLayout(layout, animated: true)
        transactionCollectionView.delegate = self
        transactionCollectionView.dataSource = self
        layout.minimumLineSpacing = 20
        transactionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(transactionCollectionView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            viewTransaction.topAnchor.constraint(equalTo: view.topAnchor, constant: Paddings.ViewTransaction.topInset),
            viewTransaction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Paddings.ViewTransaction.horizontalInset),
            viewTransaction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Paddings.ViewTransaction.horizontalInset),
            viewTransaction.heightAnchor.constraint(equalToConstant: Paddings.ViewTransaction.height),
            
            buttonBackToWallet.leadingAnchor.constraint(equalTo: viewTransaction.leadingAnchor, constant: Paddings.ButtonBack.horizontalInset),
            buttonBackToWallet.centerYAnchor.constraint(equalTo: viewTransaction.centerYAnchor),
            
            labelTransaction.leadingAnchor.constraint(equalTo: buttonBackToWallet.trailingAnchor, constant: Paddings.LabelName.horizontalInset),
            labelTransaction.centerYAnchor.constraint(equalTo: viewTransaction.centerYAnchor),
            
            transactionCollectionView.topAnchor.constraint(equalTo: viewTransaction.bottomAnchor, constant: Paddings.TransactioncollectionView.topInset),
            transactionCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Paddings.TransactioncollectionView.horizontalInset),
            transactionCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Paddings.TransactioncollectionView.horizontalInset),
            transactionCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Paddings.TransactioncollectionView.bottomInset)
            
        ])
    }
    
    
    @objc func buttonBackToWalletTapped(_ sender: UIButton) {
        presenter.buttonBackTapped()
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
}

extension TransactionHistoryViewController: TransactionHistoryViewInput {
    func reloadUI() {
        transactionCollectionView.reloadData()
        view.backgroundColor = UIColor(named: presenter.currentModel().colorName)
    }
}

// MARK: - UICollectionViewDelegate
extension TransactionHistoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource
extension TransactionHistoryViewController: UICollectionViewDataSource {
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
extension TransactionHistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - Paddings.TransactioncollectionView.horizontalInset*2, height: 90)
    }
}


