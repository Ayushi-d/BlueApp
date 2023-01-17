//
//  MyParkingVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 26/09/22.
//

import UIKit

class MyParkingVC: UIViewController, StoryboardSceneBased {
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.parking.rawValue, bundle: nil)

    @IBOutlet weak var noParkingView: UIView!
    @IBOutlet weak var noParkingLabel: AppBaseLabel!
    @IBOutlet weak var bntBack: UIButton!
    var refreshContoller = UIRefreshControl()
    @IBOutlet weak var parkingTableView: UITableView!{
        didSet{
            parkingTableView.register(UINib(nibName: "ParkingCell", bundle: nil), forCellReuseIdentifier: "ParkingCell")
        }
    }
    
    var isFromSetting = Bool()
    //
    private lazy var model: ParkingVM = {
        return ParkingVM()
    }()
    //
    var objParkingData = [MyParkingModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bntBack.isHidden  =  isFromSetting ? false : true
        parkingListApi()
        parkingTableView.refreshControl = refreshContoller
        refreshContoller.addTarget(self, action: #selector(pulltoRefresh), for: .valueChanged)
    }
    
    @objc func pulltoRefresh(){
        self.parkingListApi()
    }
    
    @IBAction func addBoatTapped(_ sender: Any) {
        let vc = AddBoatDetailsVC.instantiate()
        self.pushVC(controller: vc)
    }
    
    func parkingListApi(){
        refreshContoller.endRefreshing()
        model.saveParkingListData(page: 1)
        model.getPakingList { sucess in
            if sucess {
                if let data = self.model.objParkingDataModel?.data {
                    self.objParkingData  = data
                }
                self.noParkingView.isHidden = self.objParkingData.count > 0 ? true : false
                self.parkingTableView.reloadData()
            }
        }
    }

    @IBAction func addParkingButton(_ sender: Any) {
        let vc = AddBoatDetailsVC.instantiate()
        self.pushVC(controller: vc)
    }
    
}

extension MyParkingVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objParkingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = parkingTableView.dequeueReusableCell(withIdentifier: "ParkingCell", for: indexPath) as? ParkingCell else {return UITableViewCell() }
        cell.configureCell(with: objParkingData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ParkingDetailsVC.instantiate()
        vc.objParkingData = objParkingData[indexPath.row]
        self.pushVC(controller: vc)
    }
    
    
}
