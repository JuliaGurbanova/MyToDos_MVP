//
//  TaskListPresenter.swift
//  MyToDos
//
//  Created by Julia Gurbanova on 29.03.2024.
//

import Foundation

class TaskListPresenter {
    private weak var taskListView: TaskListViewDelegate?
    private var tasksListModel: TasksListModel!
    private var taskService: TaskServiceProtocol!
    private var tasksListService: TasksListServiceProtocol!
    private var tasks = [TaskModel]()

    var pageTitle: String {
        tasksListModel.title
    }

    var numberOfTasks: Int {
        tasks.count
    }

    init(taskListView: TaskListViewDelegate? = nil, tasksListModel: TasksListModel, taskService: TaskServiceProtocol, tasksListService: TasksListServiceProtocol) {
        self.taskListView = taskListView
        self.tasksListModel = tasksListModel
        self.taskService = taskService
        self.tasksListService = tasksListService

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contextObjectsDidChange),
            name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
            object: CoreDataManager.shared.mainContext
        )
    }

    @objc func contextObjectsDidChange() {
        fetchTasks()
    }
    
    func taskAtIndex(_ index: Int) -> TaskModel {
        tasks[index]
    }

    func setupView() {
        taskListView?.setPageTitle(pageTitle)
        fetchTasks()
    }

    func fetchTasks() {
        guard let list = tasksListService.fetchListWithId(tasksListModel.id) else { return }
        tasksListModel = list
        tasks = tasksListModel.tasks.sorted { $0.createdAt > $1.createdAt }
        taskListView?.reloadData()
    }
}

extension TaskListPresenter {
    func updateTask(_ task: TaskModel) {
        taskService.updateTask(task)
    }

    func removeTaskAtIndex(_ index: Int) {
        let task = taskAtIndex(index)
        taskService.deleteTask(task)
        tasks.remove(at: index)
    }
}
