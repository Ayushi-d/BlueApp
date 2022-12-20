//
//  SeaFarerVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 26/09/22.
//

import UIKit
import Hero

class SeaFarerVC: UIViewController, TabsDelegate, SeaFarerPhoneProtocol {
   
    
    
    
    @IBOutlet weak var tabViewL: TabsView!
    @IBOutlet weak var noCaptainFound: AppBaseLabel!
    @IBOutlet weak var seaFarerTableView: UITableView!{
        didSet{
            seaFarerTableView.register(UINib(nibName: "SeaFarerCell", bundle: nil), forCellReuseIdentifier: "SeaFarerCell")
        }
    }
    
    // MARK: Variable
    private lazy var seafarerVM: SeafarerVM = {
        return SeafarerVM()
    }()
    var seafarerData = [SeafarerData]()
    var seafarerCategory = [SubCategory]()
    
    func tabsViewDidSelectItemAt(position: Int) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noCaptainFound.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        getSeafararCategory()
    }
    
    
    @IBAction func plus_tapped(_ sender: Any) {
        let addCaptainVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCaptainVC") as! AddCaptainVC
        self.navigationController?.isHeroEnabled = true
        self.navigationController?.heroNavigationAnimationType = .zoom
        self.navigationController?.pushViewController(addCaptainVC, animated: true)
    }
    /// Get category and sub category api
    func getSeafarerDataAPI()  {
        seafarerVM.saveSeafarerData(page: 1)
        seafarerVM.getSeafrerList { sucess in
            if sucess {
                if let data = self.seafarerVM.objSeafarerModel?.data {
                    self.seafarerData  = data
                }
                //self.noCaptainFound.isHidden = self.seafarerData.count > 0 ? true : false
                self.seaFarerTableView.reloadData()
            }
        }
    }
    
    //get seafarerCategory
    func getSeafararCategory(){
        getSeafarerDataAPI()
        tabViewL.tabs.removeAll()
        seafarerVM.getSeafararCategory { [self] success in
            if success{
                tabViewL.tabMode = .fixed
                self.seafarerCategory = (self.seafarerVM.objSeafarerCategory?.data)!
                for i in 0...seafarerCategory.count-1{
                    let model = Tab(title: "\(seafarerCategory[i].name ?? "Captions")")
                    tabViewL.tabs.append(model)
                }
                tabViewL.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
            }
        }
    }
    
    func didtappedPhone(tag: Int) {
        guard let url = URL(string: "tel://\(self.seafarerData[tag].phone_no ?? 986758432)") else { return }
        UIApplication.shared.open(url as URL)
    }
    
    func didtappedMessage(tag: Int) {
        guard let url = URL(string: "sms:\(self.seafarerData[tag].phone_no ?? 34234223)") else { return }
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
}

//MARK: - UITableView Setup
extension SeaFarerVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = seaFarerTableView.dequeueReusableCell(withIdentifier: "SeaFarerCell", for: indexPath) as? SeaFarerCell else {return UITableViewCell() }
//        cell.cellConfig(with: seafarerData[indexPath.row])
          cell.delegate = self
//        cell.seaFarerPhone.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = BoatsVC.instantiate()
//        vc.objCategory = seafarerData[indexPath.row]
//        if let sub = seafarerVM.objSeafarerModel?.data?.subCategory {
//            vc.arrSubCategoty = sub
//        }
//        self.pushVC(controller: vc)
//    }
}
