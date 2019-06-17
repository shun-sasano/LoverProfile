//
//  StartViewController.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/04/28.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit
import RealmSwift

class StartViewController: UIViewController {

    @IBOutlet weak var nameInputLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var startDateInputLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        nameInputLabel.text = NSLocalizedString("startNameLabel.text", comment: "")
        nameTextField.placeholder = NSLocalizedString("startNameField.placeholder", comment: "")
        startDateInputLabel.text = NSLocalizedString("startDateLabel.text", comment: "")
        startDateInputLabel.sizeToFit()
        
        startButton.layer.cornerRadius = 6
        startButton.layer.masksToBounds = true
    }

    @IBAction func actionStart(_ sender: Any) {
        guard let name = nameTextField.text else { return }
        let profile = Profile()
        profile.name = name
        profile.startDate = startDatePicker.date
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        let realm = try! Realm(configuration: config)
        try! realm.write {
            realm.deleteAll()
            realm.add(profile)
        }
        let mainStartVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "isFinishedFirstStart")
        userDefaults.synchronize()
        present(mainStartVC!, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
