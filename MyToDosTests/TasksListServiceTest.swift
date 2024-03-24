//
//  TasksListServiceTest.swift
//  MyToDosTests
//
//  Created by Julia Gurbanova on 24.03.2024.
//

import XCTest
import CoreData
@testable import MyToDos

final class TasksListServiceTest: XCTestCase {
    var sut: TasksListServiceProtocol!
    var list: TasksListModel!


    override func setUpWithError() throws {
        sut = TasksListService(coreDataManager: InMemoryCoreDataManager())
        list = TasksListModel(
            id: "12345-67890",
            title: "Test List",
            icon: "test.icon",
            tasks: [TaskModel](),
            createdAt: Date()
        )
    }

    override func tearDownWithError() throws {
        sut = nil
        list = nil
        super.tearDown()
    }

    func testSaveOnDB_whenSavesAListShouldBeOneOnDatabase() {
        sut.saveTasksList(list)
        XCTAssertEqual(sut.fetchLists().count, 1)
    }

    func testSaveOnDB_whenSavesAListShouldBeOneWithGivenIDOnDatabase() {
        sut.saveTasksList(list)
        XCTAssertNotNil(sut.fetchListWithId("12345-67890"))
    }

    func testDeleteOnDB_whenSavesAListAndThenDeletedShouldBeNoneOnDatabase() {
        sut.saveTasksList(list)
        XCTAssertNotNil(sut.fetchListWithId("12345-67890"))
        sut.deleteList(list)
        XCTAssertEqual(sut.fetchLists().count, 0)
    }
}
