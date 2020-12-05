//
//  SearchController.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 11/9/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import UIKit

private let reuseIdentifer = "UserCell"

class SearchController : UITableViewController{
    
    //MARK : Properties
   private var users = [User]()
   private let searchController = UISearchController(searchResultsController: nil)
   private var filteredUsers = [User]()
    
    private var inSearchMode : Bool {
        return searchController.isActive && !(searchController.searchBar.text!.isEmpty)
    }
    
    //MARK : Lifecycle
    
    override func viewDidLoad() {
        configureSearchController()
        super.viewDidLoad()
        configureTableView()
        fetchUsers()
    }
    
    //MARK : Helpers
    
    func configureTableView()
    {
        view.backgroundColor = .white
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifer)
        tableView.rowHeight = 64
        
    }
    
    func configureSearchController()
    {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    
    //MARK : - API
    
    func fetchUsers()
    {
        UserService.fetchUsers { (users) in
            print("DEBUG: USERS \(users)")
            self.users = users
            self.tableView.reloadData()
        }
    }
}


 //MARK : UITableViewDataSource
extension SearchController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! UserCell
    
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.viewModel = UserCellViewModel(user: user)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredUsers.count : users.count
    }
}

//MARK : UITableViewDelegate
extension SearchController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        let controller  = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
//MARK : UISearchResultsUpdating
extension SearchController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return}
        filteredUsers = users.filter({$0.username.contains(searchText) || $0.fullname.lowercased().contains(searchText)})
        
        
        self.tableView.reloadData()
        
        
    }
}
