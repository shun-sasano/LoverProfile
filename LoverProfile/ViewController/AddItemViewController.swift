//
//  AddItemViewController.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/05/01.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit
import RealmSwift

class AddItemViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: PlaceHolderTextView!
    
    var index: Int?
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutolayout()
        setupViews()
        realm = try! Realm()
        if let index = index {
            guard let profile = realm.object(ofType: Profile.self, forPrimaryKey: 0) else { return }
            let items = profile.items[index]
            titleField.text = items.title
            contentField.text = items.content
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    func setupNavigationBar() {
       self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = true
        
        // 意外とnavigationBar.backgroundColorじゃないね
        navigationController?.navigationBar.barTintColor = UIColor.ex.mainPink
        navigationController?.setToolbarItems([createToolbarItems()], animated: true)
        navigationItem.rightBarButtonItem = createToolbarItems()
    }
    
    func createToolbarItems() -> UIBarButtonItem {
        return UIBarButtonItem(title: LSEnum.save.text, style: .plain, target: self, action: #selector(AddItemViewController.save(_:)))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func save(_ button: Any) {
        guard let title = titleField.text else { return }
        guard let content = contentField.text else { return }
        if title == "" || content == "" {
            return
        }
        guard let profile = realm.object(ofType: Profile.self, forPrimaryKey: 0) else { return }
        if let index = index {
            // 編集
            try! realm.write {
                profile.items[index].title = title
                profile.items[index].content = content
            }
        } else {
            // 作成
            let item = ProfileItem(title: title, content: content)
            try! realm.write {
                profile.items.append(item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func setupViews() {
        titleField.font = UIFont.boldSystemFont(ofSize: 18)
        titleField.placeholder = LSEnum.title.text
        titleField.addBorderBottom(height: 3, color: UIColor.ex.mainPink)
        
        contentField.placeHolder = LSEnum.content.text
    }
    
    func setupAutolayout() {
        titleField.snp.makeConstraints{ (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
        
        contentField.snp.makeConstraints{ (make) in
            make.top.equalTo(titleField.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview()
        }
    }

}
