//
//  AddTaskPresenterTest.swift
//  MyToDosTests
//
//  Created by Julia Gurbanova on 29.03.2024.
//

import XCTest
@testable import MyToDos

final class AddTaskPresenterTest: XCTestCase {
    var sut: AddTaskPresenter!

    override func setUpWithError() throws {
        let taskList = TasksListModel(
            id: "12345-67890",
            title: "Test List",
            icon: "test.icon",
            tasks: [TaskModel](),
            createdAt: Date()
        )
        let mockTaskService = MockTaskService(list: taskList)
        sut = AddTaskPresenter(tasksListModel: taskList, taskService: mockTaskService)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testAddIcon_whenAddedIconShouldContainObjectIcon() {
        sut.setTaskIcon("test.icon")
        XCTAssertEqual(sut.task.icon, "test.icon")
    }

    func testAddTitle_whenAddedTitleShouldContainObjectTitle() {
        sut.addTaskWithTitle("Test Task")
        XCTAssertEqual(sut.task.title, "Test Task")
    }
}
