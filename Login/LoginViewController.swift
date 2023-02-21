//
//  LoginViewController.swift
//  moneyApp
//
//  Created by Vladlens Kukjans on 11/02/2023.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLogIn() 
}

protocol LogoutDelegate: AnyObject {
   func didLogout()
}

class LoginViewController: UIViewController {
    
    weak var delegate: LoginViewControllerDelegate?

    let appNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Banky App"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 50, weight: .heavy)
        label.alpha = 0
        return label
    }()
    
    let appDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.text = "Your premium source for all things banking!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.alpha = 0
        return label
    }()
    
    
    let loginView = LoginView()
    let signButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    var userName: String?  {
        return loginView.userNameTextField.text
    }
    
    var userPassword: String? {
        return loginView.passwordTextField.text
    }
    
    // Animation - appName
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    var titleLeadingAnchor: NSLayoutConstraint?
    
    //Animation - DescriptionLabel
    var subtitleLeadingEdgeOnScreen: CGFloat = 8
    var subtitleLeadingEdgeOffScreen: CGFloat = -1000
    var subtitleLeadingAnchor: NSLayoutConstraint?
    
        override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        style()
        layout()
           
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        signButton.configuration?.showsActivityIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
      
    }
    
}
extension LoginViewController {
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signButton.translatesAutoresizingMaskIntoConstraints = false
        signButton.configuration = .filled()
        signButton.setTitle("Sign In", for: .normal)
        signButton.configuration?.imagePadding = 8 // for indicator spacing
        signButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.isHidden = true
        errorMessageLabel.text = "Error Message"
    }
    
    private func layout() {
        view.addSubview(appNameLabel)
        view.addSubview(appDescriptionLabel)
        view.addSubview(loginView)
        view.addSubview(signButton)
        view.addSubview(errorMessageLabel)
        
        
        NSLayoutConstraint.activate([
            ///Animated Constraints
            appNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
           // appNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            appNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
           // appNameLabel.bottomAnchor.constraint(equalTo: appDescriptionLabel.topAnchor, constant: -25),
          
            /// Animated Constraints
            appDescriptionLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 0),
           // appDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            appDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            
            signButton.topAnchor.constraint(equalTo: loginView.bottomAnchor,constant: 15),
            signButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            signButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            
            errorMessageLabel.topAnchor.constraint(equalTo: signButton.bottomAnchor,constant: 15),
            errorMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            errorMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
        ])
        ///set animation off the screen
        titleLeadingAnchor = appNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        ///set animation off the screen
        subtitleLeadingAnchor = appDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: subtitleLeadingEdgeOffScreen)
        subtitleLeadingAnchor?.isActive = true
    }
 
}
extension LoginViewController {
    
    @objc func signInTapped() {
        errorMessageLabel.isHidden = true
        login()
    }
    
    func login() {
        guard let name = userName, let password = userPassword else {
            assertionFailure("Username/Password should never be nil")
            return }
//        
//        if name.isEmpty || password.isEmpty {
//            configureView(withMessage: "Username/Password cannot be empty")
//            return
//        }
//        
        if name == "" && password == "" {
            signButton.configuration?.showsActivityIndicator = true
            delegate?.didLogIn()
        } else {
            configureView(withMessage: "Incorrect username/ password")
        }
   }
    
    func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        shakeButton()
    }
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        signButton.layer.add(animation, forKey: "shake")
    }
}

extension LoginViewController {
   
    private func animate() {
        let duration = 1.0
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator.startAnimation()
        
        let animator1 = UIViewPropertyAnimator(duration: duration + 0.5, curve: .easeInOut) {
            self.subtitleLeadingAnchor?.constant = self.subtitleLeadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        
        let animationAppLabelAlpha = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
            self.appNameLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animationAppLabelAlpha.startAnimation()
        
        let subtitleLabelAnimationAlpha = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.appDescriptionLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        subtitleLabelAnimationAlpha.startAnimation(afterDelay: 1.2)
   }
}


