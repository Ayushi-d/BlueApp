//
//  LocationVC.swift
//  BLUE
//
//

import UIKit
import Hero
import MapKit
import CoreLocation
//import GoogleMaps

class LocationVC: UIViewController, StoryboardSceneBased, MKMapViewDelegate {
    
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.booking.rawValue, bundle: nil)

    @IBOutlet weak var parkingTableVIew: UITableView!{
        didSet{
            parkingTableVIew.register(UINib(nibName: "AllBoatsTableCell", bundle: nil), forCellReuseIdentifier: "AllBoatsTableCell")
        }
    }
    @IBOutlet weak var nextView: UIView!
    
    var ownerBoatID = Int()
    @IBOutlet weak var mapView: MKMapView!
    var availableParking : AvailableParking?
    @IBOutlet weak var gMapVIew: UIView!
    var isFrom = ""
    @IBOutlet weak var upperView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextView.isHidden = isFrom == "Maps" ? true : false
        let lat = Double(availableParking?.lat ?? "0.0")
        let long = Double(availableParking?.long ?? "0.0")
        let coordinate = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: long ?? 0.0)
        mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        mapView.delegate = self
        addCustomPin(coordinate: coordinate)
        //GMSServices.provideAPIKey("AIzaSyCYISBUr25Gne9q7F9oBQPSqa0cKZVF3z0")
       // setupMap()
    }

    func addCustomPin(coordinate: CLLocationCoordinate2D){
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else{
            return nil
        }
        var annotaionView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotaionView == nil{
            annotaionView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        }else{
            annotaionView?.annotation = annotation
        }
        annotaionView?.image = UIImage.init(named: "ic_marker")
        return annotaionView
    }
    
//    func setupMap(){
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        gMapVIew = mapView
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = availableParking?.name ?? ""
//        //marker.snippet = "Australia"
//        marker.map = mapView
//    }
    
//    func setupMac(){
//        let lattitude = Double(availableParking?.lat ?? "0.0")
//        let longitude = Double(availableParking?.long ?? "0.0")
//        let center = CLLocationCoordinate2D(latitude: 30.715260, longitude: 76.707771)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 76.707771, longitudeDelta: 76.707771))
//        self.mapView.setRegion(region, animated: true)
//    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.poptoViewController()
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingsVC") as! BookingsVC
        vc.availableData = availableParking
        vc.ownerBoatID = ownerBoatID
        self.navigationController?.isHeroEnabled = true
        self.navigationController?.heroNavigationAnimationType = .zoom
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
}

//MARK: - UITableView Setup
extension LocationVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = parkingTableVIew.dequeueReusableCell(withIdentifier: "AllBoatsTableCell", for: indexPath) as? AllBoatsTableCell else {return UITableViewCell() }
        cell.boatprice.font = UIFont.boldSystemFont(ofSize: 16)
        cell.mapButton.isHidden = true
        cell.parkedButton.isHidden = true
        cell.ratingLabel.isHidden = false
        guard let availableData = availableParking else {return UITableViewCell()}
        cell.cellConfigParking(with: availableData)
        return cell
    }
        
}

