//
//  TodoVC.swift
//  TodoApp
//
//  Created by Shivansh Sinha on 14/07/21.
//

import UIKit

class TodoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.shared.getTodos()
    }


}

