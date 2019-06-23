//
//  CalenderViewController.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/04/14.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit
import FSCalendar
import SnapKit
import RealmSwift
import SwiftDate
import CalculateCalendarLogic
import GoogleMobileAds

class CalenderViewController: UIViewController {

    @IBOutlet weak var calenderView: FSCalendar!
    
    var schedules: [Schedule]!
    var profile: Profile!
    var events: Results<Event>?
    
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutolayout()
        calenderView.delegate = self
        calenderView.dataSource = self
        calenderView.register(OriginCalendarViewCell.self, forCellReuseIdentifier: "cell")
        realm = try! Realm()
        profile = realm.object(ofType: Profile.self, forPrimaryKey: 0)
        events = realm.objects(Event.self)
        let schedulesResult = realm.objects(Schedule.self)
        schedules = schedulesResult.reversed()
    }
    
    func setupAutolayout() {
        calenderView.snp.makeConstraints{ (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(400)
        }
    }
    
    func setupNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationBar()
        calenderView.reloadData()
    }
}

extension CalenderViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        guard let cell = calendar.cell(for: date, at: .current) as? OriginCalendarViewCell else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "CalendarDetailViewController") as! CalendarDetailViewController
        vc.date = date
        vc.eventArray = cell.eventArray
        calendar.deselect(date)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position) as! OriginCalendarViewCell
        cell.reset()
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        if events?.count != 0 {
            if let events = events {
                for event in events {
                    if event.isMark(date: date) {
                        cell.eventArray.append(event)
                    }
                }
            }
        }
        cell.displayEventMark()
        if let schedule = realm.objects(Schedule.self).filter("date == %@", date).first {
            if schedule.isDate {
                cell.rightImageView?.image = #imageLiteral(resourceName: "heart")
            }
            if schedule.content != "" {
                cell.leftImageView?.image = #imageLiteral(resourceName: "comment")
            }
        }
        return cell
    }


    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let tokyo = Region(calendar: Calendars.gregorian, zone: Zones.asiaTokyo, locale: Locales.japaneseJapan)
        let date1 = DateInRegion(date, region: tokyo).date
        guard let profile = profile else {
            return nil
        }
        if profile.startDate! <= date1.dateAt(.tomorrow) && profile.startDate?.removeYearAndMonth() == date.removeYearAndMonth() {
            return UIColor.ex.mainPink
        }
        return nil
    }

    // 祝日判定を行い結果を返すメソッド
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }
    
    //曜日判定
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする
        if self.judgeHoliday(date){
            return #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
        
        //土日の判定
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {
            return UIColor.red
        }
        else if weekday == 7 {
            return UIColor.blue
        }
        
        return nil
    }
}


extension CalenderViewController: GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}
