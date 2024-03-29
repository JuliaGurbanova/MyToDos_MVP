//
//  AddListViewControllerTest.swift
//  MyToDosTests
//
//  Created by Julia Gurbanova on 24.03.2024.
//

import XCTest
@testable import MyToDos

final class AddListViewControllerTest: XCTestCase {
    var sut: AddListViewController!
    var navigationController: MockNavigationController!

    override func setUpWithError() throws {
        sut = AddListViewController()
        navigationController = MockNavigationController(rootViewController: UIViewController())
        navigationController.pushViewController(sut, animated: false)
        navigationController.vcIsPushed = false
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
        super.tearDown()
    }

    func testPopVC_whenBackActionIsCalledThenPopHomeCalled() {
        sut.navigateBack()
        XCTAssertTrue(navigationController.vcIsPopped)
    }
}
