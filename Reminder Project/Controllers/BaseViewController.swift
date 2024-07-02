//
//  BaseViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/2/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureHierarchy()
        configureLayout()
        configureView()
    }
     
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {}
    
    
    
    func showAlert(title: String,message: String?, buttonTitle: String, handler: @escaping (() -> Void)) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: buttonTitle, style: .default) { _ in
            handler()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(button)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
     
}
