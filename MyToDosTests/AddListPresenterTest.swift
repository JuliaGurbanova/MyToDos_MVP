//
//  AddListPresenterTest.swift
//  MyToDosTests
//
//  Created by Julia Gurbanova on 29.03.2024.
//

import XCTest
@testable import MyToDos

final class AddListPresenterTest: XCTestCase {
    var sut: AddListPresenter!
    let mockTaskListService = MockTaskListService(lists: [TasksListModel]())

    override func setUpWithError() throws {
        sut = AddListPresenter(tasksListService: mockTaskListService)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testAddIcon_whenAddedIconShouldContainObjectIcon() {
        sut.setListIcon("test.icon")
        XCTAssertEqual(sut.list.icon, "test.icon")
    }

    func testAddTitle_whenAddedTitleShouldContainObjectTitle() {
        sut.addListWithTitle("Test List")
        XCTAssertEqual(sut.list.title, "Test List")
        XCTAssertEqual(mockTaskListService.fetchLists().first?.title, "Test List")
    }
}
