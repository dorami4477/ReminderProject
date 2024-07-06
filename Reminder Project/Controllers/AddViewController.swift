//
//  AddViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/2/24.
//

import UIKit
import PhotosUI

protocol AddTodoDelegate:AnyObject {
    func addTodo(data:Todo)
}

final class AddViewController: BaseViewController {

    let mainView = AddView()
    weak var delegate:AddTodoDelegate?
    var priorty:Int = 2
    var deadLine:Int = GetDate.shared.todayInt
    let repository = TodoRepository()
    
    
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        setGesture()
        mainView.contentTextView.delegate = self
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
            let data = Todo(title: text, content: mainView.contentTextView.text, registerDate: deadLine, memoTag:mainView.tagButtonView.contentLabel.text, priority: priorty)
                delegate?.addTodo(data: data)
            if let image = mainView.imageView.image{
                ImageFileManager.shared.saveImageToDocument(image: image, filename: "\(data.id)")
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
    
    func setGesture(){
        let tapGesture1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(deadlineButtonTapped))
        let tapGesture2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tagButtonTapped))
        let tapGesture3: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(priorityButtonTapped))
        let tapGesture4: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageButtonTapped))
        mainView.deadlineButtonView.addGestureRecognizer(tapGesture1)
        mainView.tagButtonView.addGestureRecognizer(tapGesture2)
        mainView.priorityButtonView.addGestureRecognizer(tapGesture3)
        mainView.imageButtonView.addGestureRecognizer(tapGesture4)
    }
    //마감일뷰컨으로 이동
    @objc func deadlineButtonTapped(){
        let vc = DeadlineViewController()
        vc.selectedDate = deadLine
        vc.deadLine = { value in
            self.deadLine = value
            let stringValue = GetDate.shared.dateToString(value)
            self.mainView.deadlineButtonView.contentLabel.text = stringValue
        }
        present(vc, animated: true)
    }
    
    //태그뷰컨으로 이동
    @objc func tagButtonTapped(){
        let vc = TagViewController()
        vc.mainView.textField.text = self.mainView.tagButtonView.contentLabel.text
        vc.tagValue = { value in
            self.mainView.tagButtonView.contentLabel.text = value
        }
        present(vc, animated: true)
    }
    
    //우선순위뷰컨으로 이동
    @objc func priorityButtonTapped(){
        let vc = PriorityViewController()
        switch mainView.priorityButtonView.contentLabel.text{
        case "High":
            vc.mainView.segment.selectedSegmentIndex = 0
        case "Middle":
            vc.mainView.segment.selectedSegmentIndex = 1
        case "Low":
            vc.mainView.segment.selectedSegmentIndex = 2
        default:
            print("error")
        }
        vc.priorityValue = { value in
            switch value{
            case 0:
                self.mainView.priorityButtonView.contentLabel.text = "High"
                self.priorty = 0
            case 1:
                self.mainView.priorityButtonView.contentLabel.text = "Middle"
                self.priorty = 1
            case 2:
                self.mainView.priorityButtonView.contentLabel.text = "Low"
                self.priorty = 2
            default:
                self.mainView.priorityButtonView.contentLabel.text = "Low"
                self.priorty = 2
            }
        }
        present(vc, animated: true)
    }
    
    //이미지피커뷰컨 이동
    @objc func imageButtonTapped(){
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .any(of: [.screenshots, .images, .livePhotos])

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension AddViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self){
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.mainView.imageView.image = image as? UIImage
                }
            }
        }
    }
}

extension AddViewController: UITextViewDelegate {
   
   func textViewDidBeginEditing(_ textView: UITextView) {
       if textView.textColor == UIColor.lightGray {
           textView.text = nil
           textView.textColor = UIColor.white
       }
       
   }

   func textViewDidEndEditing(_ textView: UITextView) {
       if textView.text.isEmpty {
           textView.text = "메모를 입력하세요"
           textView.textColor = UIColor.lightGray
       }
   }
   
}
