//
//  TagViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

final class TagViewController: BaseViewController {

    let mainView = TagView()
    
    var tagValue:((String) -> Void)?
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tagValue?(mainView.textField.text ?? "")
    }
    
    @objc func backButtonTapped(){
        dismiss(animated: true)
    }

}
