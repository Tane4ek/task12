//
//  WalletListPresenterTest.swift
//  Task_12Tests
//
//  Created by a19510883 on 23.11.2021.
//

import XCTest

@testable import Task_12

class MockView: WalletListViewInput {
    func reloadUI() {
    }
}

class WalletListPresenterTest: XCTestCase {
    
    var view: MockView!
    var wallet:  [Wallet]!
    var presenter: WalletListPresenter!
    
    override func setUpWithError() throws {
        view = MockView()
        wallet = [Wallet(id: UUID(), name: "Baz", balance: 0, dateOfLastChange: Date.now, codeCurrency: "", colorName: "")]
        presenter = WalletListPresenter()
        presenter.models = wallet
    }
    
    override func tearDownWithError() throws {
        view = nil
        wallet = nil
        presenter = nil
    }
    
    func testModuleIsNotNil() {
        XCTAssertNotNil(view, "view is not nil")
        XCTAssertNotNil(wallet, "wallet is not nil")
        XCTAssertNotNil(presenter, "presenter is not nil")
    }
}
