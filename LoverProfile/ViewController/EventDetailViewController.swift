//
//  EventDetailViewController.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/05/25.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit
import EFColorPicker
import RealmSwift

class EventDetailViewController: UIViewController {
    
    var event: Event?
    var isEditStatus: Bool = false

    var scrollView: UIScrollView!
    var contentView: UIView!
    var titleLabel: PaddingLabel!
    var titleTextField: UITextField!
    var durationLabel: PaddingLabel!
    var startLabel: UILabel!
    var startTextField: DatePickerTextField!
    var finishLabel: UILabel!
    var finishTextField: DatePickerTextField!
    var frequencyLabel: PaddingLabel!
    var frequencySegmentControl: UISegmentedControl!
    var colorLabel: PaddingLabel!
    var colorSelectionView: EFColorSelectionView!
    
    var currentColorHex = "#ffffff"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupAutolayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.setToolbarItems([createToolbarItems()], animated: true)
        navigationItem.rightBarButtonItem = createToolbarItems()
        navigationController?.navigationBar.tintColor = UIColor.ex.black87
        if isEditStatus {
            titleTextField.text = event?.title
            startTextField.text = event?.startDate.toStringWithCurrentLocale()
            startTextField.datePicker.date = event?.startDate ?? Date()
            finishTextField.text = event?.finishDate.toStringWithCurrentLocale()
            finishTextField.datePicker.date = event?.finishDate ?? Date()
            frequencySegmentControl.selectedSegmentIndex = event?.frequencyType.number ?? 0
            colorSelectionView.color = UIColor(code: event?.markColor ?? "#ffffff")
        }
    }
    
    func createToolbarItems() -> UIBarButtonItem {
        return UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(EventDetailViewController.save(_:)))
    }
    
    func setupViews() {
        let scrollView = UIScrollView()
        self.scrollView = scrollView
        view.addSubview(scrollView)
        
        let contentView = UIView()
        self.contentView = contentView
        scrollView.addSubview(contentView)
        
        let titleLabel = PaddingLabel()
        self.titleLabel = titleLabel
        titleLabel.text = "イベント追加"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.addBorderLeft(width: 5, color: UIColor.ex.mainPink)
        titleLabel.sizeToFit()
        contentView.addSubview(titleLabel)
        
        let titleTextField = UITextField()
        self.titleTextField = titleTextField
        titleTextField.placeholder = "タイトル"
        titleTextField.addBorderBottom(height: 3, color: UIColor.ex.mainPink)
        contentView.addSubview(titleTextField)
        
        let durationLabel = PaddingLabel()
        self.durationLabel = durationLabel
        durationLabel.text = "日時・期間"
        durationLabel.font = UIFont.boldSystemFont(ofSize: 18)
        durationLabel.addBorderLeft(width: 5, color: UIColor.ex.fontBlack)
        durationLabel.sizeToFit()
        contentView.addSubview(durationLabel)
        
        let startLabel = UILabel()
        self.startLabel = startLabel
        startLabel.text = "開始日時"
        startLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(startLabel)
        
        let startTextField = DatePickerTextField()
        self.startTextField = startTextField
        startTextField.addBorderBottom(height: 1, color: UIColor.ex.fontBlack)
        contentView.addSubview(startTextField)
        
        let finishLabel = UILabel()
        self.finishLabel = finishLabel
        finishLabel.text = "終了日時"
        finishLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(finishLabel)
        
        let finishTextField = DatePickerTextField()
        self.finishTextField = finishTextField
        finishTextField.addBorderBottom(height: 1, color: UIColor.ex.fontBlack)
        contentView.addSubview(finishTextField)
        
        let frequencyLabel = PaddingLabel()
        self.frequencyLabel = frequencyLabel
        frequencyLabel.text = "頻度"
        frequencyLabel.font = UIFont.boldSystemFont(ofSize: 18)
        frequencyLabel.addBorderLeft(width: 5, color: UIColor.ex.fontBlack)
        frequencyLabel.sizeToFit()
        contentView.addSubview(frequencyLabel)
        
        let frequencySegmentControl = UISegmentedControl(items: Event.FrequencyType.allValues)
        self.frequencySegmentControl = frequencySegmentControl
        frequencySegmentControl.selectedSegmentIndex = 0
        contentView.addSubview(frequencySegmentControl)
        
        let colorLabel = PaddingLabel()
        self.colorLabel = colorLabel
        colorLabel.text = "マークカラー"
        colorLabel.font = UIFont.boldSystemFont(ofSize: 18)
        colorLabel.addBorderLeft(width: 5, color: UIColor.ex.fontBlack)
        colorLabel.sizeToFit()
        contentView.addSubview(colorLabel)
        
        let colorSelectionView = EFColorSelectionView()
        self.colorSelectionView = colorSelectionView
        colorSelectionView.setSelectedIndex(index: EFSelectedColorView.HSB, animated: true)
        colorSelectionView.alpha = 0.7
        currentColorHex = colorSelectionView.color.toHexString()
        colorSelectionView.delegate = self
        contentView.addSubview(colorSelectionView)
    }
    
    

    func setupAutolayout() {
        scrollView.snp.makeConstraints{ (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints{ (make) in
            make.width.equalTo(Device.screenWidth())
            make.top.left.right.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(32)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview()
            make.height.equalTo(titleLabel.frame.height)
        }
        titleLabel.addBorderLeft(width: 5, color: UIColor.ex.mainPink)
        
        titleTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(44)
        }
        
        durationLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(titleTextField.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(durationLabel.snp.height)
        }
        
        startLabel.snp.makeConstraints { (make) in
            make.top.equalTo(durationLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(21)
        }
        
        startTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(startLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(40)
        }
        
        finishLabel.snp.makeConstraints { (make) in
            make.top.equalTo(startTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(21)
        }
        
        finishTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(finishLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(40)
        }
        
        frequencyLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(finishTextField.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(21)
        }
        
        frequencySegmentControl.snp.makeConstraints{ (make) in
            make.top.equalTo(frequencyLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(21)
        }
        
        colorLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(frequencySegmentControl.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(21)
        }
        
        colorSelectionView.snp.makeConstraints{ (make) in
            make.top.equalTo(colorLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview()
        }
    }
    
    
    
    @objc func save(_ sender: Any) {
        guard let title = titleTextField.text, title != "" else { return }
        guard let startDate = startTextField.text?.toDateFromString() else { return }
        guard let finishDate = finishTextField.text?.toDateFromString() else { return }
        
        // 頻度とdateの組み合わせでsave可能か判定する

        guard let frequencyType = Event.FrequencyType(rawValue: Event.FrequencyType.allValues[frequencySegmentControl.selectedSegmentIndex]) else { return }
        let result = frequencyValidate(frequencyType: frequencyType, startDate: startDate, finishDate: finishDate)
        switch result {
        case .success(): break
        case .failure(let err):
            switch err {
            case .weekError:
                showAlert(message: "毎週の場合は７日間以上の指定ができません")
            case .monthError:
                showAlert(message: "毎月の場合は１ヶ月間以上の指定ができません")
            case .yearError:
                showAlert(message: "毎年の場合は一年間以上の指定ができません")
            }
            return
        }
        
        let realm = try! Realm()
        if isEditStatus {
            let event = realm.object(ofType: Event.self, forPrimaryKey: self.event?.id) ?? Event()
            try! realm.write {
                event.title = title
                event.startDate = startDate
                event.finishDate = finishDate
                event.frequencyType = Event.FrequencyType(rawValue: Event.FrequencyType.allValues[frequencySegmentControl.selectedSegmentIndex])!
                event.markColor = currentColorHex
            }
        } else {
            let event = Event()
            event.title = title
            event.startDate = startDate
            event.finishDate = finishDate
            event.frequencyType = Event.FrequencyType(rawValue: Event.FrequencyType.allValues[frequencySegmentControl.selectedSegmentIndex])!
            event.markColor = currentColorHex
            try! realm.write {
                realm.add(event)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(title: String = "設定エラー", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "はい", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

}

extension EventDetailViewController: EFColorViewDelegate {
    func colorView(_ colorView: EFColorView, didChangeColor color: UIColor) {
        currentColorHex = color.withAlphaComponent(0.7).toHexString()
    }
}

extension EventDetailViewController {
    enum FrequencyAndDateMatchingError: Error {
        case weekError
        case monthError
        case yearError
    }
    
    func frequencyValidate(frequencyType: Event.FrequencyType, startDate: Date, finishDate: Date) -> Result<Void, FrequencyAndDateMatchingError> {
        switch frequencyType {
        case .theDay:
            return .success(())
        case .everyWeek:
            if Date.differenceDay(date1: startDate, date2: finishDate) > 6 {
                return .failure(.weekError)
            }
        case .everyMonth:
            if Date.differenceMonth(date1: startDate, date2: finishDate) > 0 {
                return .failure(.monthError)
            }
        case .everyYear:
            if Date.differenceYear(date1: startDate, date2: finishDate) > 0 {
                return .failure(.yearError)
            }
        }
        return .success(())
    }
}
