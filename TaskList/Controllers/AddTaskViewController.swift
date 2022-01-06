//
//  AddTaskViewController.swift
//  TaskList
//
//  Created by Mariana Steblii on 06/01/2022.
//

import UIKit

class AddTaskViewController: UIViewController {
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBAction func savedButtonPressed(_ sender: Any) {
        guard let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex),
              let title = titleTextField.text else {
                  return
              }
        let task = Task(title: title, priority: priority)
    }
    
}
