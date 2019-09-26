//
//  ViewController.swift
//  Todo
//
//  Created by 伏貫祐樹 on 2019/09/22.
//  Copyright © 2019 yuki fushinuki. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    private var todoRealmManager = TodoRealmManager()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    // MARK: - テーブルの作成
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.todoRealmManager.countTodos()
    
    }
    
    // MARK: - 各セルの中身を定義
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)

        let todos = self.todoRealmManager.fetchTodos()
        let todo  = todos[indexPath.row]
        
        cell.textLabel?.text = todo.text
        
        return cell
    }
    
    // MARK: - セルが選択されたとき
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let currentAccessoryType = tableView.cellForRow(at: indexPath)?.accessoryType
        
        if currentAccessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - 右上の＋ボタンが押されたとき
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()

        // ポップアップの内容を設定
        let alert = UIAlertController(title: "Todoを追加", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        let action = UIAlertAction(title: "新規追加", style: .default) { (action) in

            let todo  = TodoDataModel()
            todo.text = textField.text!
            
            self.todoRealmManager.addTodo(todo: todo)
            
            self.tableView.reloadData()
        }
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "新規Todoの内容を入力"
            textField = alertTextField
        }
        
        // alertにactionボタンを追加
        alert.addAction(action)
        alert.addAction(cancel)
        
        // 上記の設定をもとに実際にアラートを出現させる
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - 削除ボタン設定
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            self.todoRealmManager.deleteTodo(indexPath: indexPath)
            
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            
        }
    }


}

