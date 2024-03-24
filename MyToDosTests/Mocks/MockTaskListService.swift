//
//  MockTaskListService.swift
//  MyToDosTests
//
//  Created by Julia Gurbanova on 24.03.2024.
//

import XCTest
@testable import MyToDos

class MockTaskListService: TasksListServiceProtocol {
    private var lists: [TasksListModel] = [TasksListModel]()

    required init(coreDataManager: CoreDataManager) { }

    convenience init(lists: [TasksListModel]) {
        self.init(coreDataManager: CoreDataManager.shared)
        self.lists = lists
    }

    func saveTasksList(_ list: TasksListModel) {
        lists.append(list)
    }

    func fetchLists() -> [TasksListModel] {
        return lists
    }

    func fetchListWithId(_ id: String) -> TasksListModel? {
        return lists.filter { $0.id == id }.first
    }

    func deleteList(_ list: TasksListModel) {
        lists = lists.filter { $0.id != list.id }
    }
}
