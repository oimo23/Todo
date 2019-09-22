//
//  ViewController.swift
//  Todo
//
//  Created by 伏貫祐樹 on 2019/09/22.
//  Copyright © 2019 yuki fushinuki. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var todoArray: [String] = ["ドアを修理する", "市役所に行く", "車を売る"]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    // MARK: - テーブルの作成
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoArray.count
    
    }
    
    // MARK: - 各セルの中身を定義
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = todoArray[indexPath.row]
        
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
        
        let action = UIAlertAction(title: "新規追加", style: .default) { (action) in
            // 新規追加を確認したあとの処理
            print("成功")
            
            self.todoArray.append(textField.text!)
            self.tableView.reloadData()
        }
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "新規Todoの内容を入力"
            textField = alertTextField
        }
        
        // alertにactionボタンを追加
        alert.addAction(action)
        
        // 上記の設定をもとに実際にアラートを出現させる
        present(alert, animated: true, completion: nil)
    }


}

