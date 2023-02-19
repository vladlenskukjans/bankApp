//
//  AccountSummaryViewController.swift
//  moneyApp
//
//  Created by Vladlens Kukjans on 17/02/2023.
//

import UIKit

class AccountSummaryViewController: UIViewController {
  
    var accounts: [AccountSummaryCell.ViewModel] = []
    
    
    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = appColor
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.identifier)
        tableView.tableFooterView = UIView()
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
                setUpHeaderView()
                fetchData()
    }
    
    
    func setUpHeaderView() {
        let header = AccountSummaryHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 145))
        header.backgroundColor = appColor
        tableView.tableHeaderView = header
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension AccountSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accounts.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accounts.isEmpty,
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.identifier, for: indexPath) as? AccountSummaryCell else {  return UITableViewCell() }
       
        let accounts = accounts[indexPath.row]
        cell.configure(with: accounts)
       
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
}

//MARK: - Fetching
extension AccountSummaryViewController {
    
    private func fetchData() {
        let savings = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "Basic Savings", balance: 929466.23)
        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Visa Credit Card", balance: 412.83)
        let masterCard = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Student MasterCard", balance: 50.88)
        let investment1 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Tax-Free Saver", balance: 2000.00)
        let investment2 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "First House", balance: 1500.00)
        let chequing = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "No-Fee All-In Chequing", balance: 17562.44)
        
        accounts.append(savings)
        accounts.append(visa)
        accounts.append(masterCard)
        accounts.append(investment1)
        accounts.append(investment2)
        accounts.append(chequing)
    }
    
}
