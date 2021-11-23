//
//  WalletsListViewController.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 12.10.2021.
//

import UIKit


class WalletsListViewController: UIViewController {
    
    private let presenter: WalletListViewOutput
    
    init(presenter: WalletListViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewWallet = UIView(frame: .zero)
    var labelWallet = UILabel(frame: .zero)
    var buttonAdd = UIButton(frame: .zero)
    var labelNoWallet = UILabel(frame: .zero)
    
    var walletListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    enum Paddings {
        static let subviewHorizontalInset: CGFloat = 30
        
        enum ViewWallet {
            static let topInset: CGFloat = 60
            static let horizontalInset: CGFloat = 17
            static let height: CGFloat = 75
        }
        enum WalletListCollectionView {
            static let topInset: CGFloat = 40
        }
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
        if presenter.numberOfItems() != 0 {
            labelNoWallet.isHidden = true
        }
    }
    
    func setupUI() {
        view.backgroundColor = .gray
        navigationController?.navigationBar.isHidden = true
        setupViewWallet()
        setupLabelWallet()
        setupButtonAdd()
        setupNoWalletLabel()
        setupWalletListCollectionView()
        setupLayout()
    }
    
    func setupViewWallet() {
        viewWallet.layer.cornerRadius = 20
        viewWallet.layer.borderWidth = 1.5
        viewWallet.layer.borderColor = UIColor.white.cgColor
        viewWallet.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewWallet)
    }
    
    func setupLabelWallet() {
        labelWallet.text = "Wallets"
        labelWallet.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        labelWallet.textColor = .black
        labelWallet.translatesAutoresizingMaskIntoConstraints = false
        viewWallet.addSubview(labelWallet)
    }
    
    func setupButtonAdd() {
        buttonAdd.setImage(UIImage(named: "add"), for: .normal)
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        buttonAdd.addTarget(self, action: #selector(addWalletButtonTapped(_:)), for: .touchUpInside)
        viewWallet.addSubview(buttonAdd)
    }
    
    func setupNoWalletLabel() {
        labelNoWallet.text = "No wallets created 😢"
        labelNoWallet.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        labelNoWallet.textColor = .black
        labelNoWallet.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelNoWallet)
    }
    
    func setupWalletListCollectionView() {
        walletListCollectionView.register(WalletCollectionViewCell.self, forCellWithReuseIdentifier: WalletCollectionViewCell.reusedId)
        layout.scrollDirection = .vertical
        walletListCollectionView.backgroundColor = UIColor.clear
        walletListCollectionView.setCollectionViewLayout(layout, animated: true)
        walletListCollectionView.delegate = self
        walletListCollectionView.dataSource = self
        layout.minimumLineSpacing = 20
        walletListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(walletListCollectionView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            viewWallet.topAnchor.constraint(equalTo: view.topAnchor, constant: Paddings.ViewWallet.topInset),
            viewWallet.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Paddings.ViewWallet.horizontalInset),
            viewWallet.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Paddings.ViewWallet.horizontalInset),
            viewWallet.heightAnchor.constraint(equalToConstant: Paddings.ViewWallet.height),
            
            labelWallet.centerYAnchor.constraint(equalTo: viewWallet.centerYAnchor),
            labelWallet.leadingAnchor.constraint(equalTo: viewWallet.leadingAnchor, constant: Paddings.subviewHorizontalInset),
            
            buttonAdd.centerYAnchor.constraint(equalTo: viewWallet.centerYAnchor),
            buttonAdd.trailingAnchor.constraint(equalTo: viewWallet.trailingAnchor, constant: -Paddings.subviewHorizontalInset),
            
            labelNoWallet.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelNoWallet.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            walletListCollectionView.topAnchor.constraint(equalTo: viewWallet.bottomAnchor, constant: Paddings.WalletListCollectionView.topInset),
            walletListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            walletListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            walletListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func addWalletButtonTapped(_ sender: UIButton) {
        presenter.buttonAddTapped()
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
}

extension WalletsListViewController: WalletListViewInput {
    func reloadUI() {
        walletListCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension WalletsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource
extension WalletsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = walletListCollectionView.dequeueReusableCell(withReuseIdentifier: WalletCollectionViewCell.reusedId, for: indexPath) as! WalletCollectionViewCell
        let modelOfIndex = presenter.modelOfIndex(index: indexPath.row)
        cell.configure(model: modelOfIndex)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WalletsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 220)
    }
}

