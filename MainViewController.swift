//
//  MainViewController.swift
//  moneyApp
//
//  Created by Vladlens Kukjans on 13/02/2023.
//

import UIKit

class MainViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "foo"
        navigationController?.navigationBar.tintColor = .systemRed
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
        generateVC()
        
    }
    
    private func generateVC() {
        viewControllers = [
            
    configureTabBarController(viewController: AccountSummaryVC(), title: "Summary", image: UIImage(systemName: "list.dash.header.rectangle")),
    configureTabBarController(viewController: MoveMoneyVC(), title: "Move Money", image: UIImage(systemName: "arrow.left.arrow.right")),
    configureTabBarController(viewController: MoreVC(), title: "More", image: UIImage(systemName: "ellipsis.circle"))
        ]
    }
    
    private func configureTabBarController(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
       // tabBar.tintColor = .systemBackground
        tabBar.unselectedItemTintColor = .systemRed
        tabBar.isTranslucent = false
        return viewController
    }
    
   
}
    
class AccountSummaryVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
    }
}


class MoveMoneyVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
    }
}


class MoreVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
    }
}

