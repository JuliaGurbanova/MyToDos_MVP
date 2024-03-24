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
    var tasksListService: MockTaskListService!
    var taskService: MockTaskService!
    let list = TasksListModel(
        id: ProcessInfo().globallyUniqueString,
        title: "Test title",
        icon: "test.icon",
        tasks: [TaskModel](),
        createdAt: Date()
    )

    override func setUpWithError() throws {
        tasksListService = MockTaskListService(lists: [list])
        taskService = MockTaskService(list: list)
        sut = HomeViewController(tasksListService: tasksListService, taskService: taskService)
        navigationController = MockNavigationController(rootViewController: UIViewController())
        navigationController.pushViewController(sut, animated: false)
        navigationController.vcIsPushed = false
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
        taskService = nil
        super.tearDown()
    }

    func testDeleteList_whenDeletedActionIsCalledShouldBeNoneOnDatabase() {
        sut.deleteList(list)
        XCTAssertEqual(tasksListService.fetchLists().count, 0)
    }

    func testPushVC_whenAddListIsCalledThenPushAddListVCCalled() {
        sut.addListAction()
        XCTAssertTrue(navigationController.vcIsPushed)
    }

    func testPushVC_whenTaskListIsCalledThenPushTaskListVCCalled() {
        sut.selectedList(TasksListModel())
        XCTAssertTrue(navigationController.vcIsPushed)
    }

}
