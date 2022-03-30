//
//  CurrienciesListViewController.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 05.11.2021.
//

import UIKit

class CurrenciesListViewController: UIViewController {
    
    private enum Paddings {
        static let subviewHorizontalInset: CGFloat = 30
        
        enum ViewCurrencies {
            static let topInset: CGFloat = 60
            static let horizontalInset: CGFloat = 17
            static let height: CGFloat = 75
        }
        
        enum labelCurrencies {
            static let horizontalInset: CGFloat = 20
        }
        enum CurrenciesListCollectionView {
            static let topInset: CGFloat = 40
        }
    }
    
    private var viewCurrencies = UIView(frame: .zero)
    private var labelCurrencies = UILabel(frame: .zero)
    private var buttonBack = UIButton(frame: .zero)
    
    private var currenciesListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    private let presenter: CurrenciesListViewOutput
    
// MARK: - Init
    init(presenter: CurrenciesListViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewWillAppear()
        setupGradient()
    }

// MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = UIColor(named: presenter.currentColor())
        setupViewCurrencies()
        setupLabelCurrencies()
        setupButtonBack()
        setupCurrenciesListCollectionView()
        setupLayout()
    }
    
    private func setupViewCurrencies() {
        viewCurrencies.layer.cornerRadius = 20
        viewCurrencies.layer.borderWidth = 1.5
        viewCurrencies.layer.borderColor = UIColor.white.cgColor
        viewCurrencies.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewCurrencies)
    }
    
    private func setupLabelCurrencies() {
        labelCurrencies.text = "Wallet currency"
        labelCurrencies.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        labelCurrencies.textColor = .black
        labelCurrencies.translatesAutoresizingMaskIntoConstraints = false
        viewCurrencies.addSubview(labelCurrencies)
    }
    
    private func setupButtonBack() {
        buttonBack.setImage(UIImage(named: "back"), for: .normal)
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        viewCurrencies.addSubview(buttonBack)
    }
    
    private func setupCurrenciesListCollectionView() {
        currenciesListCollectionView.register(CurrenciesCollectionViewCell.self, forCellWithReuseIdentifier: CurrenciesCollectionViewCell.reusedId)
        layout.scrollDirection = .vertical
        currenciesListCollectionView.backgroundColor = UIColor.clear
        currenciesListCollectionView.setCollectionViewLayout(layout, animated: true)
        currenciesListCollectionView.delegate = self
        currenciesListCollectionView.dataSource = self
        layout.minimumLineSpacing = 20
        currenciesListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currenciesListCollectionView)
    }
 
// MARK: - Layout
    private func setupLayout() {
        NSLayoutConstraint.activate([
            viewCurrencies.topAnchor.constraint(equalTo: view.topAnchor, constant: Paddings.ViewCurrencies.topInset),
            viewCurrencies.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Paddings.ViewCurrencies.horizontalInset),
            viewCurrencies.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Paddings.ViewCurrencies.horizontalInset),
            viewCurrencies.heightAnchor.constraint(equalToConstant: Paddings.ViewCurrencies.height),
            
            buttonBack.centerYAnchor.constraint(equalTo: viewCurrencies.centerYAnchor),
            buttonBack.leadingAnchor.constraint(equalTo: viewCurrencies.leadingAnchor, constant: Paddings.subviewHorizontalInset),
            
            labelCurrencies.centerYAnchor.constraint(equalTo: viewCurrencies.centerYAnchor),
            labelCurrencies.leadingAnchor.constraint(equalTo: buttonBack.trailingAnchor, constant: Paddings.labelCurrencies.horizontalInset),
            
            currenciesListCollectionView.topAnchor.constraint(equalTo: viewCurrencies.bottomAnchor, constant: Paddings.CurrenciesListCollectionView.topInset),
            currenciesListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            currenciesListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            currenciesListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        presenter.buttonBackTapped()
    }
    
    private func setupGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        let rightColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.55)
        let leftColor = UIColor(named: "Baby Powder")?.withAlphaComponent(0.15)
        gradient.colors = [leftColor!.cgColor, rightColor!.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: viewCurrencies.frame.size.width, height: viewCurrencies.frame.size.height)
        viewCurrencies.layer.insertSublayer(gradient, at: 0)
        viewCurrencies.clipsToBounds = true
    }
}

// MARK: - CurrenciesListViewInput
extension CurrenciesListViewController: CurrenciesListViewInput {
    func reloadUI() {
        currenciesListCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension CurrenciesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
        
    }
}

// MARK: - UICollectionViewDataSource
extension CurrenciesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = currenciesListCollectionView.dequeueReusableCell(withReuseIdentifier: CurrenciesCollectionViewCell.reusedId, for: indexPath) as! CurrenciesCollectionViewCell
        let modelOfIndex = presenter.modelOfIndex(index: indexPath.row)
        cell.configure(model: modelOfIndex)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CurrenciesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 75)
    }
}




