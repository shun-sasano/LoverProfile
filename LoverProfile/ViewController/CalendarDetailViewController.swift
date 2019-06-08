//
//  CalendarDetailViewController.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/04/17.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift
import Lottie
import SwiftDate

class CalendarDetailViewController: UIViewController {
    
    var date: Date!
    var schedule: Schedule?
    var profile: Profile!
    var isDate: Bool = false
    
    var eventArray: [Event] = []
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    var dateLabel: PaddingLabel!
    var heartAnimationButton: AnimatedSwitch!
    var contentTextView: PlaceHolderTextView!
    var anniversaryLabel: UILabel!
    
    @IBOutlet weak var eventTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        if let schedule = realm.objects(Schedule.self).filter("date == %@", date!).first {
            self.schedule = schedule
        }
        
        self.isDate = schedule?.isDate ?? false
        profile = realm.object(ofType: Profile.self, forPrimaryKey: 0) ?? profile
        setupViews()
        setupAutolayout()
        contentTextView.text = schedule?.content
    }
    
    
    func setupViews() {
        let scrollView = UIScrollView()
        self.scrollView = scrollView
        view.addSubview(scrollView)
        
        let contentView = UIView()
        self.contentView = contentView
        scrollView.addSubview(contentView)
        
        let dateLabel = PaddingLabel()
        self.dateLabel = dateLabel
        dateLabel.leftInset = 14
        dateLabel.font = UIFont.boldSystemFont(ofSize: 24)
        dateLabel.text = date?.toStringWithCurrentLocale()
        dateLabel.sizeToFit()
        contentView.addSubview(dateLabel)
        
        let anniversaryLabel = UILabel()
        self.anniversaryLabel = anniversaryLabel
        anniversaryLabel.font = UIFont.boldSystemFont(ofSize: 18)
        anniversaryLabel.textColor = UIColor.ex.fontBlack
        anniversaryLabel.sizeToFit()
        setupAssociateDurationLabel()
        contentView.addSubview(anniversaryLabel)
        
        let heartAnimationButton = AnimatedSwitch()
        self.heartAnimationButton = heartAnimationButton
        heartAnimationButton.contentMode = .scaleAspectFill
        heartAnimationButton.addTarget(self, action: #selector(CalendarDetailViewController.actionHeartButton(_:))
            , for: .touchUpInside)
        heartAnimationButton.center = self.view.center
        heartAnimationButton.contentMode = .scaleAspectFill
        let animation = Animation.named("heart5")
        heartAnimationButton.animation = animation
        heartAnimationButton.setProgressForState(fromProgress: 0, toProgress: 1, forOnState: true)
        heartAnimationButton.setProgressForState(fromProgress: 0, toProgress: 0, forOnState: false)
        if schedule?.isDate ?? false {
            heartAnimationButton.isOn = true
        }
        contentView.addSubview(heartAnimationButton)
        
        let eventTableView = UITableView()
        self.eventTableView = eventTableView
        eventTableView.dataSource = self
        eventTableView.delegate = self
        eventTableView.estimatedRowHeight = 30
        eventTableView.separatorStyle = .none
        eventTableView.register(CalenderDetailEventTableViewCell.self, forCellReuseIdentifier: "CalenderDetailEventTableViewCell")
//        eventTableView.register(UINib(nibName: "CalenderDetailEventTableViewCell", bundle: nil), forCellReuseIdentifier: "CalenderDetailEventTableViewCell")
        contentView.addSubview(eventTableView)
        
        let contentTextView = PlaceHolderTextView()
        self.contentTextView = contentTextView
        contentTextView.placeHolder = "ノート本文"
        contentView.addSubview(contentTextView)
    }
    
    func setupAssociateDurationLabel() {
        anniversaryLabel.text = ""
        if let startDate = profile?.startDate {
            let calendar = Calendar.current
            let tokyo = Region(calendar: Calendars.gregorian, zone: Zones.asiaTokyo, locale: Locales.japaneseJapan)
            let dateTokyo = DateInRegion(date, region: tokyo).date.dateAt(.tomorrow)
            let associateDurationDateComponents = calendar.dateComponents([.year, .month, .day], from: startDate, to: dateTokyo)
            var dateDicArray: [[String: String]] = []
            if let year = associateDurationDateComponents.year, year != 0 {
                dateDicArray.append(["年": year.description])
            }
            if let month = associateDurationDateComponents.month, month != 0 {
                dateDicArray.append(["ヶ月": month.description])
            }
            if profile.startDate! <= dateTokyo.dateAt(.tomorrow) && profile.startDate?.removeYearAndMonth() == date.removeYearAndMonth() {
                for dateDic in dateDicArray {
                    let anniversaryLabelText = "\(String(describing: anniversaryLabel.text!))\(dateDic.values.first!)\(dateDic.keys.first!)"
                    anniversaryLabel.text = "\(anniversaryLabelText)記念日"
                }
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setupAutolayout() {
        scrollView.snp.makeConstraints{ (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
        }
        contentView.snp.makeConstraints{ (make) in
            make.width.equalTo(Device.bounds().width)
            make.height.equalTo(Device.bounds().height).priority(999)
            make.top.left.right.bottom.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints{ (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(32)
            make.width.equalTo(dateLabel.frame.width + 24)
            make.height.equalTo(27)
        }
        
        dateLabel.addBorderLeft(width: 5, color: UIColor.ex.mainPink)
        
        heartAnimationButton.snp.makeConstraints{ (make) in
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.width.height.equalTo(44)
            make.right.equalToSuperview().offset(-32)
        }
        
        anniversaryLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(21)
        }
        
//        eventTableView.snp.makeConstraints{ (make) in
//            make.top.equalTo(anniversaryLabel.snp.bottom).offset(32)
//            make.left.equalToSuperview().offset(32)
//            make.right.equalToSuperview().offset(-32)
//            make.height.equalTo(300)
//        }
        
        contentTextView.snp.makeConstraints{ (make) in
            make.top.equalTo(eventTableView.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationBar()
        navigationItem.rightBarButtonItem = createToolbarItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        eventTableView.snp.remakeConstraints{ (make) in
            make.top.equalTo(anniversaryLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(eventTableView.contentSize.height)
        }
    }
    
    func createToolbarItems() -> UIBarButtonItem {
        return UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(CalendarDetailViewController.save(_:)))
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
    
    @objc func actionHeartButton(_ button: AnimatedButton) {
        isDate = !isDate
        if heartAnimationButton.isOn {
            let alert: UIAlertController = UIAlertController(title: "デートの日に設定しました", message: nil, preferredStyle:  UIAlertController.Style.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        } else {
            let alert: UIAlertController = UIAlertController(title: "デートの日を取り消しました", message: nil, preferredStyle:  UIAlertController.Style.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        }

    }
    
    @objc func save(_ button: Any) {
        guard let content = contentTextView.text else { return }
        let realm = try! Realm()
        if let schedule = schedule {
            try! realm.write {
                schedule.content = content
                schedule.date = date!
                schedule.isDate = isDate
            }
        } else {
            let schedule = Schedule()
            schedule.content = content
            schedule.date = date!
            schedule.isDate = isDate
            try! realm.write {
                realm.add(schedule)
            }
        }

        navigationController?.popViewController(animated: true)
    }

}

extension CalendarDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalenderDetailEventTableViewCell", for: indexPath) as! CalenderDetailEventTableViewCell
        cell.titleLabel.text = eventArray[indexPath.row].title
        cell.colorMarkView.backgroundColor = UIColor(code: eventArray[indexPath.row].markColor)
        return cell
    }
}

extension CalendarDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
