//
//  HomePresenter.swift
//  MyToDos
//
//  Created by Julia Gurbanova on 29.03.2024.
//

import Foundation

class HomePresenter {
    private weak var homeView: HomeViewDelegate?
    private var tasksListService: TasksListServiceProtocol!
    private var lists = [TasksListModel]()

    var numberOfTaskLists: Int {
        lists.count
    }

    init(homeView: HomeViewDelegate? = nil, tasksListService: TasksListServiceProtocol) {
        self.homeView = homeView
        self.tasksListService = tasksListService

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contextObjectsDidChange),
            name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
            object: CoreDataManager.shared.mainContext
        )
    }

    @objc func contextObjectsDidChange() {
        fetchTasksLists()
    }

    func fetchTasksLists() {
        lists = tasksListService.fetchLists()
        homeView?.reloadData()
    }

    func listAtIndex(_ index: Int) -> TasksListModel {
        lists[index]
    }

    func removeListAtIndex(_ index: Int) {
        let list = listAtIndex(index)
        tasksListService.deleteList(list)
        lists.remove(at: index)
    }
}
