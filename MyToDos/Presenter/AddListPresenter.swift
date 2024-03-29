//
//  AddListPresenter.swift
//  MyToDos
//
//  Created by Julia Gurbanova on 29.03.2024.
//

import Foundation

class AddListPresenter {
    private weak var addListView: AddListViewDelegate?
    private var tasksListService: TasksListServiceProtocol!
    private(set) var list: TasksListModel!

    init(addListView: AddListViewDelegate? = nil, tasksListService: TasksListServiceProtocol) {
        self.addListView = addListView
        self.tasksListService = tasksListService
        self.list = TasksListModel(
            id: ProcessInfo().globallyUniqueString,
            icon: "checkmark.seal.fill",
            createdAt: Date()
        )
    }

    func setListIcon(_ icon: String) {
        list.icon = icon
    }

    func addListWithTitle(_ title: String) {
        list.title = title
        tasksListService.saveTasksList(list)
        addListView?.backToHome()
    }
}
