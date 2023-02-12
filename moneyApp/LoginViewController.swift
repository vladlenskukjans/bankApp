//
//  LoginViewController.swift
//  moneyApp
//
//  Created by Vladlens Kukjans on 11/02/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
   
    let m = UILabel()
    let r = UILabel()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Banky App"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 50, weight: .heavy)
        return label
    }()
    
    let appDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Your premium source for all things banking!"
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .medium)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        style()
        layout()
        
        
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
            
            appNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            appNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            appNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            appNameLabel.bottomAnchor.constraint(equalTo: appDescriptionLabel.topAnchor, constant: -25),
            
            appDescriptionLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 0),
            appDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            appDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            //appDescriptionLabel.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: -10),
            
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
    }
}
extension LoginViewController {
    
    @objc func signInTapped() {
        errorMessageLabel.isHidden = true
        login()
    }
    
    func login() {
        guard let name = userName, let password = userPassword else {
            assertionFailure("Username/Password shoul never be nil")
            return }
        
        if name.isEmpty || password.isEmpty {
            configureView(withMessage: "Username/Password cannot be empty")
            return
        }
        
        if name == "Vladlen" && password == "Welcome" {
            signButton.configuration?.showsActivityIndicator = true
        } else {
            configureView(withMessage: "Incorrect username/ password")
            
        }
    }
    
    func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    
}

