//
//  AddTaskViewTest.swift
//  MyToDosTests
//
//  Created by Julia Gurbanova on 29.03.2024.
//

import XCTest
@testable import MyToDos

final class AddTaskViewTest: XCTestCase {
    var sut: AddTaskView!
    var presenter: AddTaskPresenter!

    override func setUpWithError() throws {
        sut = AddTaskView()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testViewLoaded_whenViewIsInstantiatedShouldBeComponents() {
        XCTAssertNotNil(sut.pageTitle)
        XCTAssertNotNil(sut.backButton)
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertNotNil(sut.titleTextField)
        XCTAssertNotNil(sut.iconLabel)
        XCTAssertNotNil(sut.iconSelectorView)
        XCTAssertNotNil(sut.addTaskButton)
    }

    func testButtonAction_whenAddTaskButtonIsTappedShouldBeCalledAddTaskAction() {
        let addTaskButton = sut.addTaskButton
        XCTAssertNotNil(addTaskButton, "UIButton does not exist.")

        guard let addTaskButtonAction = addTaskButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("No actions assigned for .touchUpInside")
            return
        }

        XCTAssertTrue(addTaskButtonAction.contains("addTaskAction"))
    }

    func testTextField_whenTextFieldIsCreatedShouldBeEmpty() {
        XCTAssertEqual(sut.titleTextField.text, "")
    }

    func testTextField_whenTextFieldHasTextShouldBeCreatedTask() {
        let taskList = TasksListModel(
            id: "12345-67890",
            title: "Test Task",
            icon: "test.icon",
            tasks: [TaskModel](),
            createdAt: Date()
        )
        let mockTaskService = MockTaskService(list: taskList)
        presenter = AddTaskPresenter(tasksListModel: taskList, taskService: mockTaskService)
        sut.presenter = presenter
        sut.titleTextField.text = "Test title"
        sut.addTaskAction()
        XCTAssertEqual(presenter.task.title, "Test title")
    }
}
