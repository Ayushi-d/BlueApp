//
//  AddBoatsVC.swift
//  BLUE
//
//

import UIKit
import Hero

class AddBoatsVC: UIViewController, StoryboardSceneBased {
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.booking.rawValue, bundle: nil)
    
    private lazy var boatVM: BoatViewModel = {
        return BoatViewModel()
    }()
    //boatdata
    private var objMyBoatData = [MyBoatData]()
    @IBOutlet weak var baotsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baotsTableView.register(cellType: MyBookingCell.self)
        baotsTableView.estimatedRowHeight = 142
        baotsTableView.rowHeight = UITableView.automaticDimension
        getMyBoatApi()
    }
    
    private func getMyBoatApi(){
        boatVM.saveMyBoatData(page: 1)
        boatVM.myBoats { [self] success in
            if success{
                objMyBoatData = (boatVM.objMyBoatModel?.data)!
                if objMyBoatData.isEmpty{
                    self.baotsTableView.isHidden = true
                }
                baotsTableView.reloadData()
            }
        }
    }
    
    func navigateToAddBoat(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddBoatDetailsVC") as! AddBoatDetailsVC
        self.navigationController?.isHeroEnabled = true
        self.navigationController?.heroNavigationAnimationType = .zoom
        self.navigationController?.pushViewController(vc, animated: true)
//        let vc = AllBoatsVC.instantiate()
//        self.pushVC(controller: vc)
    }
    
    @IBAction func addBoat_tapped(_ sender: UIButton) {
        self.navigateToAddBoat()
    }
    
    @IBAction func plusTapped(_ sender: Any) {
        self.navigateToAddBoat()
    }
    
    
}

extension AddBoatsVC: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objMyBoatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell: MyBookingCell = tableView.dequeueReusableCell(for: indexPath)
        aCell.configCellForMyBoat(with: objMyBoatData[indexPath.row])
        return aCell
    }
    
}
