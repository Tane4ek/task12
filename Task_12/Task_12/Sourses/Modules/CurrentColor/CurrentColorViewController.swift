//
//  CurrentColorViewController.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.11.2021.
//

import UIKit

class CurrentColorViewController: UIViewController {

    private let presenter: CurrentColorViewOutput
    
    init(presenter: CurrentColorViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewColors = UIView(frame: .zero)
    var labelColors = UILabel(frame: .zero)
    var buttonBack = UIButton(frame: .zero)

    
    var colorsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    enum Paddings {
        static let subviewHorizontalInset: CGFloat = 30
        
        enum ViewColor {
            static let topInset: CGFloat = 60
            static let horizontalInset: CGFloat = 17
            static let height: CGFloat = 75
        }
        
        enum LabelColor {
            static let horizontalInset: CGFloat = 20
        }
        enum ColorCollectionView {
            static let topInset: CGFloat = 40
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewWillAppear()
    }
    
    func setupUI() {
        view.backgroundColor = .gray
        setupViewColors()
        setupLabelColors()
        setupButtonBack()
        setupColorsCollectionView()
        setupLayout()
    }
    
    func setupViewColors() {
        viewColors.layer.cornerRadius = 20
        viewColors.layer.borderWidth = 1.5
        viewColors.layer.borderColor = UIColor.white.cgColor
        viewColors.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewColors)
    }
    
    func setupLabelColors() {
        labelColors.text = "Wallet currency"
        labelColors.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        labelColors.textColor = .black
        labelColors.translatesAutoresizingMaskIntoConstraints = false
        viewColors.addSubview(labelColors)
    }
    
    func setupButtonBack() {
        buttonBack.setImage(UIImage(named: "back"), for: .normal)
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        viewColors.addSubview(buttonBack)
    }
    
    func setupColorsCollectionView() {
        colorsCollectionView.register(CurrentColorCollectionViewCell.self, forCellWithReuseIdentifier: CurrentColorCollectionViewCell.reusedId)
        layout.scrollDirection = .vertical
        colorsCollectionView.backgroundColor = UIColor.clear
        colorsCollectionView.setCollectionViewLayout(layout, animated: true)
        colorsCollectionView.delegate = self
        colorsCollectionView.dataSource = self
        layout.minimumLineSpacing = 20
        colorsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(colorsCollectionView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            viewColors.topAnchor.constraint(equalTo: view.topAnchor, constant: Paddings.ViewColor.topInset),
            viewColors.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Paddings.ViewColor.horizontalInset),
            viewColors.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Paddings.ViewColor.horizontalInset),
            viewColors.heightAnchor.constraint(equalToConstant: Paddings.ViewColor.height),
            
            buttonBack.centerYAnchor.constraint(equalTo: viewColors.centerYAnchor),
            buttonBack.leadingAnchor.constraint(equalTo: viewColors.leadingAnchor, constant: Paddings.subviewHorizontalInset),
            
            labelColors.centerYAnchor.constraint(equalTo: viewColors.centerYAnchor),
            labelColors.leadingAnchor.constraint(equalTo: buttonBack.trailingAnchor, constant: Paddings.LabelColor.horizontalInset),
            
            colorsCollectionView.topAnchor.constraint(equalTo: viewColors.bottomAnchor, constant: Paddings.ColorCollectionView.topInset),
            colorsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            colorsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            colorsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        presenter.buttonBackTapped()
    }
}

extension CurrentColorViewController: CurrentColorViewInput {
    func reloadUI() {
        colorsCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension CurrentColorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
        
    }
}

// MARK: - UICollectionViewDataSource
extension CurrentColorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorsCollectionView.dequeueReusableCell(withReuseIdentifier: CurrentColorCollectionViewCell.reusedId, for: indexPath) as! CurrentColorCollectionViewCell
        let modelOfIndex = presenter.modelOfIndex(index: indexPath.row)
        cell.configure(model: modelOfIndex)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CurrentColorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - (Paddings.subviewHorizontalInset * 2), height: 160)
    }
}




