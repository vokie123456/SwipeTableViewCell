//
//  ViewController.swift
//  SwipeCell
//
//  Created by Adrian Gulyashki on 25.11.18.
//  Copyright © 2018 Adrian Gulyashki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let exampleCellIdentifier = "ExampleCell"
    var examples = ["Animation enabled", "Animation disabled", "Swipe to execute", "Custom action views"]
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: exampleCellIdentifier)
    }
    
    func viewControllerForExample(at index: Int) -> UIViewController {
        switch index {
        case 0:
            return AnimationEnabledExampleViewController(animationsEnabled: true)
        case 1:
            return AnimationEnabledExampleViewController(animationsEnabled: false)
        case 2:
            return SwipeToExecuteExampleController()
        default:
            return UIViewController()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: exampleCellIdentifier) else {
            return UITableViewCell()
        }

        cell.textLabel?.text = examples[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exampleController = viewControllerForExample(at: indexPath.row)
        navigationController?.pushViewController(exampleController, animated: true)
    }
}
