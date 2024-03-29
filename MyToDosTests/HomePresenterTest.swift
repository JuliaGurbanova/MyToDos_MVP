//
//  HomePresenterTest.swift
//  MyToDosTests
//
//  Created by Julia Gurbanova on 29.03.2024.
//

import XCTest
@testable import MyToDos

final class HomePresenterTest: XCTestCase {
    var sut: HomePresenter!
    let taskList = TasksListModel(
        id: "12345-67890",
        title: "Test List",
        icon: "test.icon",
        tasks: [TaskModel](),
        createdAt: Date()
    )

    override func setUpWithError() throws {
        let mockTaskListService = MockTaskListService(lists: [taskList])
        sut = HomePresenter(tasksListService: mockTaskListService)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testFetchLists_whenAddedOneListShouldContainModelOneList() {
        sut.fetchTasksLists()
        XCTAssertEqual(sut.numberOfTaskLists, 1)
    }

    func testListAtIndex_whenAddedOneListShouldReturnOneListAtIndexZero() {
        sut.fetchTasksLists()
        XCTAssertNotNil(sut.listAtIndex(0))
    }

    func testRemoveListAtIndex_whenAddedOneListShouldBeEmptyModelOnDeleteList() {
        sut.fetchTasksLists()
        sut.removeListAtIndex(0)
        XCTAssertEqual(sut.numberOfTaskLists, 0)
    }
}
