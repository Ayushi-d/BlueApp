//
//  HomeVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 26/09/22.
//

import UIKit
import Hero
import CoreLocation

class HomeVC: UIViewController {

    @IBOutlet weak var locationLabel: UIButton!
    @IBOutlet weak var homeTableView: UITableView!{
        didSet{
            homeTableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        }
    }
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLocation()
        getHomeDataApi()
        
    }
    
    func getUserLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    //private func
    private lazy var homeVm: HomeViewModel={
        return HomeViewModel()
    }()
    private var objHomeData = [Category]()

    private func getHomeDataApi(){
        homeVm.getBoatCategory { [self] success in
            if success{
                self.objHomeData = (homeVm.objHomeDataModel?.data?.category)!
            }
            self.homeTableView.reloadData()
        }
    }
    
    @IBAction func fetchLocationTapped(_ sender: Any) {
        switch(CLLocationManager.authorizationStatus()) {
        case .authorizedAlways, .authorizedWhenInUse:
            self.getUserLocation()
        case .notDetermined, .restricted, .denied:
            showLocationPermissionAlert()
        @unknown default:
            print("")
        }
    }
    
    func showLocationPermissionAlert(){
        let alertController = UIAlertController(title: "Blue", message: "Please go to Settings and turn on the Loaction permissions", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
          self.present(alertController, animated: true)

    }
    
}

//MARK: - UITableView Setup
extension HomeVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objHomeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeTableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeCell else {return UITableViewCell() }
        if indexPath.row % 2 == 0{
            cell.boatImage.image = UIImage.init(named: "ic_yacht")
            cell.boatLabel.text = "Yacht"
            cell.viewLayer.backgroundColor = UIColor.Color.colorC7E2FE
        }else{
            cell.boatImage.image = UIImage.init(named: "ic_boats")
            cell.boatLabel.text = "Boats"
            cell.viewLayer.backgroundColor = UIColor.Color.colorD6F0F5
        }
        cell.cellConfig(with: objHomeData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BoatsVC.instantiate()
              vc.objCategory = objHomeData[indexPath.row]
              if let sub = homeVm.objHomeDataModel?.data?.subCategory {
                  vc.arrSubCategoty = sub
              }
              self.pushVC(controller: vc)
    }
    
}

extension HomeVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location ?? CLLocation(), completionHandler: {(placemarks, error)->Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription ?? "error"))
                    return
                }
            guard let placeMark = placemarks else {return}
            if placeMark.count > 0 {
                let pm = placeMark[0] as CLPlacemark
                self.displayLocationInfo(placemark: pm)
                } else {
                    print("Problem with the data received from geocoder")
                }
            })
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
        self.locationLabel.setTitle((placemark.locality ?? "") + "," + (placemark.country ?? "") , for: .normal)
        
    }
}
