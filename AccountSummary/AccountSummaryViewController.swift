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
    var isLoaded = false
    let refreshControl = UIRefreshControl()
   
    //Networking
    var profileManager: ProfileManageable = ProfileManager()
    
    //Error alert
    lazy var errorAlert: UIAlertController = {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }()
    
    
    
    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = appColor
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.identifier)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)
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
        setupRefreshControl()
        setupSkeletons()
        fetchData()
        
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
    
    
    private func setupSkeletons() {
           let row = Account.makeSkeleton()
           accounts = Array(repeating: row, count: 10)
           
         configureTableCell(with: accounts)
       }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension AccountSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accountCellViewModels.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard !accountCellViewModels.isEmpty,
//        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.identifier, for: indexPath) as? AccountSummaryCell else {  return UITableViewCell() }
//
//        let accounts = accountCellViewModels[indexPath.row]
//        cell.configure(with: accounts)
//
//        return cell
        
        guard !accountCellViewModels.isEmpty else { return UITableViewCell() }
               let account = accountCellViewModels[indexPath.row]

               if isLoaded {
                   let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.identifier, for: indexPath) as! AccountSummaryCell
                   cell.configure(with: account)
                   return cell
               }
               
               let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as! SkeletonCell
               return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
}

// MARK: - Networking
extension AccountSummaryViewController {
    private func fetchData() {
        let group = DispatchGroup()
        
        // Testing - random number selection
        let userId = String(Int.random(in: 1..<4))
        
        fetchProfile(group: group, userId: userId)
        fetchAccounts(group: group, userId: userId)
        
        group.notify(queue: .main) {
            self.reloadView()
        }
    }
    
    private func fetchProfile(group: DispatchGroup, userId: String) {
        group.enter()
        profileManager.fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                self.displayError(error)
            }
            group.leave()
        }
    }
    
    private func fetchAccounts(group: DispatchGroup, userId: String) {
        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                self.displayError(error)
            }
            group.leave()
        }
    }
    
private func reloadView() {
    self.tableView.refreshControl?.endRefreshing()
    guard let profile = self.profile else { return }
    
    self.isLoaded = true
    self.configureTableHeaderView(with: profile)
    self.configureTableCell(with: self.accounts)
    self.tableView.reloadData()
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
    
    private func displayError(_ error: NetworkError) {
        let titleAndMessage = titleAndMessage(for: error)
        self.showErrorAlert(title: titleAndMessage.0, message: titleAndMessage.1)
        
    }
    private func titleAndMessage(for error: NetworkError) -> (String, String) {
        let title: String
        let message: String
        switch error {
        case .serverError:
            title = "Server Error"
            message = "Ensure you are connected to the internet. Please try again"
        case .decodingError:
            title = "Decoding Error"
            message = "We could not process your request. Please try again."
        }
        return (title, message)
    }
    
    private func showErrorAlert(title: String, message: String) {
        errorAlert.title = title
        errorAlert.message = message
        present(errorAlert, animated: true)
    }
}
// Actions

extension AccountSummaryViewController {
    @objc func refreshContent() {
        reset()
        setupSkeletons()
        tableView.reloadData()
        fetchData()
    }
    
    private func reset() {
        profile = nil
        accounts = []
        isLoaded = false
    }
}
//MARK: Just For UNit testing
extension AccountSummaryViewController {
    func titleAndMessageForTesting(for error: NetworkError) -> (String, String) {
        return titleAndMessage(for: error)
    }
    
    func forceFetchProfile() {
        fetchProfile(group: DispatchGroup(), userId: "1")
    }
}
