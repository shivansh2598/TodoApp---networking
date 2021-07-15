//
//  TodoVC.swift
//  TodoApp
//
//  Created by Shivansh Sinha on 14/07/21.
//

import UIKit

class TodoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var todoTable : UITableView!
    @IBOutlet weak var todoItem: UITextField!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    
    var todos : [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTable.delegate = self
        todoTable.dataSource = self
        
        getTodo()
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
    
    @IBAction func addTodoItemBtnWasPressed(_ sender: Any) {
        guard let todoDescription = todoItem.text else {return}
        let newTodo = Todo(item: todoDescription, priority: prioritySegment.selectedSegmentIndex)
        
        NetworkService.shared.addTodos(todo: newTodo) { (todos) in
            self.todoItem.text = ""
            self.todos = todos.items
            self.todoTable.reloadData()
        } _: { (errMsg) in
            debugPrint(errMsg)
        }
    }
}

