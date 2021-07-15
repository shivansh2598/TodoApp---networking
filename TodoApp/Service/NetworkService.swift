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
    
    func getTodos(_ onSuccess : @escaping (Todos) -> (), _ onError : @escaping (String) -> ()){
        let url = URL(string: "\(URL_BASE)")!
        let task = session.dataTask(with: url) {(data, response, error) in
            
            DispatchQueue.main.async {
                //handling connection based error
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                //handling invalid data & response error
                guard let data = data ,let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do{
                    //handling data and api errors
                    if response.statusCode == 200 {
                        let items = try JSONDecoder().decode(Todos.self, from: data)
                        onSuccess(items)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError(err.message)
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func addTodos(todo : Todo, _ onSuccess : @escaping (Todos) -> (), _ onError : @escaping (String) -> ())
    {
        let url = URL(string: "\(URL_BASE)\(URL_ADD)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let body = try JSONEncoder().encode(todo)
            request.httpBody = body
            let task = session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    //handling connection based error
                    if let error = error {
                        onError(error.localizedDescription)
                        return
                    }
                    
                    //handling invalid data & response error
                    guard let data = data ,let response = response as? HTTPURLResponse else {
                        onError("Invalid data or response")
                        return
                    }
                    
                    do{
                        //handling data and api errors
                        if response.statusCode == 200 {
                            let items = try JSONDecoder().decode(Todos.self, from: data)
                            onSuccess(items)
                        } else {
                            let err = try JSONDecoder().decode(APIError.self, from: data)
                            onError(err.message)
                        }
                    } catch {
                        onError(error.localizedDescription)
                    }
                }
            }
            task.resume()
        } catch  {
            onError(error.localizedDescription)
        }
        
    }
}
