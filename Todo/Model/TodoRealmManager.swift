//
//  TodoRealmManager.swift
//  Todo
//
//  Created by 伏貫祐樹 on 2019/09/26.
//  Copyright © 2019 yuki fushinuki. All rights reserved.
//

import Foundation
import RealmSwift

class TodoRealmManager {
    
    let realm = try! Realm()
    
    func fetchTodos() -> Results<TodoDataModel> {
        
        return realm.objects(TodoDataModel.self)
    
    }
    
    func countTodos() -> Int {
        let todos = realm.objects(TodoDataModel.self)
        return todos.count
    }
    
    func addTodo(todo: TodoDataModel) {
        
        try! self.realm.write {
            self.realm.add(todo)
        }
        
    }
    
    func deleteTodo(indexPath: IndexPath) {
        
        let todos = realm.objects(TodoDataModel.self)
        let todo = todos[indexPath.row]
        
        try! realm.write {
            realm.delete(todo)
        }
        
    }
    
}
