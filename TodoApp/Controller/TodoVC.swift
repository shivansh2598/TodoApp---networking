//
//  TodoVC.swift
//  TodoApp
//
//  Created by Shivansh Sinha on 14/07/21.
//

import UIKit

class TodoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var todoTable : UITableView!
    var todos : [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTable.delegate = self
        todoTable.dataSource = self
        
        getTodo()
        
        NetworkService.shared.addTodos(todo: Todo(item: "Test", priority: 2)) { (todos) in
            self.todos = todos.items
            self.todoTable.reloadData()
        } _: { (errMsg) in
            debugPrint(errMsg)
        }

    }
    
    func getTodo()
    {
        NetworkService.shared.getTodos { (todos) in
            self.todos = todos.items
            self.todoTable.reloadData()
        } _: { (errMsg) in
            debugPrint(errMsg)
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "todoItem") as? TodoCell {
            cell.updateCell(todo: todos[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
}

