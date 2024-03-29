//
//  AddTaskView.swift
//  MyToDos
//
//  Created by Julia Gurbanova on 22.03.2024.
//

import UIKit

protocol AddTaskViewControllerDelegate: AnyObject {
    func addedTask()
}

protocol AddTaskViewDelegate: AnyObject {
    func addedTask()
}

class AddTaskView: UIView {
    private(set) var backButton = BackButton()
    private(set) var pageTitle = PageLabel(title: "Add Task")
    private(set) var titleLabel = UILabel(frame: .zero)
    private(set) var titleTextField = UITextField()
    private(set) var iconLabel = UILabel(frame: .zero)
    private(set) var iconSelectorView = IconSelectorView(frame: .zero, iconColor: .mainCoral)
    private(set) var addTaskButton = MainButton(title: "Add Task", color: .mainCoral)

    var presenter: AddTaskPresenter!

    weak var delegate: AddTaskViewControllerDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        configurePageTitleLabel()
        configureTitleLabel()
        configureTitleTextField()
        configureIconLabel()
        configureAddTaskButton()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddTaskView {
    func configurePageTitleLabel() {
        addSubview(pageTitle)

        NSLayoutConstraint.activate([
            pageTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageTitle.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            pageTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Title"
        titleLabel.font = .systemFont(ofSize: 21, weight: .light)
        titleLabel.textColor = .grayText
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            titleLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
    }

    func configureTitleTextField() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.textColor = .grayText
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Add task", attributes: [NSAttributedString.Key.foregroundColor: UIColor.grayBackground])
        addSubview(titleTextField)

        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            titleTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configureIconLabel() {
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.text = "Icon"
        iconLabel.font = .systemFont(ofSize: 21, weight: .light)
        iconLabel.textColor = .grayText
        addSubview(iconLabel)

        NSLayoutConstraint.activate([
            iconLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            iconLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            iconLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
    }

    func configureAddTaskButton() {
        addTaskButton.addTarget(self, action: #selector(addTaskAction), for: .touchUpInside)
        addSubview(addTaskButton)

        NSLayoutConstraint.activate([
            addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addTaskButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            addTaskButton.widthAnchor.constraint(equalToConstant: 150),
            addTaskButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    @objc func addTaskAction() {
        guard titleTextField.hasText else { return }
        presenter.addTaskWithTitle(titleTextField.text!)
    }

    func configureCollectionView() {
        iconSelectorView.translatesAutoresizingMaskIntoConstraints = false
        iconSelectorView.delegate = self
        addSubview(iconSelectorView)

        NSLayoutConstraint.activate([
            iconSelectorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconSelectorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            iconSelectorView.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 10),
            iconSelectorView.bottomAnchor.constraint(equalTo: addTaskButton.topAnchor, constant: -20)
        ])
    }
}

extension AddTaskView: IconSelectorViewDelegate {
    func selectedIcon(_ icon: String) {
        presenter.setTaskIcon(icon)
    }
}

extension AddTaskView: AddTaskViewDelegate {
    func addedTask() {
        delegate?.addedTask()
    }
}
