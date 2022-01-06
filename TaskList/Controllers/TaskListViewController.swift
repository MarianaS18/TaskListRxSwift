//
//  TaskListViewController.swift
//  TaskList
//
//  Created by Mariana Steblii on 06/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {
    // MARK: - IBOulet
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    private var tasksRelay = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    
    // MARK: - Public properties
    let disposeBag = DisposeBag()
    
    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let addTaskVC = navC.viewControllers.first as? AddTaskViewController else {
                  fatalError("AddTaskViewController not found")
              }
        
        addTaskVC.taskSubjectObservable
            .subscribe(onNext: { [unowned self] task in
                let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
                
                var existingTasks = self.tasksRelay.value
                existingTasks.append(task)
                self.tasksRelay.accept(existingTasks)
                
                self.filterTasks(by: priority)
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Private functions
    private func filterTasks(by priority: Priority?) {
        if priority == nil {
            filteredTasks = tasksRelay.value
            updateTableView()
        } else {
            tasksRelay.map { tasks in
                return tasks.filter { $0.priority == priority! }
            }.subscribe(onNext: { [weak self] tasks in
                self?.filteredTasks = tasks
                self?.updateTableView()
            }).disposed(by: disposeBag)
        }
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - IBActions
    @IBAction func priorityValueChanged(_ sender: Any) {
        let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
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
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TaskTableViewCell else {
            fatalError("TaskTableViewCell not found")
        }
        cell.titleLabel?.text = filteredTasks[indexPath.row].title
        return cell
    }
}
