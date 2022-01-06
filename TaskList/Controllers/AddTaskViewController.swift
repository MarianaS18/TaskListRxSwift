//
//  AddTaskViewController.swift
//  TaskList
//
//  Created by Mariana Steblii on 06/01/2022.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    
    // MARK: - Private properties
    private let taskSubject = PublishSubject<Task>()
    
    // MARK: - Public properties
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
    // MARK: - IBActions
    @IBAction func savedButtonPressed(_ sender: Any) {
        guard let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex),
              let title = titleTextField.text else {
                  return
              }
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        self.dismiss(animated: true, completion: nil)
    }
    
}
