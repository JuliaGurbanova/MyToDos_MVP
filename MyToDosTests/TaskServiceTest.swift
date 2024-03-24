//
//  TaskServiceTest.swift
//  MyToDosTests
//
//  Created by Julia Gurbanova on 24.03.2024.
//

import XCTest
import CoreData
@testable import MyToDos

final class TaskServiceTest: XCTestCase {
    var sut: TaskServiceProtocol!
    var taskListService: TasksListServiceProtocol!
    var list: TasksListModel!
    var task: TaskModel!

    override func setUpWithError() throws {
        let inMemoryCoreDataManager = InMemoryCoreDataManager()
        sut = TaskService(coreDataManager: inMemoryCoreDataManager)
        taskListService = TasksListService(coreDataManager: inMemoryCoreDataManager)
        list = TasksListModel(
            id: "12345-67890",
            title: "Test List",
            icon: "test.icon",
            tasks: [TaskModel](),
            createdAt: Date()
        )
        task = TaskModel(
            id: "12345-67890",
            title: "Test Task",
            icon: "test.icon",
            done: false,
            createdAt: Date()
        )
        taskListService.saveTasksList(list)
    }

    override func tearDownWithError() throws {
        sut = nil
        list = nil
        task = nil
        taskListService = nil
        super.tearDown()
    }

    func testSaveOnDB_whenSavesATaskShouldBeOneOnDatabase() {
        sut.saveTask(task, in: list)
        XCTAssertEqual(sut.fetchTasksForList(list).count, 1)
    }

    func testUpdateOnDB_whenSavesATaskAndThenUpdatedShouldBeUpdatedOnDatabase() {
        sut.saveTask(task, in: list)
        task.done = true
        sut.updateTask(task)
        XCTAssertEqual(sut.fetchTasksForList(list).first?.done, true)
    }

    func testDeleteOnDB_whenSavesATaskAndThenDeletedShouldBeNoneOnDatabase() {
        sut.saveTask(task, in: list)
        XCTAssertEqual(sut.fetchTasksForList(list).count, 1)
        sut.deleteTask(task)
        XCTAssertEqual(sut.fetchTasksForList(list).count, 0)
    }
}
