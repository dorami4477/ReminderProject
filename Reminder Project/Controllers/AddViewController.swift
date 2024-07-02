//
//  AddViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/2/24.
//

import UIKit
import RealmSwift

class AddViewController: BaseViewController {

    let mainView = AddView()
    let realm = try! Realm()
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
    }

    private func configureNavigationItem(){
        let add = UIBarButtonItem(title:"추가", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        let cancel = UIBarButtonItem(title:"취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.title = "새로운 할일"
        navigationItem.leftBarButtonItem = cancel
        navigationItem.rightBarButtonItem = add
        view.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00)
    }

    @objc func saveButtonTapped(){
        guard let text = mainView.titleTextField.text else { return }
        if !text.trimmingCharacters(in: .whitespaces).isEmpty{
            let data = Todo(title: text, content: mainView.contentTextView.text, registerDate: Date())
            try! self.realm.write {
                self.realm.add(data)
            }
            dismiss(animated: true)
        }else{
            showAlert(title: "제목을 입력해주세요.", message: nil, buttonTitle: "확인") {
                print("확인")
            }
        }
    }
    
    @objc func cancelButtonTapped(){
        dismiss(animated: true)
    }
    
}
