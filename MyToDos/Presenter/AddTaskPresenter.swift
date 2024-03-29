//
//  AddTaskPresenter.swift
//  MyToDos
//
//  Created by Julia Gurbanova on 29.03.2024.
//

import Foundation

class AddTaskPresenter {
    private var addTaskView: AddTaskViewDelegate?
    private var tasksListModel: TasksListModel!
    private var taskService: TaskServiceProtocol!
    private(set) var task: TaskModel!

    init(addTaskView: AddTaskViewDelegate? = nil, tasksListModel: TasksListModel, taskService: TaskServiceProtocol) {
        self.addTaskView = addTaskView
        self.tasksListModel = tasksListModel
        self.taskService = taskService
        self.task = TaskModel(
            id: ProcessInfo().globallyUniqueString,
            icon: "checkmark.seal.fill",
            done: false,
            createdAt: Date()
        )
    }

    func setTaskIcon(_ icon: String) {
        task.icon = icon
    }

    func addTaskWithTitle(_ title: String) {
        task.title = title
        taskService.saveTask(task, in: tasksListModel)
        addTaskView?.addedTask()
    }
}
