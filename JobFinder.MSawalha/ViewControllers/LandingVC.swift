//
//  LandingVC.swift
//  JobFinder.MSawalha
//
//  Created by apple on 3/30/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class LandingVC: UIViewController{
    //MARK:- Variables
    let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate var providersJobs: ProvidersJobs? {
        didSet {
            tableView.reloadData()
        }
    }
    var filteredJobs = [ConfigurableJob]()
    fileprivate var jobs: [ConfigurableJob]{
        switch provider {
        case .gov:
            return providersJobs?.gov ?? []
        case .git:
            return providersJobs?.git ?? []
        default:
            return []
        }
    }
    var provider  = ApiProvider.git {
        didSet {
            fetch(using: provider)
        }
    }
    lazy var segments = UISegmentedControl()
    lazy var utils = ViewControllerUtils() // used to display activity indicator
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: .valueChanged)
        refreshControl.tintColor = .blue
        return refreshControl
    }()
    //MARK:- Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        fetch(using: provider)
    }
    //MARK: private functions.
    private func prepareUI() {
        //segment
        segments = UISegmentedControl(items: ApiProvider.segments)
        segments.selectedSegmentIndex = 0
        // Set up Frame and SegmentedControl
        let frame = UIScreen.main.bounds
        segments.frame = CGRect(x: frame.maxX + 10, y:frame.minY + 50,
                                width: frame.width - 20,  height:frame.height*0.05)
        // Style the Segmented Control
        segments.layer.cornerRadius = 5.0  // Don't let background bleed
        segments.backgroundColor = .white
        segments.tintColor = .blue
        segments.addTarget(self, action: #selector(handleSegment(_:)), for: .valueChanged)
        // Add this custom Segmented Control to our view
        self.tableView.tableHeaderView = segments // could be added out of the tableView, to achieve a sticky segment no matter what scrolled
        //tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.tableView.addSubview(refreshControl)
        tableView.register(JobCell.self)
        //View controller
        title = "Find me a Job"
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Jobs"
        navigationItem.searchController = searchController
        definesPresentationContext = true

    }
    @objc func handleSegment(_ sender: UISegmentedControl){
        provider = ApiProvider.init(rawValue: 1 << sender.selectedSegmentIndex)
    }
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing() 
        fetch(using: provider)
    }
}
//MARK: UITableView Delegate & DataSource
extension LandingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredJobs.count
        }
        return jobs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: JobCell = tableView.dequeueReusableCell(at: indexPath)
        (isFiltering()) ? (cell.configure(with: filteredJobs[indexPath.row])) : (cell.configure(with: jobs[indexPath.row]))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Utility.open([jobs[indexPath.row].companyURL ?? ""])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//MARK: API
extension LandingVC {
    private func fetch(using provider: ApiProvider) {
        utils.showActivityIndicator(in: view)
        let gateway = JobFinderGatewayImplementation(apiClient: self.apiClient)
        gateway.fetch(service: FetchService(provider: provider)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let val):
                guard let value = val else { return }//unrwapping value returned, TODO: handle Decode Error.
                self.providersJobs = value
                self.utils.hideActivityIndicator(from: self.view)
            case .failure(let error): print(error) // TODO: Alert user what happend.
            }
        }
    }
}

//MARK: Search Controller:-
extension LandingVC: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
extension LandingVC {
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredJobs = jobs.filter({( job : ConfigurableJob) -> Bool in
            return job.jobTitle.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }

}
