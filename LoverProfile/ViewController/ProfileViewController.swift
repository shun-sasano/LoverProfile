//
//  ViewController.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/04/06.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundImageView: HeaderView!
    @IBOutlet weak var iconImageView: IconView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var associateDurationLabel: UILabel!
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cushionView: UIView!
    
    @IBOutlet weak var editButton: UIButton!
    var profile: Profile?
    var realm: Realm!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        realm = try? Realm(configuration: config)
        profile = realm.object(ofType: Profile.self, forPrimaryKey: 0) ?? profile
        setupViews()
        setupAutolayout()
    }
    
    func setupViews() {
        iconImageView.layer.cornerRadius = 75
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 3
        iconImageView.layer.borderColor = UIColor.ex.framePink.cgColor
        iconImageView.backgroundColor = UIColor.ex.mainPink
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.imageView?.image = #imageLiteral(resourceName: "miuFTHG1743_TP_V4")
        
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.backgroundColor = UIColor.ex.mainPink
        backgroundImageView.imageView?.image = #imageLiteral(resourceName: "Mizuho18116019_TP_V")
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = 80
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "profileTableViewCell")
        scrollView.delegate = self
        
        associateDurationLabel.font = UIFont.boldSystemFont(ofSize: 16)
        associateDurationLabel.textColor = UIColor.ex.black54
    }
    
    func setupAutolayout() {
        scrollView.snp.makeConstraints{ (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-(tabBarController?.tabBar.frame.height)!)
        }
        
        contentView.snp.makeConstraints{ (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(Device.screenWidth())
            make.height.equalTo(Device.screenHeight()).priority(999)
        }
        
        backgroundImageView.snp.makeConstraints{ (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        iconImageView.snp.makeConstraints{ (make) in
            make.top.equalTo(backgroundImageView.snp.top).offset(120)
            make.width.height.equalTo(150)
            make.left.equalToSuperview().offset(30)
        }
        
        nameLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(21)
        }
        
        editButton.snp.makeConstraints{ (make) in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(20)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        associateDurationLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(21)
        }
        
        openButton.snp.makeConstraints{ (make) in
            make.bottom.equalToSuperview().offset(-140)
            make.right.equalToSuperview().offset(-40)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        // tableviewはcontentsizeで設定するため、viewDidAppearで設定する
        //        tableView.snp.makeConstraints{ (make) in
        //            make.top.equalTo(associateDurationLabel.snp.bottom).offset(40)
        //            make.height.equalTo(tableView.contentSize.height)
        //            make.left.right.equalToSuperview()
        //        }
        
        cushionView.snp.makeConstraints{ (make) in
            make.top.equalTo(tableView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        //       遷移に入った段階でここの記述が適用される self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //        self.navigationController?.navigationBar.shadowImage = UIImage()
        //        self.navigationController?.navigationBar.isTranslucent = true
        //        self.navigationController?.view.backgroundColor = .clear
        //        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.scrollView.contentInsetAdjustmentBehavior = .never
        setupNavigationBar()
        profile = realm.object(ofType: Profile.self, forPrimaryKey: 0) ?? profile
        tableView.reloadData()
        nameLabel.text = profile?.name
        if let iconImagePath = profile?.iconImagePath,
            let iconImage = UIImage(contentsOfFile: UIImageView.fileInDocumentsDirectory(filename: iconImagePath).path) {
            iconImageView.imageView?.image = iconImage
            iconImageView.noImageLabel?.isHidden = true
        } else {
            iconImageView.noImageLabel?.isHidden = false
        }
        if let backgroundImagePath = profile?.backgroundImagePath,
            let backgroundImage = UIImage(contentsOfFile: UIImageView.fileInDocumentsDirectory(filename: backgroundImagePath).path){
            backgroundImageView.imageView?.image = backgroundImage
            backgroundImageView.noImageLabel?.isHidden = true
        } else {
            backgroundImageView.noImageLabel?.isHidden = false
        }
        setupAssociateDurationLabel()
    }
    
    func setupAssociateDurationLabel() {
        associateDurationLabel.text = ""
        if let startDate = profile?.startDate {
            let calendar = Calendar.current
            let associateDurationDateComponents = calendar.dateComponents([.year, .month, .day], from: startDate, to: Date())
            var dateDicArray: [[String: String]] = []
            if let year = associateDurationDateComponents.year, year != 0 {
                dateDicArray.append([LSEnum.year.text: "\(year.description)"])
            }
            if let month = associateDurationDateComponents.month, month != 0 {
                dateDicArray.append([LSEnum.month.text: "\(month.description)"])
            }
            if let day = associateDurationDateComponents.day, day != 0 {
                dateDicArray.append([LSEnum.day.text: "\(day.description)"])
            } else if dateDicArray.count == 0 {
                dateDicArray.append([LSEnum.day.text: "０"])
            }
            
            for dateDic in dateDicArray {
                
                associateDurationLabel.text = "\(String(describing: associateDurationLabel.text!))\(dateDic.values.first!)\(dateDic.keys.first!)"
            }
            let labelText = "\(LSEnum.durationOfAssociate.text)\(String(describing: associateDurationLabel.text!))"
            associateDurationLabel.text = labelText.applyingTransform(.fullwidthToHalfwidth, reverse: true)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupTableViewAutolayout()
        tableView.addBorderFullWidth(width: 1, color: UIColor.ex.black6, position: .top)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setupTableViewAutolayout() {
        print("profile?.items.count\(profile?.items.count ?? 0)")
        print("1tableView.contentSize.height\(tableView.contentSize.height)")
        tableView.snp.makeConstraints{ (make) in
            make.top.equalTo(associateDurationLabel.snp.bottom).offset(24)
            make.height.equalTo(tableView.contentSize.height)
            make.left.right.equalToSuperview()
        }
        print("2tableView.contentSize.height\(tableView.contentSize.height)")
        tableView.snp.remakeConstraints { (make) in
            make.top.equalTo(associateDurationLabel.snp.bottom).offset(24)
            make.height.equalTo(tableView.contentSize.height)
            make.left.right.equalToSuperview()
        }
        print("3tableView.contentSize.height\(tableView.contentSize.height)")
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileTableViewCell", for: indexPath) as! ProfileTableViewCell
        cell.titleLabel.text = profile?.items[indexPath.row].title
        cell.contentLabel.text = profile?.items[indexPath.row].content
        return cell
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: LSEnum.delete.text) { (action, index) -> Void in
            try! self.realm.write {
                
                // オブジェクトごと削除
                self.realm.delete((self.profile?.items[indexPath.row])!)
                
                // リレーションだけ消される？？
                //                profile?.items.remove(at: indexPath.row)
            }
            //            profile?.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        deleteButton.backgroundColor = UIColor.red
        setupTableViewAutolayout()
        return [deleteButton]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddItemViewController") as! AddItemViewController
        vc.index = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        backgroundImageView?.setParallaxEffectToHeaderView(scrollView)
    }
}
