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
    var tasksListService: MockTaskListService!
    let list = TasksListModel(
        id: ProcessInfo().globallyUniqueString,
        title: "Test title",
        icon: "test.icon",
        tasks: [TaskModel](),
        createdAt: Date()
    )

    override func setUpWithError() throws {
        tasksListService = MockTaskListService(lists: [TasksListModel]())
        sut = AddListViewController(tasksListService: tasksListService)
        navigationController = MockNavigationController(rootViewController: UIViewController())
        navigationController.pushViewController(sut, animated: false)
        navigationController.vcIsPushed = false
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
        tasksListService = nil
        super.tearDown()
    }

    func testListAddition_whenAddedAListShouldBeOneOnDatabase() {
        sut.addList(list)
        XCTAssertEqual(tasksListService.fetchLists().count, 1)
    }

    func testPopVC_whenAddListIsCalledThenPopHomeCalled() {
        sut.addList(list)
        XCTAssertTrue(navigationController.vcIsPopped)
    }

    func testPopVC_whenBackActionIsCalledThenPopHomeCalled() {
        sut.navigateBack()
        XCTAssertTrue(navigationController.vcIsPopped)
    }
}
