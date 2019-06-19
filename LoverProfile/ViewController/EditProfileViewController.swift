//
//  EditProfileViewController.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/04/15.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageButton: ButtonWithBackground!
    @IBOutlet weak var iconImageButton: ButtonWithBackground!
    @IBOutlet weak var loverNameLabel: UILabel!
    @IBOutlet weak var loverNameTextField: UITextField!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var startDatePickerField: DatePickerTextField!
    
    var iconImagePath: String?
    var backgroundImagePath: String?
    
    enum ImageButtonEnum {
        case iconImageButton
        case backgroundImageButton
    }
    
    var currentPickerImageEnum: ImageButtonEnum?
    
    var profile: Profile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        guard let profile = realm.object(ofType: Profile.self, forPrimaryKey: 0) else { return }
        self.profile = profile
        if let iconImagePath = profile.iconImagePath, let iconImage = UIImage(contentsOfFile: iconImagePath) {
            iconImageButton.backgroundImageView?.image = iconImage
        }
        if let backgroundImagePath = profile.backgroundImagePath,
            let backgroundImage = UIImage(contentsOfFile: backgroundImagePath){
            backgroundImageButton.backgroundImageView?.image = backgroundImage
        }
        loverNameTextField.text = profile.name
        startDatePickerField.text = profile.startDate?.toStringWithCurrentLocale()
        
        setupViews()
        setupAutolayout()
    }
    
    func setupViews() {
        iconImageButton.button?.addTarget(self, action: #selector(EditProfileViewController.actionSetIcon(_:)), for: .touchUpInside)
        iconImageButton.button?.setTitle("恋人の画像を設定", for: .normal)
        iconImageButton.button?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        iconImageButton.button?.setImage(UIImage(named: "camera"), for: .normal)
        iconImageButton.button?.imageEdgeInsets = UIEdgeInsets(top: 25, left: 0, bottom: 65, right: 0)
        iconImageButton.button?.titleEdgeInsets = UIEdgeInsets(top: 40, left: -255, bottom: 0, right: 0)
        iconImageButton.backgroundColor = UIColor.ex.mainPink
        iconImageButton.layer.borderWidth = 3
        iconImageButton.layer.cornerRadius = 60
        iconImageButton.layer.borderColor = UIColor.ex.labelGrey.cgColor
        iconImageButton.layer.masksToBounds = true
        iconImageButton.backgroundImageView?.contentMode = .scaleAspectFill
        if let iconImagePath = profile.iconImagePath, let image = UIImage(contentsOfFile: UIImageView.fileInDocumentsDirectory(filename: iconImagePath).path) {
            iconImageButton.backgroundImageView?.image = image
        }
        
        backgroundImageButton.button?.addTarget(self, action: #selector(EditProfileViewController.actionSetBackgroundImage), for: .touchUpInside)
        backgroundImageButton.button?.setTitle("背景を設定", for: .normal)
        backgroundImageButton.button?.setImage(UIImage(named: "camera"), for: .normal)
        backgroundImageButton.button?.imageEdgeInsets = UIEdgeInsets(top: 85, left: 0, bottom: 85, right: 0)
        backgroundImageButton.button?.titleEdgeInsets = UIEdgeInsets(top: 0, left: -150, bottom: 0, right: 0)
        backgroundImageButton.backgroundColor = UIColor.ex.mainPink
        if let backgroundImagePath = profile.backgroundImagePath, let image = UIImage(contentsOfFile: UIImageView.fileInDocumentsDirectory(filename: backgroundImagePath).path)?.withRenderingMode(.alwaysOriginal) {
            backgroundImageButton.backgroundImageView?.image = image
        }
        
        loverNameLabel.text = "名前"
        loverNameLabel.textColor = UIColor.ex.labelGrey
        loverNameLabel.sizeToFit()
        
        loverNameTextField.borderStyle = .none
        loverNameTextField.font = UIFont.boldSystemFont(ofSize: 18)
        
        startLabel.text = "交際開始日"
        startLabel.textColor = UIColor.ex.labelGrey
        startLabel.sizeToFit()
    }
    
    func setupAutolayout() {
        backgroundImageButton.snp.makeConstraints{ (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(Device.screenHeight() / 4)
        }
        
        iconImageButton.snp.makeConstraints{ (make) in
            make.top.equalTo(backgroundImageButton.snp.top).offset(Device.screenHeight() / 4 - 60)
            make.width.height.equalTo(120)
            make.left.equalToSuperview().offset(30)
        }
        
        loverNameLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(iconImageButton.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.size.equalTo(loverNameLabel.frame.size)
        }
        
        loverNameTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(loverNameLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        startLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(loverNameTextField.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(30)
            make.size.equalTo(startLabel.frame.size)
        }
        
        startDatePickerField.snp.makeConstraints{ (make) in
            make.top.equalTo(startLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(44)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.setToolbarItems([createToolbarItems()], animated: true)
        navigationItem.rightBarButtonItem = createToolbarItems()
        navigationController?.navigationBar.tintColor = UIColor.ex.accent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func createToolbarItems() -> UIBarButtonItem {
        return UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(EditProfileViewController.save(_:)))
    }
    
    @objc func save(_ button: Any) {
        guard let loverName = loverNameTextField.text else { return }
        let realm = try! Realm()
        guard let profile = realm.object(ofType: Profile.self, forPrimaryKey: 0) else { return }
        try! realm.write {
            profile.name = loverName
            profile.startDate = startDatePickerField.text?.toDateFromString()
            if let iconImagePath = iconImagePath {
                profile.iconImagePath = iconImagePath
            }
            if let backgroundImagePath = backgroundImagePath {
                profile.backgroundImagePath = backgroundImagePath
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func actionSetBackgroundImage(_ sender: Any) {
        // カメラロールが利用可能か？
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            currentPickerImageEnum = ImageButtonEnum.backgroundImageButton
            // 写真を選ぶビュー
            let pickerView = UIImagePickerController()
            // 写真の選択元をカメラロールにする
            // 「.camera」にすればカメラを起動できる
            pickerView.sourceType = .photoLibrary
            // デリゲート
            pickerView.delegate = self
            // ビューに表示
            self.present(pickerView, animated: true)
        }
    }
    
    @objc func actionSetIcon(_ sender: Any) {
        // カメラロールが利用可能か？
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            currentPickerImageEnum = ImageButtonEnum.iconImageButton
            // 写真を選ぶビュー
            let pickerView = UIImagePickerController()
            // 写真の選択元をカメラロールにする
            // 「.camera」にすればカメラを起動できる
            pickerView.sourceType = .photoLibrary
            // デリゲート
            pickerView.delegate = self
            // ビューに表示
            self.present(pickerView, animated: true)
        }
    }
    
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 写真を選んだ後に呼ばれる処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 選択した写真を取得する
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        // ビューに表示する
        guard let _currentPickerImageEnum = currentPickerImageEnum else {
            return
        }
        switch _currentPickerImageEnum {
        case .iconImageButton:
            let pathUrl = info[UIImagePickerController.InfoKey.imageURL] as! NSURL
            iconImagePath = pathUrl.path?.components(separatedBy: "tmp/")[1]
            // DocumentディレクトリのfileURLを取得
            // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
            let path = UIImageView.fileInDocumentsDirectory(filename: iconImagePath!)
            print("-------------------")
            print("書き込むファイルのパス: \(String(describing: path))")
            print("-------------------")
            try! image.pngData()?.write(to: path)
            
            
            iconImageButton.backgroundImageView?.image = image.withRenderingMode(.alwaysOriginal)
            iconImageButton.subviews[1].contentMode = .scaleAspectFill
        case .backgroundImageButton:
            let pathUrl = info[UIImagePickerController.InfoKey.imageURL] as! NSURL
            backgroundImagePath = pathUrl.path?.components(separatedBy: "tmp/")[1]
            // DocumentディレクトリのfileURLを取得
            // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
            let path = UIImageView.fileInDocumentsDirectory(filename: backgroundImagePath!)
            print("-------------------")
            print("書き込むファイルのパス: \(String(describing: path))")
            print("-------------------")
            try! image.pngData()?.write(to: path)
            backgroundImageButton.backgroundImageView?.image = image.withRenderingMode(.alwaysOriginal)
            backgroundImageButton.subviews[1].contentMode = .scaleAspectFill
        }
        currentPickerImageEnum = nil
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
}
