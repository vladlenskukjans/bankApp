//
//  AccountSummaryViewController.swift
//  moneyApp
//
//  Created by Vladlens Kukjans on 17/02/2023.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    var names = [
        "Vladlen",
        "Valentin",
        "Tiffany",
        "Eric",
        "Sveta"
    ]
    
    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
     
        return tableView
        
    }()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame.size = view.bounds.size
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       
        setupConstraints()
        setUpHeaderView()
        
    }
    
    
    func setUpHeaderView() {
        let header = AccountSummaryHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 145))
        header.backgroundColor = .systemRed
        tableView.tableHeaderView = header
    }
    
}

extension AccountSummaryViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
        
        
        
        
        
        ])
    }
}




extension AccountSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
     
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
