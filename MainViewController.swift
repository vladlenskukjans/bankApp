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

        generateVC()
        setStatusBarAppearance()
       
    }
    
    func setStatusBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = .systemBackground
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
       // navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .close)
    }
    
    private func generateVC() {
        viewControllers = [
            
    configureTabBarController(viewController: AccountSummaryViewController(), title: "Summary", image: UIImage(systemName: "list.dash.header.rectangle")),
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

