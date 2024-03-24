//
//  MockNavigationController.swift
//  MyToDosTests
//
//  Created by Julia Gurbanova on 24.03.2024.
//

import UIKit

class MockNavigationController: UINavigationController {
    var vcIsPushed = false
    var vcIsPopped = false

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        vcIsPushed = true
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        vcIsPopped = true
        return viewControllers.first
    }
}
