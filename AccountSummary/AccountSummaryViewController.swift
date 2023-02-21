//
//  AccountSummaryViewController.swift
//  moneyApp
//
//  Created by Vladlens Kukjans on 17/02/2023.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    
    //Request Model
    var profile: Profile?
    var accounts: [Account] = []
    
  
        //ViewModel
    var headerViewModel = AccountSummaryHeaderView.ViewModelHeader(welcomeMessage: "Welcome", name: "", date: Date())
    var accountCellViewModels: [AccountSummaryCell.ViewModel] = []
    
    //Components
    var headerView = AccountSummaryHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 145))
    
    let refreshControl = UIRefreshControl()
    
    
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
        setupRefreshControl()
    }
    
    
  private func setUpHeaderView() {
        headerView.backgroundColor = appColor
        tableView.tableHeaderView = headerView
    }
    
    private func setupRefreshControl() {
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshContent() {
        fetchData()
    }
    
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension AccountSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accountCellViewModels.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountCellViewModels.isEmpty,
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.identifier, for: indexPath) as? AccountSummaryCell else {  return UITableViewCell() }
       
        let accounts = accountCellViewModels[indexPath.row]
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
// Networking
extension AccountSummaryViewController {
    private func fetchData() {
        let group = DispatchGroup()
        
        // testing - for retching different accounts,to refresh pull buttin
        let userId = String(Int.random(in: 1..<4))
        
        group.enter()
        fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                self.configureTableHeaderView(with: profile)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
                self.configureTableCell(with: accounts)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModelHeader(welcomeMessage: "Good Afternoon", name: profile.firstName, date: Date())
        
        headerView.configure(viewModel: vm)
    }
    
    private func configureTableCell(with: [Account]) {
        accountCellViewModels = accounts.map {
            AccountSummaryCell.ViewModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)
        }
       
    }
    
}
