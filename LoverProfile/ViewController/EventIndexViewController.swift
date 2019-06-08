//
//  EventIndexViewController.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/05/25.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit
import RealmSwift

class EventIndexViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var goCreateButton: AddItemButton!
    var realm: Realm!
    var events: Results<Event>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "イベント一覧"
        navigationController?.navigationBar.barTintColor = UIColor.ex.mainPink
//        navigationController?.navigationBar.isTranslucent = true
        setupViews()
        setupAutolayout()
        realm = try! Realm()
        events = realm.objects(Event.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        events = realm.objects(Event.self)
        tableView.reloadData()
    }
    
    func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        
        goCreateButton.imageView
        goCreateButton.addTarget(self, action: #selector(EventIndexViewController.goCreate(_:)), for: .touchUpInside)
    }
    
    func setupAutolayout() {
        tableView.snp.makeConstraints{ (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        goCreateButton.snp.makeConstraints{ (make) in
            make.size.equalTo(CGSize(width: 60,height: 60))
            make.bottom.equalToSuperview().offset(-120)
            make.right.equalToSuperview().offset(-40)
        }
    }
    
    @objc func goCreate(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EventDetailViewController") as! EventDetailViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension EventIndexViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        if let event = events?[indexPath.row] {
            cell.reset()
            cell.titleLabel.text = event.title
            switch event.frequencyType {
            case .theDay:
                cell.detailLabel.text = "\(event.startDate.toStringWithCurrentLocale())〜\(event.finishDate.toStringWithCurrentLocale())"
            case .everyWeek:
                cell.detailLabel.text = "毎週\(event.startDate.weekdayName(.default, locale: Locale.init(identifier: "ja")))〜\(event.finishDate.weekdayName(.default, locale: Locale.init(identifier: "ja")))"
            case .everyMonth:
                cell.detailLabel.text = "毎月\(event.startDate.day)日〜\(event.finishDate.day)日"
            case .everyYear:
                cell.detailLabel.text = "毎年\(event.startDate.removeYear())〜\(event.finishDate.removeYear())"
            }
            cell.colorMarkView.backgroundColor = UIColor(code: (events?[indexPath.row].markColor)!)
            cell.addBorder(width: 1, color: UIColor.ex.lightGrey, position: .bottom)
        }
        return cell
    }
    
}

extension EventIndexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EventDetailViewController") as! EventDetailViewController
        let event = events?[indexPath.row]
        vc.event = event
        vc.isEditStatus = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
