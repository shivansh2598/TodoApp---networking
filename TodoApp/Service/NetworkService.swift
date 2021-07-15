//
//  NetworkService.swift
//  TodoApp
//
//  Created by Shivansh Sinha on 15/07/21.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    let URL_BASE = "http://localhost:3003"
    let URL_ADD = "/Add"
    let session = URLSession(configuration: .default)
    
    func getTodos(){
        let url = URL(string: "\(URL_BASE)")!
        let task = session.dataTask(with: url) { (data, response, error) in
            
            //handling connection based error
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            //handling invalid data & response error
            guard let _ = data ,let response = response as? HTTPURLResponse else {
                debugPrint("Invalid data or response")
                return
            }
            
            //handling data and api errors
            if response.statusCode == 200 {
                
            } else {
                
            }
        }
        task.resume()
    }
    
    func addTodos(todo : Todo)
    {
        
    }
}
