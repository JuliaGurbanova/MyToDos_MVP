//
//  TaskListViewTest.swift
//  MyToDosTests
//
//  Created by Julia Gurbanova on 29.03.2024.
//

import XCTest
@testable import MyToDos

final class TaskListViewTest: XCTestCase {
    var sut: TaskListView!
    var presenter: TaskListPresenter!
    var task: TaskModel!
    var taskList: TasksListModel!

    override func setUpWithError() throws {
        task = TaskModel(
            id: "67890-12345",
            title: "Test Task",
            icon: "test.icon",
            done: true,
            createdAt: Date()
        )
        taskList = TasksListModel(
            id: "12345-67890",
            title: "Test List",
            icon: "test.icon",
            tasks: [task],
            createdAt: Date()
        )
        sut = TaskListView()
        let mockTaskListService = MockTaskListService(lists: [taskList])
        let mockTaskService = MockTaskService(list: taskList)
        presenter = TaskListPresenter(
            taskListView: sut,
            tasksListModel: taskList,
            taskService: mockTaskService,
            tasksListService: mockTaskListService
        )
        sut.presenter = presenter
        presenter.fetchTasks()
        sut.reloadData()
    }

    override func tearDownWithError() throws {
        sut = nil
        presenter = nil
        super.tearDown()
    }

    func testViewLoaded_whenViewIsInstantiatedShouldBeComponents() {
        XCTAssertNotNil(sut.pageTitle)
        XCTAssertNotNil(sut.backButton)
        XCTAssertNotNil(sut.addTaskButton)
        XCTAssertNotNil(sut.emptyState)
        XCTAssertNotNil(sut.tableView)
    }

    func testButtonAction_whenAddTaskButtonIsTappedShouldBeCalledAddTaskAction() {
        let addTaskButton = sut.addTaskButton
        XCTAssertNotNil(addTaskButton, "UIButton does not exist.")

        guard let addListButtonAction = addTaskButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("No actions assigned for .touchUpInside")
            return
        }

        XCTAssertTrue(addListButtonAction.contains("addTaskAction"))
    }

    func testButtonAction_whenBackButtonIsTappedShouldBeCalledBackAction() {
        let backButton = sut.backButton
        XCTAssertNotNil(backButton, "UIButton does not exist.")

        guard let backButtonAction = backButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("No actions assigned for .touchUpInside")
            return
        }
        XCTAssertTrue(backButtonAction.contains("backAction"))
    }

    func testEmptyState_whenModelHasZeroTasksShouldBeEmptyState() {
        taskList.tasks = [TaskModel]()
        let mockTaskListService = MockTaskListService(lists: [taskList])
        let mockTaskService = MockTaskService(list: taskList)
        presenter = TaskListPresenter(
            taskListView: sut,
            tasksListModel: taskList,
            taskService: mockTaskService,
            tasksListService: mockTaskListService
        )
        sut.presenter = presenter
        presenter.fetchTasks()
        sut.reloadData()
        XCTAssertFalse(sut.emptyState.isHidden)
    }

    func testEmptyState_whenModelHasATaskShouldBeNoEmptyState() {
        XCTAssertTrue(sut.emptyState.isHidden)
    }

    func testTableView_whenModelHasATaskShouldBeOneRow() {
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }

    func testTableView_whenModelHasATaskShouldBeACellAtIndexPath() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
    }

    func testTableView_whenTaskIsDeletedShouldBeNoneOnModel() {
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView.dataSource?.tableView?(sut.tableView, commit: .delete, forRowAt: indexPath)
        XCTAssertEqual(sut.presenter.numberOfTasks, 0)
    }
}
