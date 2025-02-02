//
//  AddTaskViewController.swift
//  MyToDos
//
//  Created by Julia Gurbanova on 22.03.2024.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    private var addTaskView = AddTaskView()
    private var tasksListModel: TasksListModel!

    init(tasksListModel: TasksListModel) {
        super.init(nibName: nil, bundle: nil)
        self.tasksListModel = tasksListModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        setupAddTaskView()
    }

    private func setupAddTaskView() {
        let presenter = AddTaskPresenter(addTaskView: addTaskView,
                                         tasksListModel: tasksListModel,
                                         taskService: TaskService())
        addTaskView.delegate = self
        addTaskView.presenter = presenter
        self.view = addTaskView
    }
}

extension AddTaskViewController: AddTaskViewControllerDelegate {
    func addedTask() {
        dismiss(animated: true)
    }
}
