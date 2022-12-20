//
//  BoatsVC.swift
//  BLUE
//
//

import UIKit
import SwiftyJSON

class BoatsVC: UIViewController, TabsDelegate, StoryboardSceneBased {
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)

    func tabsViewDidSelectItemAt(position: Int) {
        if let subID = arrSubCategoty[position].id {
            intPage = 1
            intSubcategory = subID
            homeVM.saveBoatListData(search: "", category: objCategory?.id ?? 0, sub_category: Int(subID) ?? 0, page: intPage)
            getBoatList()

        }
    }
    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet var viewHeader: UIView!
    @IBOutlet var lblNoData: AppBaseLabel!
    @IBOutlet weak var txtSearch: UISearchBar!
    
    // MARK: Variable
    private lazy var homeVM: HomeViewModel = {
        return HomeViewModel()
    }()
    var intSubcategory = "0"
    var intPage = 1
    
    @IBOutlet weak var tabView: TabsView!
    @IBOutlet weak var boatTableView: UITableView!{
            didSet{
                boatTableView.register(UINib(nibName: "AllBoatsTableCell", bundle: nil), forCellReuseIdentifier: "AllBoatsTableCell")
            }
    }
    
    var objCategory: Category?
    var arrSubCategoty = [SubCategory]()
    var arrBoatlist = [BoatListDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupTabs()
        self.navTitle.text = self.objCategory?.name ?? ""
        // Do any additional setup after loading the view.
    }
    
    func setupTabs(){
        tabView.backgroundColor = .clear
        for obj in arrSubCategoty {
            tabView.tabs.append(Tab(icon: nil, title: obj.name ?? "", id: obj.id ?? ""))
        }
        if arrSubCategoty.count > 0 {
            intSubcategory =  arrSubCategoty[0].id ?? "0"
        }
        
        tabView.tabMode = .fixed
        tabView.titleColor = .black
        tabView.indicatorColor = UIColor.init(named: "ButtonColor")!
        tabView.backgroundColor = .clear
        tabView.delegate = self
        tabView.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
        homeVM.saveBoatListData(search: "", category: objCategory?.id ?? 0, sub_category: Int(intSubcategory) ?? 0, page: intPage)
        boatTableView.tableHeaderView = viewHeader
        viewHeader.frame.size.width = boatTableView.frame.size.width

        getBoatList()
    }
    
    /// get boat list api
    private func getBoatList(_ isShowLoader: Bool = true) {
        homeVM.getBoatList(isShowLoader) { sucess in
            self.arrBoatlist = [BoatListDataModel]()
            if sucess {
                if let boat = self.homeVM.objBoatListDataModel?.data {
                    self.arrBoatlist = boat
                }
            }
            self.lblNoData.isHidden = self.arrBoatlist.count > 0 ? true: false
            self.boatTableView.reloadData()
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.poptoViewController()
    }
    
    @IBAction func notificationTapped(_ sender: Any) {
        self.pushVC(controller: NotificationVC.instantiate())
    }
}

extension BoatsVC : UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBoatlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = boatTableView.dequeueReusableCell(withIdentifier: "AllBoatsTableCell", for: indexPath) as? AllBoatsTableCell else {return UITableViewCell() }
        cell.ratingLabel.isHidden = true
        cell.mapButton.isHidden = true
        cell.parkedButton.isHidden = true
        cell.cellConfig(with: arrBoatlist[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BoatDetailVC.instantiate()
        vc.objBoatListDataModel  = arrBoatlist[indexPath.row]
        self.pushVC(controller: vc)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        if searchText.count > 2 {
            intPage = 1
            homeVM.saveBoatListData(search: searchText, category: objCategory?.id ?? 0, sub_category: Int(intSubcategory) ?? 0, page: intPage)
            getBoatList(false)
        }else if searchText.count == 0{
            intPage = 1
            homeVM.saveBoatListData(search: "", category: objCategory?.id ?? 0, sub_category: Int(intSubcategory) ?? 0, page: intPage)
            getBoatList(false)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(searchBar.text)")
        intPage = 1
        homeVM.saveBoatListData(search: searchBar.text ?? "", category: objCategory?.id ?? 0, sub_category: Int(intSubcategory) ?? 0, page: intPage)
        getBoatList(false)

    }

}
