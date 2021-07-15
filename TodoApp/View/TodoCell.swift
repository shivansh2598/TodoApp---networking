//
//  TodoCell.swift
//  TodoApp
//
//  Created by Shivansh Sinha on 14/07/21.
//

import UIKit

class TodoCell: UITableViewCell {
    
    @IBOutlet weak var itemLbl : UILabel!
    @IBOutlet weak var priorityView : UIView!
    
    func updateCell(todo : Todo)
    {
        itemLbl.text = todo.item
        switch todo.priority {
        case 0:
            priorityView.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
            break
        case 1:
            priorityView.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            break
        case 2:
            priorityView.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            break
        default:
            priorityView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }

}
