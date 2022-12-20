//
//  AllBoatsVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 25/09/22.
//

import UIKit

class AllBoatsVC: UIViewController, StoryboardSceneBased, AllBoatsDelegate {
   
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.booking.rawValue, bundle: nil)
    
    let urlDataProvider = URLDataProvider()
    var avaialableArray = [AvailableParking]()
    var ownerBoatID = Int()

    @IBOutlet weak var locationLabel: UIButton!
    @IBOutlet weak var boatsCollectionView: UICollectionView!{
        didSet{
            boatsCollectionView.register(UINib(nibName: "AllBoatsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "AllBoatsCollectionCell")
        }
    }
    @IBOutlet weak var boatsTableView: UITableView!{
        didSet{
            boatsTableView.register(UINib(nibName: "AllBoatsTableCell", bundle: nil), forCellReuseIdentifier: "AllBoatsTableCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAvailableParkings()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openMaptapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
        self.navigationController?.isHeroEnabled = true
        self.navigationController?.heroNavigationAnimationType = .zoom
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.poptoViewController()
    }
    
    func getAvailableParkings(){
        let requestBody :[String:Any] = ["page":1]
        urlDataProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/parking-list")!, httpMethod: RequestMethod.post, requestBody: requestBody.percentEncoded(), resultType: BaseResponse<[AvailableParking]>.self) { result, statusCode, isSuccess, error in
            if isSuccess{
                self.avaialableArray = result?.data ?? []
                DispatchQueue.main.async {
                    self.boatsTableView.reloadData()
                }
            }
        }
    }
    
    func viewOnMapTapped(tag: Int) {
        let vc = LocationVC.instantiate()
        vc.isFrom = "Maps"
        vc.availableParking = avaialableArray[tag]
        vc.ownerBoatID = self.ownerBoatID
        self.pushVC(controller: vc)
    }
    
    func parkNowTapped(tag: Int) {
        let vc = LocationVC.instantiate()
        vc.availableParking = avaialableArray[tag]
        vc.ownerBoatID = self.ownerBoatID
        self.pushVC(controller: vc)
    }
}


//MARK: - UITableView Setup
extension AllBoatsVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avaialableArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = boatsTableView.dequeueReusableCell(withIdentifier: "AllBoatsTableCell", for: indexPath) as? AllBoatsTableCell else {return UITableViewCell() }
        cell.mapButton.tag = indexPath.row
        cell.parkedButton.tag = indexPath.row
        cell.delegate = self
        cell.cellConfigParking(with: avaialableArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.avaialableArray[indexPath.row].parkingStatus != "parked"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
            vc.availableParking = avaialableArray[indexPath.row]
            vc.ownerBoatID = self.ownerBoatID
            self.navigationController?.isHeroEnabled = true
            self.navigationController?.heroNavigationAnimationType = .zoom
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
        
}

//MARK: - UICollectionView Setup
extension AllBoatsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = boatsCollectionView.dequeueReusableCell(withReuseIdentifier: "AllBoatsCollectionCell", for: indexPath) as? AllBoatsCollectionCell else {return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.boatsCollectionView.frame.width/4, height: 100)
    }
    
}
