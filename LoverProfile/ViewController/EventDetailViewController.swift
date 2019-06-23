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
        navigationController?.navigationBar.tintColor = UIColor.ex.accent
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
        return UIBarButtonItem(title: LSEnum.save.text, style: .plain, target: self, action: #selector(EventDetailViewController.save(_:)))
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
        titleLabel.leftInset = 0
        titleLabel.text = LSEnum.eventTitle.text
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()
        contentView.addSubview(titleLabel)
        
        let titleTextField = UITextField()
        self.titleTextField = titleTextField
        titleTextField.placeholder = LSEnum.title.text
        contentView.addSubview(titleTextField)
        
        let durationLabel = PaddingLabel()
        self.durationLabel = durationLabel
        durationLabel.leftInset = 0
        durationLabel.text = LSEnum.duration.text
        durationLabel.font = UIFont.boldSystemFont(ofSize: 18)
        durationLabel.sizeToFit()
        contentView.addSubview(durationLabel)
        
        let startLabel = UILabel()
        self.startLabel = startLabel
        startLabel.text = LSEnum.startDate.text
        startLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(startLabel)
        
        let startTextField = DatePickerTextField()
        self.startTextField = startTextField
        startTextField.addBorderBottom(height: 1, color: UIColor.ex.fontBlack)
        contentView.addSubview(startTextField)
        
        let finishLabel = UILabel()
        self.finishLabel = finishLabel
        finishLabel.text = LSEnum.finishDate.text
        finishLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(finishLabel)
        
        let finishTextField = DatePickerTextField()
        self.finishTextField = finishTextField
        finishTextField.addBorderBottom(height: 1, color: UIColor.ex.fontBlack)
        contentView.addSubview(finishTextField)
        
        let frequencyLabel = PaddingLabel()
        self.frequencyLabel = frequencyLabel
        frequencyLabel.leftInset = 0
        frequencyLabel.text = LSEnum.frequency.text
        frequencyLabel.font = UIFont.boldSystemFont(ofSize: 18)
        frequencyLabel.sizeToFit()
        contentView.addSubview(frequencyLabel)
        
        let frequencySegmentControl = UISegmentedControl(items: Event.FrequencyType.allValues)
        self.frequencySegmentControl = frequencySegmentControl
        frequencySegmentControl.selectedSegmentIndex = 0
        contentView.addSubview(frequencySegmentControl)
        
        let colorLabel = PaddingLabel()
        self.colorLabel = colorLabel
        colorLabel.leftInset = 0
        colorLabel.text = LSEnum.markColor.text
        colorLabel.font = UIFont.boldSystemFont(ofSize: 18)
        colorLabel.sizeToFit()
        contentView.addSubview(colorLabel)
        
        let colorSelectionView = EFColorSelectionView()
        self.colorSelectionView = colorSelectionView
        colorSelectionView.setSelectedIndex(index: EFSelectedColorView.HSB, animated: true)
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
        
        titleTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
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
            make.top.equalTo(startLabel.snp.bottom)
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
            make.top.equalTo(finishLabel.snp.bottom)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(40)
        }
        
        frequencyLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(finishTextField.snp.bottom).offset(40)
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
            make.top.equalTo(frequencySegmentControl.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(21)
        }
        
        colorSelectionView.snp.makeConstraints{ (make) in
            make.top.equalTo(colorLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview().offset(-30)
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
                showAlert(message: LSEnum.configErrorWeek.text)
            case .monthError:
                showAlert(message: LSEnum.configErrorMonth.text)
            case .yearError:
                showAlert(message: LSEnum.configErrorYear.text)
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
    
    func showAlert(title: String = LSEnum.configError.text, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: LSEnum.yes.text, style: .default, handler: nil)
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
