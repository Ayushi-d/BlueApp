//
//  ParkingDetailsVC.swift
//  BLUE
//
//

import UIKit
import MapKit

class ParkingDetailsVC: UIViewController, StoryboardSceneBased, MKMapViewDelegate {
    
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.parking.rawValue, bundle: nil)

    var objParkingData : MyParkingModel?

    @IBOutlet weak var parkingAddress: AppBaseLabel!
    @IBOutlet weak var parkingName: AppBaseLabel!
    @IBOutlet weak var boatName: AppBaseLabel!
    @IBOutlet weak var boatImage: UIImageView!
    @IBOutlet weak var totalPrice: AppBaseLabel!
    @IBOutlet weak var parkingTime: AppBaseLabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var parkingDate: AppBaseLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    func loadData(){
        
        self.parkingAddress.text = objParkingData?.address ?? ""
        self.parkingName.text = objParkingData?.parking_name ?? ""
        self.boatName.text = objParkingData?.boat_name ?? ""
        self.totalPrice.text = objParkingData?.price ?? ""
        self.parkingDate.text = self.objParkingData?.from_date?.servertoShortDate() ?? ""
        self.parkingTime.text = (self.objParkingData?.from_date ?? "").servertoShortTime() + " to " + (self.objParkingData?.to_date ?? "").servertoShortTime()
        let lat = Double(objParkingData?.lat ?? "0.0")
        let long = Double(objParkingData?.long ?? "0.0")
        let coordinate = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: long ?? 0.0)
        mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        mapView.delegate = self
        addCustomPin(coordinate: coordinate)
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

    @IBAction func backBtn(_ sender: Any) {
        self.poptoViewController()
    }
}
