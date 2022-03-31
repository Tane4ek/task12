//
//  TransactionViewController.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 11.11.2021.
//

import UIKit

class TransactionViewController: UIViewController {
    
    private enum Paddings {
        enum ButtonBack {
            static let horizontalInset: CGFloat = 30
        }
        enum ViewTransaction {
            static let topInset: CGFloat = 60
            static let horizontalInset: CGFloat = 17
            static let height: CGFloat = 75
        }
        enum LabelDate {
            static let horizontalInset: CGFloat = 20
        }
        
        enum ViewCurrentTransaction {
            static let topInset: CGFloat = 40
            static let horizontalInset: CGFloat = 17
            static let height: CGFloat = 600
        }
        
        enum SubViews {
            static let verticalInset: CGFloat = 40
            static let horizontalInset: CGFloat = 30
        }
        
        enum NoteLabel {
            static let verticalInset: CGFloat = 30
            static let horizontalInset: CGFloat = 20
        }
        
        enum ButtonDelete {
            static let topInset: CGFloat = 20
            static let bottomInset: CGFloat = 20
            static let width: CGFloat = 114
        }
    }
    
    private var viewTransaction = UIView(frame: .zero)
    private var labelData = UILabel(frame: .zero)
    private var buttonBackToWallet = UIButton(frame: .zero)
    
    private var viewCurrentTransaction = UIView(frame: .zero)
    private var labelName = UILabel(frame: .zero)
    private var labelBalance = UILabel(frame: .zero)
    private var buttonEdit = UIButton(frame: .zero)
    private var viewNote = UIView(frame: .zero)
    private var labelNote = UILabel(frame: .zero)
    private var labelNoteText = UILabel(frame: .zero)
    private var buttonDelete = UIButton(frame: .zero)
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.delegate = self
        return scroll
    }()
    
    private let presenter: TransactionViewOutput
    
// MARK: - Init
    init(presenter: TransactionViewOutput) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    
// MARK: - setupUI
    private func setupUI() {
        setupViewTransaction()
        setupLabelDate()
        setupButtonBackToWallet()
        setupScrollView()
        setupViewCurrentTransaction()
        setupLabelName()
        setupLabelBalance()
        setupButtonEdit()
        setupButtonDelete()
        setupNoteView()
        setupLabelNote()
        setupLabelNoteText()
        setupLayout()
    }
    
    private func setupViewTransaction() {
        viewTransaction.layer.cornerRadius = 20
        viewTransaction.layer.borderWidth = 1.5
        viewTransaction.layer.borderColor = UIColor.white.cgColor
        viewTransaction.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewTransaction)
    }
    
    private func setupLabelDate() {
        labelData.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        labelData.textColor = .black
        labelData.translatesAutoresizingMaskIntoConstraints = false
        viewTransaction.addSubview(labelData)
    }
    
    private func setupButtonBackToWallet() {
        buttonBackToWallet.setImage(UIImage(named: "wallets"), for: .normal)
        buttonBackToWallet.translatesAutoresizingMaskIntoConstraints = false
        buttonBackToWallet.addTarget(self, action: #selector(buttonBackToWalletTapped(_:)), for: .touchUpInside)
        viewTransaction.addSubview(buttonBackToWallet)
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
    }
    
    private func setupViewCurrentTransaction() {
        viewCurrentTransaction.layer.cornerRadius = 20
        viewCurrentTransaction.layer.borderWidth = 1.5
        viewCurrentTransaction.layer.borderColor = UIColor.white.cgColor
        viewCurrentTransaction.backgroundColor = UIColor.white.withAlphaComponent(0.55)
        viewCurrentTransaction.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(viewCurrentTransaction)
    }
    private func setupLabelName() {
        labelName.font = UIFont(name: "Montserrat-SemiBold", size: 36)
        labelName.textColor = .black
        labelName.minimumScaleFactor = 0.5
        labelName.translatesAutoresizingMaskIntoConstraints = false
        viewCurrentTransaction.addSubview(labelName)
    }
    private func setupLabelBalance() {
        labelBalance.font = UIFont(name: "Montserrat-SemiBold", size: 48)
        labelBalance.textColor = UIColor(named: "Amaranth Red")
        labelBalance.translatesAutoresizingMaskIntoConstraints = false
        viewCurrentTransaction.addSubview(labelBalance)
    }
    private func setupButtonEdit() {
        buttonEdit.setImage(UIImage(named: "edit"), for: .normal)
        buttonEdit.addTarget(self, action: #selector(buttonEditTapped(_:)), for: .touchUpInside)
        buttonEdit.translatesAutoresizingMaskIntoConstraints = false
        viewCurrentTransaction.addSubview(buttonEdit)
    }
    private func setupButtonDelete() {
        buttonDelete.setTitle("Delete", for: .normal)
        buttonDelete.setTitleColor(UIColor(named: "Amaranth Red"), for: .normal)
        buttonDelete.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 20)
        buttonDelete.backgroundColor = UIColor.white.withAlphaComponent(0.55)
        buttonDelete.layer.cornerRadius = 20
        buttonDelete.layer.borderWidth = 1.5
        buttonDelete.layer.borderColor = UIColor.white.cgColor
        buttonDelete.addTarget(self, action: #selector(buttonDeleteTapped(_:)), for: .touchUpInside)
        buttonDelete.translatesAutoresizingMaskIntoConstraints = false
        viewCurrentTransaction.addSubview(buttonDelete)
    }
    private func setupNoteView() {
        viewNote.layer.cornerRadius = 10
        viewNote.layer.borderWidth = 1
        viewNote.layer.borderColor = UIColor.white.cgColor
        viewNote.backgroundColor = UIColor.white.withAlphaComponent(0.55)
        viewNote.translatesAutoresizingMaskIntoConstraints = false
        viewCurrentTransaction.addSubview(viewNote)
    }
    private func setupLabelNote() {
        labelNote.text = "Note"
        labelNote.font = UIFont(name: "Montserrat-Semibold", size: 24)
        labelNote.textColor = .black
        labelNote.translatesAutoresizingMaskIntoConstraints = false
        viewNote.addSubview(labelNote)
    }
    private func setupLabelNoteText() {
        labelNoteText.numberOfLines = 0
        labelNoteText.font = UIFont(name: "Montserrat-Semibold", size: 18)
        labelNoteText.textColor = .black
        labelNoteText.textAlignment = .left
        labelNoteText.translatesAutoresizingMaskIntoConstraints = false
        viewNote.addSubview(labelNoteText)
    }
  
// MARK: - Layout
    private func setupLayout() {
        NSLayoutConstraint.activate([
            viewTransaction.topAnchor.constraint(equalTo: view.topAnchor, constant: Paddings.ViewTransaction.topInset),
            viewTransaction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Paddings.ViewTransaction.horizontalInset),
            viewTransaction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Paddings.ViewTransaction.horizontalInset),
            viewTransaction.heightAnchor.constraint(equalToConstant: Paddings.ViewTransaction.height),
            
            buttonBackToWallet.centerYAnchor.constraint(equalTo: viewTransaction.centerYAnchor),
            buttonBackToWallet.leadingAnchor.constraint(equalTo: viewTransaction.leadingAnchor, constant: Paddings.ButtonBack.horizontalInset),
            
            labelData.centerYAnchor.constraint(equalTo: viewTransaction.centerYAnchor),
            labelData.leadingAnchor.constraint(equalTo: buttonBackToWallet.trailingAnchor, constant: Paddings.LabelDate.horizontalInset),
            
            scrollView.topAnchor.constraint(equalTo: viewTransaction.bottomAnchor, constant: Paddings.ViewCurrentTransaction.topInset),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            viewCurrentTransaction.topAnchor.constraint(equalTo: scrollView.topAnchor),
            viewCurrentTransaction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Paddings.ViewCurrentTransaction.horizontalInset),
            viewCurrentTransaction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Paddings.ViewCurrentTransaction.horizontalInset),
            viewCurrentTransaction.heightAnchor.constraint(equalToConstant: Paddings.ViewCurrentTransaction.height),
            viewCurrentTransaction.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Paddings.ButtonDelete.bottomInset),
            
            buttonEdit.topAnchor.constraint(equalTo: viewCurrentTransaction.topAnchor, constant: Paddings.SubViews.verticalInset),
            buttonEdit.trailingAnchor.constraint(equalTo: viewCurrentTransaction.trailingAnchor, constant: -Paddings.SubViews.horizontalInset),

            labelName.topAnchor.constraint(equalTo: viewCurrentTransaction.topAnchor, constant: Paddings.SubViews.verticalInset),
            labelName.leadingAnchor.constraint(equalTo: viewCurrentTransaction.leadingAnchor, constant: Paddings.SubViews.horizontalInset),

            labelBalance.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: Paddings.SubViews.verticalInset),
            labelBalance.leadingAnchor.constraint(equalTo: viewCurrentTransaction.leadingAnchor, constant: Paddings.SubViews.horizontalInset),

            buttonDelete.bottomAnchor.constraint(equalTo: viewCurrentTransaction.bottomAnchor, constant: -Paddings.ButtonDelete.bottomInset),
            buttonDelete.centerXAnchor.constraint(equalTo: viewCurrentTransaction.centerXAnchor),
            buttonDelete.widthAnchor.constraint(equalToConstant: Paddings.ButtonDelete.width),

            viewNote.topAnchor.constraint(equalTo: labelBalance.bottomAnchor, constant: Paddings.SubViews.verticalInset),
            viewNote.leadingAnchor.constraint(equalTo: viewCurrentTransaction.leadingAnchor, constant: Paddings.SubViews.horizontalInset),
            viewNote.trailingAnchor.constraint(equalTo: viewCurrentTransaction.trailingAnchor, constant: -Paddings.SubViews.horizontalInset),
            viewNote.bottomAnchor.constraint(equalTo: buttonDelete.topAnchor, constant: -Paddings.ButtonDelete.topInset),

            labelNote.topAnchor.constraint(equalTo: viewNote.topAnchor, constant: Paddings.NoteLabel.verticalInset),
            labelNote.leadingAnchor.constraint(equalTo: viewNote.leadingAnchor, constant: Paddings.NoteLabel.horizontalInset),

            labelNoteText.topAnchor.constraint(equalTo: labelNote.bottomAnchor, constant: Paddings.NoteLabel.horizontalInset),
            labelNoteText.leadingAnchor.constraint(equalTo: viewNote.leadingAnchor, constant: Paddings.NoteLabel.horizontalInset),
            labelNoteText.trailingAnchor.constraint(equalTo: viewNote.trailingAnchor, constant: -Paddings.NoteLabel.horizontalInset),
            labelNoteText.bottomAnchor.constraint(equalTo: viewNote.bottomAnchor, constant: -Paddings.NoteLabel.horizontalInset)
            
        ])
    }
    
    @objc private func buttonBackToWalletTapped(_ sender: UIButton) {
        presenter.buttonBackTapped()
    }
    
    @objc private func buttonDeleteTapped(_ sender: UIButton) {
        presenter.buttonDeleteTapped()
    }
    
    @objc private func buttonEditTapped(_ sender: UIButton) {
        presenter.buttonEditTapped()
    }
    
    
}

// MARK: - TransactionViewInput
extension TransactionViewController: TransactionViewInput {
    
    func reloadUI() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        labelData.text = formatter.string(from: presenter.currentModel().date)
        labelName.text = presenter.currentModel().title
        labelBalance.text = String(presenter.currentModel().change) + " " + presenter.currentModel().codeCurrency
        if presenter.currentModel().change < 0 {
            labelBalance.textColor = UIColor(named: "Amaranth Red")
        } else {
            labelBalance.textColor = UIColor(named: "Celadon")
        }
        labelNoteText.text = presenter.currentModel().note
        view.backgroundColor = UIColor(named: presenter.currentModel().colorName)
    }
}

// MARK: - UIScrollViewDelegate
extension TransactionViewController: UIScrollViewDelegate {
    
}
