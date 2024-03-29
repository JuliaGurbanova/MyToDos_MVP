//
//  TaskListPresenterTest.swift
//  MyToDosTests
//
//  Created by Julia Gurbanova on 29.03.2024.
//

import XCTest
@testable import MyToDos

final class TaskListPresenterTest: XCTestCase {
    var sut: TaskListPresenter!
    var task: TaskModel!
    var taskList: TasksListModel!

    override func setUpWithError() throws {
        task = TaskModel(id: "67890-12345",
                         title: "Test Task",
                         icon: "test.icon",
                         done: true,
                         createdAt: Date())
        taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [task],
                                  createdAt: Date())
        let mockTaskListService = MockTaskListService(lists: [taskList])
        let mockTaskService = MockTaskService(list: taskList)
        sut = TaskListPresenter(tasksListModel: taskList,
                                 taskService: mockTaskService,
                                 tasksListService: mockTaskListService)
        sut.fetchTasks()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testPageTitle_whenModelHasTitleShouldBePageTitle() {
        XCTAssertEqual(sut.pageTitle, "Test List")
    }

    func testNumberOfTasks_whenModelHasOneTaskShouldBeOneNumberOfTasks() {
        XCTAssertEqual(sut.numberOfTasks, 1)
    }

    func testTaskAtIndex_whenModelHasOneTaskShouldReturnOneTaskAtIndexZero() {
        XCTAssertNotNil(sut.taskAtIndex(0))
    }

    func testRemoveTaskAtIndex_whenModelHasOneTaskShouldBeEmptyModelOnDeleteTask() {
        sut.removeTaskAtIndex(0)
        XCTAssertEqual(sut.numberOfTasks, 0)
    }
}
