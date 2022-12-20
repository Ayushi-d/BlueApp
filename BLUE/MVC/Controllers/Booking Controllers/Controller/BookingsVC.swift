//
//  BookingsVC.swift
//  BLUE
//
//

import UIKit
import Hero

class BookingsVC: UIViewController {

    @IBOutlet weak var fromLabel: UITextField!
    @IBOutlet weak var untilLabel: UITextField!
    @IBOutlet weak var startingTimeLabel: UITextField!
    @IBOutlet weak var endingTImeLabel: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var parkingHourField: UITextField!
    
    var ownerBoatID = Int()
    var bookingDetails: BookingModel?
    var availableData : AvailableParking?
    var startDate = Date()
    override func viewDidLoad(){
        super.viewDidLoad()
        self.configureViewDidload()
    }
    
    func configureViewDidload(){
        fromLabel.delegate = self
        untilLabel.delegate = self
        startingTimeLabel.delegate = self
        endingTImeLabel.delegate = self
        priceField.delegate = self
        parkingHourField.delegate = self
        if self.availableData?.priceType == "per_month"{
            self.parkingHourField.placeholder = "Months"
            self.priceLabel.text = (self.availableData?.price ?? "0.0") + "/Month"
        }else if self.availableData?.priceType == "per_day"{
            self.parkingHourField.placeholder = "Days"
            self.priceLabel.text = (self.availableData?.price ?? "0.0") + "/Day"
        }else if self.availableData?.priceType == "per_year"{
            self.parkingHourField.placeholder = "Years"
            self.priceLabel.text = (self.availableData?.price ?? "0.0") + "/Year"
        }else{
            self.parkingHourField.placeholder = "Hours"
            self.priceLabel.text = (self.availableData?.price ?? "0.0") + "/Hour"
        }
    }
    
    @IBAction func notifcationTapped(_ sender: Any) {
        let vc = NotificationVC.instantiate()
        self.pushVC(controller: vc)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.poptoViewController()
    }
    
    @IBAction func continueTapped(_ sender: Any) {
        if validateData(){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
            vc.bookingDetails = BookingModel(boatId: ownerBoatID,parkingID: self.availableData?.id ?? 0,parkingAddress: "", boatName: self.availableData?.name ?? "", startTime: self.startingTimeLabel.text!, endTime: self.endingTImeLabel.text!, startDate: self.fromLabel.text!, endDate: self.untilLabel.text!, totalPrice: self.priceField.text!)
            self.navigationController?.isHeroEnabled = true
            self.navigationController?.heroNavigationAnimationType = .zoom
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension BookingsVC: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == untilLabel{
            if fromLabel.text == "" || fromLabel.text == "From"{
                untilLabel.resignFirstResponder()
                fromLabel.shake()
                AlertMesage.show(.error, message: Localizable.validation.startDate)
                return
            }else{
                self.openDatePicker(textField: textField)
            }
        }else{
            self.openDatePicker(textField: textField)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let currentPrice = Double(availableData?.price ?? "0")
        let enterdText = Int(textField.text ?? "0")
        if textField == parkingHourField{
            if textField.text == ""{
               self.priceField.text = ""
           }else{
               self.priceField.text = "\(currentPrice! * enterdText!.doubleValue)"
               self.bookingDetails?.totalPrice = self.priceField.text!
           }
        }
    }
    
}


extension BookingsVC{
        
        /// Validate Value
        /// - Returns: Bool
        private func validateData() -> Bool {
            if (fromLabel.text ?? "").isBlank || self.fromLabel.text == "From"{
                fromLabel.shake()
                AlertMesage.show(.error, message: Localizable.validation.startDate)
                return false
            } else if (untilLabel.text ?? "").isBlank || self.untilLabel.text == "Until"{
                untilLabel.shake()
                AlertMesage.show(.error, message: Localizable.validation.endDate)
                return false
            } else if  (startingTimeLabel.text ?? "").isBlank || self.startingTimeLabel.text == "Starting Time" {
                startingTimeLabel.shake()
                AlertMesage.show(.error, message: Localizable.validation.startTime)
                return false
            }else if  (endingTImeLabel.text ?? "").isBlank || self.endingTImeLabel.text == "Ending Time" {
                endingTImeLabel.shake()
                AlertMesage.show(.error, message: Localizable.validation.endTime)
                return false
            }else if  (parkingHourField.text ?? "").isBlank {
                parkingHourField.shake()
                AlertMesage.show(.error, message: Localizable.validation.parkingTime)
                return false
            }
            return true
        }
}

extension BookingsVC {
    
    
    func openDatePicker(textField: UITextField){
       
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancleBtnClick))
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneBtnClick))
        let flexibleBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelBtn,flexibleBtn,doneBtn], animated: true)
        if textField == fromLabel{
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.minimumDate = datePicker.date
            fromLabel.inputView = datePicker
            fromLabel.inputAccessoryView = toolbar
            datePicker.preferredDatePickerStyle = .wheels
        }else if textField == untilLabel{
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.minimumDate = self.startDate
            untilLabel.inputView = datePicker
            untilLabel.inputAccessoryView = toolbar
            datePicker.preferredDatePickerStyle = .wheels
        }else if textField == startingTimeLabel{
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .time
            startingTimeLabel.inputView = datePicker
            datePicker.preferredDatePickerStyle = .wheels
            startingTimeLabel.inputAccessoryView = toolbar
        }else {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .time
            endingTImeLabel.inputView = datePicker
            endingTImeLabel.inputAccessoryView = toolbar
            datePicker.preferredDatePickerStyle = .wheels
        }
        
}
    
    @objc func cancleBtnClick(){
        fromLabel.resignFirstResponder()
        untilLabel.resignFirstResponder()
        startingTimeLabel.resignFirstResponder()
        endingTImeLabel.resignFirstResponder()
    }
    
    @objc func doneBtnClick(){
        
        if let fromDatePicker = fromLabel.inputView as? UIDatePicker{
            let dateFromatter = DateFormatter()
            dateFromatter.dateStyle = .medium
            self.startDate = fromDatePicker.date
            fromLabel.text = dateFromatter.string(from: fromDatePicker.date)
            fromLabel.resignFirstResponder()
        }
        
        if let untilDatePicker = untilLabel.inputView as? UIDatePicker{
            let dateFromatter = DateFormatter()
            dateFromatter.dateStyle = .medium
            untilLabel.text = dateFromatter.string(from: untilDatePicker.date)
            untilLabel.resignFirstResponder()
        }
        
        if let startTimePicker = startingTimeLabel.inputView as? UIDatePicker{
            startTimePicker.datePickerMode = .time
            let dateFromatter = DateFormatter()
            dateFromatter.timeStyle = .short
            startingTimeLabel.text = dateFromatter.string(from: startTimePicker.date)
            startingTimeLabel.resignFirstResponder()
        }
        
        if let endingTimePicker = endingTImeLabel.inputView as? UIDatePicker{
            endingTimePicker.datePickerMode = .time
            let dateFromatter = DateFormatter()
            dateFromatter.timeStyle = .short
            endingTImeLabel.text = dateFromatter.string(from: endingTimePicker.date)
            endingTImeLabel.resignFirstResponder()
        }
        
        
    }
    
}

extension Int {
  var doubleValue: Double {
    return Double(self)
  }
}
