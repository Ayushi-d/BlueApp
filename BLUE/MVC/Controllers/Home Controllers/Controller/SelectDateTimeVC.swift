//
//  SelectDateTimeVC.swift
//  BLUE
//
//

import UIKit
import FSCalendar

var boatBookTimeModel: BoatBookTimeModel?

class SelectDateTimeVC: UIViewController, StoryboardSceneBased, UITextFieldDelegate {
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)
    var arr = [TimeSlotData]()
    var selectedArr = [String]()
    
    var timeArray =  ["00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"]

    @IBOutlet weak var calenderView: FSCalendar!
    @IBOutlet weak var btnSelectDate: UIButton!
    @IBOutlet weak var txtSelectDate: UITextField!
    @IBOutlet weak var slotsAvailableText: UILabel!
    @IBOutlet weak var slotsView: UIView!
    @IBOutlet weak var slotsCollectionView: UICollectionView!
    var bookedDate = ""
    var destHours = 0
    var objBoatDetailsData: BoatDetailsData?
    var objSelectedAddress: DestinationAddress?
   private lazy var objTimeSlotModel: TimeSlotVM = {
        return TimeSlotVM()
    }()
   var objTimeSlotData = [TimeSlotData]()
    var timeSlotArray = [AvailableTimeValues]()
    override func viewDidLoad() {
        super.viewDidLoad()
        slotsAvailableText.isHidden = true
        slotsView.isHidden = true
        slotsCollectionView.allowsMultipleSelection = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectDestination_tapped(_ sender: Any) {
        let vc =  DestinationVC.instantiate()
        vc.completionblock = { Object in
            self.txtSelectDate.text = Object?.destinationAddress ?? ""
            UserDefaults.standard.removeObject(forKey: "destinationID")
            UserDefaults.standard.set(Object?.id ?? 0, forKey: "destinationID")
            self.destHours = Object?.destinationHrs ?? 0
            self.objBoatDetailsData?.startingFrom = Object?.price ?? "0.0"
            self.selectedArr.removeAll()
            self.slotsCollectionView.reloadData()
        }
        vc.arrDestinationAddress = objBoatDetailsData?.destinationAddress
        self.pushVC(controller: vc)
    }

    @IBAction func next_tapped(_ sender: Any) {
        if validateData(){
            let vc = PackagesVC.instantiate()
            vc.objBoatDetailsData = self.objBoatDetailsData
            self.pushVC(controller: vc)
        }
    }
        
    func getAvailableTimeSlots(startDate: String, endDate: String){
        objTimeSlotModel.saveTimeSlotData(startTime: startDate, endTime: endDate)
        objTimeSlotModel.getAvailableTimeSlot { isSuccess, data in
            if isSuccess{
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd"
                let formatteddate = dateFormatterGet.date(from: startDate)
                let stringDate = dateFormatterGet.string(from: formatteddate!)
                if let data = data![stringDate] {
                    self.objTimeSlotData = data as! [TimeSlotData]
                }
//                if let data = self.objTimeSlotModel.objTimeSlotDataModel?.data {
//                    self.objTimeSlotData = data
//                }
                self.slotsAvailableText.isHidden = false
                self.slotsView.isHidden = false
            }
            
        }
    }
    
    func timeSlotAPI(startDate: String,endDate: String){
        ProgressHUD.show()
        var urlRequest = URLRequest(url : URL(string: "https://blue.testingjunction.tech/api/available-time-slots")!)
        urlRequest.httpMethod = "post"
        var headers: [String: String]? {
            if let userAuthToken = UserManager.shared.authToken {
                return ["Accept": "application/json",
                        "Authorization": "Bearer \(userAuthToken)"]
            }
            return ["Content-Type": "application/json"] // + aDictMetaData
        }
        let requestBody: [String: Any] = ["start":startDate,"end":endDate,"boat_id":objBoatDetailsData?.id ?? 0]
            urlRequest.httpBody = requestBody.percentEncoded()
            urlRequest.allHTTPHeaderFields = headers
            URLSession.shared.dataTask(with: urlRequest) { data, httpURLResponse, error in
                guard let httpResponse = httpURLResponse as? HTTPURLResponse else {return}
                let statusCode = httpResponse.statusCode
                do {
                    let response = try JSONDecoder().decode(AvailableSlotModel.self, from: data!)
                    if (200...299).contains(statusCode){
                        self.selectedArr.removeAll()
                        self.timeSlotArray.removeAll()
                        ProgressHUD.hide()
                        let dateFormatterGet = DateFormatter()
                        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let formatteddate = dateFormatterGet.date(from: startDate)
                        dateFormatterGet.dateFormat = "yyyy-MM-dd"
                        let stringDate = dateFormatterGet.string(from: formatteddate!)
                        self.timeSlotArray = response.data![stringDate]!
                        DispatchQueue.main.async {
                            self.slotsAvailableText.isHidden = false
                            self.slotsView.isHidden = false
                            self.slotsCollectionView.reloadData()
                        }
                    }
                }
                catch let error{
                    ProgressHUD.hide()
                    debugPrint(error)
                }
            }.resume()
        }
    
}


extension SelectDateTimeVC : FSCalendarDelegate, FSCalendarDataSource{
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        timeSlotAPI(startDate: dateFormatterGet.string(from: date)+" 00:00:00",endDate: dateFormatterGet.string(from: date)+" 23:00:00")
        dateFormatterGet.dateFormat = "dd-MMM-yyyy"
        bookedDate = dateFormatterGet.string(from: date)
       //getAvailableTimeSlots(startDate: dateFormatterGet.string(from: date)+" 00:00:00", endDate: dateFormatterGet.string(from: date)+" 23:00:00")
    }
    
}

extension SelectDateTimeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = slotsCollectionView.dequeueReusableCell(withReuseIdentifier: "TimeSlotCell", for: indexPath) as? TimeSlotCell else {return UICollectionViewCell() }
        cell.timeStamp.text = timeArray[indexPath.item]
        if !timeSlotArray.isEmpty{
            cell.contentView.backgroundColor = timeSlotArray[indexPath.item].available == true ? UIColor.init(named: "BlueViewColor") : UIColor.clear
            cell.contentView.layer.borderWidth = 0
            cell.timeStamp.textColor = UIColor.black
        }
        if !selectedArr.isEmpty{
            if selectedArr.contains(timeArray[indexPath.item]) && selectedArr.max() != timeArray[indexPath.item]{
                cell.contentView.layer.borderWidth = 2
                cell.contentView.layer.borderColor = UIColor.init(named: "ButtonColor")?.cgColor
                cell.contentView.backgroundColor = UIColor.init(named: "DarkBlue")
                cell.timeStamp.textColor = UIColor.white
            }else{
                cell.contentView.layer.borderWidth = 0
                cell.contentView.backgroundColor = timeSlotArray[indexPath.item].available == true ? UIColor.init(named: "BlueViewColor") : UIColor.clear
                cell.timeStamp.textColor = UIColor.black
            }
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.slotsCollectionView.width/6.2, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (txtSelectDate.text ?? "").isBlank{
            txtSelectDate.shake()
            AlertMesage.show(.error, message: Localizable.validation.destination)
            return
        }
        if timeSlotArray[indexPath.item].available == true && indexPath.item < timeArray.count - (destHours-1){
            selectedArr.removeAll()
            for i in 0...destHours{
                if timeSlotArray[indexPath.item + (destHours-1)].available == false{
                    AlertMesage.show(.error, message: "Not Available for your Start time")
                    return
                }
                selectedArr.append(timeArray[indexPath.item + i])
            }
            print(selectedArr)
            self.slotsCollectionView.reloadData()
        }else{
            AlertMesage.show(.error, message: "Not Available for your start time")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension SelectDateTimeVC {
    
    private func validateData() -> Bool {
        if (txtSelectDate.text ?? "").isBlank{
            txtSelectDate.shake()
            AlertMesage.show(.error, message: Localizable.validation.destination)
            return false
        } else if calenderView.selectedDate == nil{
            calenderView.shake()
            AlertMesage.show(.error, message: Localizable.validation.date)
            return false
        } else if  selectedArr.isEmpty {
            slotsCollectionView.shake()
            AlertMesage.show(.error, message: Localizable.validation.timeSlot)
            return false
        }
        boatBookTimeModel = BoatBookTimeModel(startTime: selectedArr.min(), endTime: selectedArr.max(), selectedDate: bookedDate)
        return true
    }
}
