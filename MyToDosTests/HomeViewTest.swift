//
//  HomeViewTest.swift
//  MyToDosTests
//
//  Created by Julia Gurbanova on 24.03.2024.
//

import XCTest
@testable import MyToDos

final class HomeViewTest: XCTestCase {
    var sut: HomeView!
    var presenter: HomePresenter!
    let taskList = TasksListModel(
        id: "12345-67890",
        title: "Test List",
        icon: "test.icon",
        tasks: [TaskModel](),
        createdAt: Date()
    )

    override func setUpWithError() throws {
        sut = HomeView()
        let mockTaskListService = MockTaskListService(lists: [taskList])
        presenter = HomePresenter(homeView: sut, tasksListService: mockTaskListService)
        sut.presenter = presenter
        presenter.fetchTasksLists()
        sut.reloadData()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testViewLoadedWhenViewIsInstantiatedShouldBeComponents() {
        XCTAssertNotNil(sut.pageTitle)
        XCTAssertNotNil(sut.addListButton)
        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.emptyState)
    }

    func testEmptyState_whenModelHasAListShouldBeNoEmptyState() {
        XCTAssertTrue(sut.emptyState.isHidden)
    }

    func testButtonAction_whenAddListButtonIsTappedShouldBeCalledAddListAction() {
        let addListButton = sut.addListButton
        XCTAssertNotNil(addListButton, "UIButton does not exist")

        guard let addListButtonAction = addListButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("No actions assigned for .touchUpInside")
            return
        }

        XCTAssertTrue(addListButtonAction.contains("addListAction"))
    }

    func testTableView_whenModelHasZeroListShouldBeEmptyState() {
        let mockTaskListService = MockTaskListService(lists: [TasksListModel]())
        presenter = HomePresenter(homeView: sut, tasksListService: mockTaskListService)
        sut.presenter = presenter
        presenter.fetchTasksLists()
        sut.reloadData()
        XCTAssertFalse(sut.emptyState.isHidden)
    }

    func testTableView_whenModelHasAListShouldBeOneRow() {
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }

    func testTableView_whenModelHasAListShouldBeACellAtIndexPath() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }

    func testTableView_whenListIsDeletedShouldBeNoneOnModel() {
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView.dataSource?.tableView?(sut.tableView, commit: .delete, forRowAt: indexPath)
        XCTAssertEqual(sut.presenter.numberOfTaskLists, 0)
    }
}
