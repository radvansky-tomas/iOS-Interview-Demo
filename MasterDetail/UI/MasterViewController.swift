//
//  MasterViewController.swift
//  MasterDetail
//
//  Created by Tomas Radvansky on 17/01/2017.
//  Copyright © 2017 Tomas Radvansky. All rights reserved.
//

import UIKit
import PullToRefresh

class MasterViewController: UITableViewController {
    let refresher = PullToRefresh()
    var detailViewController: DetailViewController? = nil
    var objects = [PostObject]()
    
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addPullToRefresh(refresher) {
            self.loadData(page:0)
        }
        
        loadData(page:0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        tableView.removePullToRefresh(tableView.topPullToRefresh!)
    }
    
    // MARK: Data Loading
    func loadData(page:Int)
    {
        APICommunicator.sharedInstance.getPosts(offset: page * DEFAULT_Limit, limit: DEFAULT_Limit) { (res:[PostObject]?, err:Error?) in
            if let error:Error = err
            {
                print(error.localizedDescription)
            }
            else if let posts:[PostObject] = res
            {
                if page == 0
                {
                    self.objects.removeAll()
                }
                self.objects.append(contentsOf: posts)
                self.currentPage = page
                self.tableView.reloadData()
            }
            self.tableView.endRefreshing(at: .top)
        }
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - UITableViewDelegate + UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let object = objects[indexPath.row]
        cell.textLabel?.text = object.title
        cell.detailTextLabel?.text = object.body
        return cell
    }
    
    // Infinity scrolling
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.dataSource!.tableView(tableView, numberOfRowsInSection: indexPath.section) - 1 {
            loadData(page: currentPage + 1)
        }
    }
    
}

