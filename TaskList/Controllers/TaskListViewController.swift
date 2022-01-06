//
//  TaskListViewController.swift
//  TaskList
//
//  Created by Mariana Steblii on 06/01/2022.
//

import UIKit

class TaskListViewController: UIViewController {
    // MARK: - IBOulet
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - UITableViewDelegate
extension TaskListViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension TaskListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        return cell
    }
    
    
}
