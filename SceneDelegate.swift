//
//  SceneDelegate.swift
//  moneyApp
//
//  Created by Vladlens Kukjans on 11/02/2023.
//

import UIKit

let appColor: UIColor = .systemTeal

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
  

    let loginViewController = LoginViewController()
    let onboardingContainerVC = OnboardingContainerViewController()
    let dummyViewController = DummyVc()
    let mainViewController = MainViewController()
    let accountSummaryViewController = AccountSummaryViewController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        onboardingContainerVC.delegate = self
        loginViewController.delegate = self
        dummyViewController.logoutDelegate = self
        window?.backgroundColor = .systemBackground
        window?.rootViewController =  accountSummaryViewController
        mainViewController.selectedIndex = 1
        // window?.rootViewController = OnboardingContainerViewController()
        window?.makeKeyAndVisible()
    }
}
extension SceneDelegate {
    func setRootViewControllerSmoothTransition(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else { return }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.7, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

extension SceneDelegate: LoginViewControllerDelegate {
    func didLogIn() {
        if LocalState.hasOnboarded {
            setRootViewControllerSmoothTransition(dummyViewController)
        } else {
            setRootViewControllerSmoothTransition(onboardingContainerVC)
        }
    }
}
  extension SceneDelegate: OnboardingContainerViewControllerDelegate {
      func didFinishOnboarding() {
          LocalState.hasOnboarded = true
        setRootViewControllerSmoothTransition(dummyViewController)

      }
}

extension SceneDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewControllerSmoothTransition(loginViewController)
    }
}
