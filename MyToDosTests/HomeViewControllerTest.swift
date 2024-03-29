//
//  HomeViewControllerTest.swift
//  MyToDosTests
//
//  Created by Julia Gurbanova on 24.03.2024.
//

import XCTest
@testable import MyToDos

final class HomeViewControllerTest: XCTestCase {
    var sut: HomeViewController!
    var navigationController: MockNavigationController!

    override func setUpWithError() throws {
        sut = HomeViewController()
        navigationController = MockNavigationController(rootViewController: UIViewController())
        navigationController.pushViewController(sut, animated: false)
        navigationController.vcIsPushed = false
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
        super.tearDown()
    }

    func testPushVC_whenAddListIsCalledThenPushAddListVCCalled() {
        sut.addList()
        XCTAssertTrue(navigationController.vcIsPushed)
    }

    func testPushVC_whenTaskListIsCalledThenPushTaskListVCCalled() {
        sut.selectedList(TasksListModel())
        XCTAssertTrue(navigationController.vcIsPushed)
    }

}
