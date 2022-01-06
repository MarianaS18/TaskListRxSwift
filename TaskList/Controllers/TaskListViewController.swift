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
            .subscribe(onNext: { task in
                
                
                var existingTasks = self.tasksRelay.value
                existingTasks.append(task)
                self.tasksRelay.accept(existingTasks)
            }).disposed(by: disposeBag)
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
