//
//  AddViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/2/24.
//

import UIKit


protocol AddTodoDelegate:AnyObject {
    func addTodo(data:Todo)
}

class AddViewController: BaseViewController {

    let mainView = AddView()
    weak var delegate:AddTodoDelegate?
    var priorty:Int = 2
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        setGesture()
    }

    private func configureNavigationItem(){
        let add = UIBarButtonItem(title:"추가", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        let cancel = UIBarButtonItem(title:"취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.title = "새로운 할일"
        navigationItem.leftBarButtonItem = cancel
        navigationItem.rightBarButtonItem = add
    }

    @objc func saveButtonTapped(){
        guard let text = mainView.titleTextField.text else { return }
        if !text.trimmingCharacters(in: .whitespaces).isEmpty{
            let data = Todo(title: text, content: mainView.contentTextView.text, registerDate: mainView.deadlineButtonView.contentLabel.text, memoTag:mainView.tagButtonView.contentLabel.text, priority: priorty)
            delegate?.addTodo(data: data)
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
    
    
    func setGesture(){
        let tapGesture1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(deadlineButtonTapped))
        let tapGesture2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tagButtonTapped))
        let tapGesture3: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(priorityButtonTapped))
        mainView.deadlineButtonView.addGestureRecognizer(tapGesture1)
        mainView.tagButtonView.addGestureRecognizer(tapGesture2)
        mainView.priorityButtonView.addGestureRecognizer(tapGesture3)
    }
    
    @objc func deadlineButtonTapped(){
        let vc = DeadlineViewController()
        vc.deadLine = { value in
            self.mainView.deadlineButtonView.contentLabel.text = value
        }
        present(vc, animated: true)
    }
    
    @objc func tagButtonTapped(){
        let vc = TagViewController()
        vc.tagValue = { value in
            self.mainView.tagButtonView.contentLabel.text = value
        }
        present(vc, animated: true)
    }
    
    @objc func priorityButtonTapped(){
        let vc = PriorityViewController()
        vc.priorityValue = { value in
            switch value{
            case 0:
                self.mainView.priorityButtonView.contentLabel.backgroundColor = .red
                self.priorty = 0
            case 1:
                self.mainView.priorityButtonView.contentLabel.backgroundColor = .yellow
                self.priorty = 1
            case 2:
                self.mainView.priorityButtonView.contentLabel.backgroundColor = .brown
                self.priorty = 2
            default:
                self.mainView.priorityButtonView.contentLabel.backgroundColor = .brown
                self.priorty = 0
            }
        }
        present(vc, animated: true)
    }
}
