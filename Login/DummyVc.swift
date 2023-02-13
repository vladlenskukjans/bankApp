//
//  DummyVc.swift
//  moneyApp
//
//  Created by Vladlens Kukjans on 12/02/2023.
//

import UIKit

class DummyVc: UIViewController {
    
    weak var logoutDelegate: LogoutDelegate?
    
    
    let stackView = UIStackView()
    let label = UILabel()
    let logOutButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        style()
        layout()
        
    }
}
//Setup
extension DummyVc {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.setTitle("Logout", for: .normal)
        logOutButton.configuration = .filled()
        logOutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
        
    }
    func layout() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logOutButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
    }
}
// Actions
extension DummyVc {
    @objc func logoutButtonTapped() {
        logoutDelegate?.didLogout()
    }
}
