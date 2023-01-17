//
//  BoatDetailVC.swift
//  BLUE
//
//

import UIKit
import Lightbox
import AVFoundation
import Cosmos
import MapKit

class BoatDetailVC: UIViewController, StoryboardSceneBased, LightboxControllerDismissalDelegate , MKMapViewDelegate{
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)

    @IBOutlet weak var noFacilitiesView: UIView!
    @IBOutlet weak var parkingMapView: MKMapView!
    @IBOutlet weak var boatImage: UIImageView!
    @IBOutlet weak var boatName: UILabel!
    @IBOutlet weak var boatPrice: UILabel!
    @IBOutlet weak var boatImagesCollectionView: UICollectionView!
    @IBOutlet weak var boatDescription: UILabel!
    @IBOutlet weak var facilitiesCollectionView: UICollectionView!
    @IBOutlet weak var pickUpAddress: UILabel!
    @IBOutlet weak var captainName: UILabel!
    @IBOutlet weak var bookNow: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    // MARK: Variable
    private lazy var boatDetailsVC: BoatViewModel = {
        return BoatViewModel()
    }()
    var isFrom = ""
    var arrfacilities = [Facilities]()
    var arrDestinationAddress = [DestinationAddress]()
    var arrPackage = [Packages]()
    var arrGallary = [BoatGallaryDataModel]()
    var objBoatDetailsData: BoatDetailsData?
    var objBoatListDataModel: BoatListDataModel?
    var id = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func addCustomPin(coordinate: CLLocationCoordinate2D){
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        parkingMapView.addAnnotation(pin)
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
    
    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        parkingMapView.delegate = self
        
        getBoeatDetailsAPI()
        if isFrom == ""{
            bookNow.isHidden = false
        }else{
            bookNow.isHidden = true
        }
    }
    func getBoeatDetailsAPI()  {
        if isFrom == ""{
            boatDetailsVC.saveBoatDetailsData(id: objBoatListDataModel?.id ?? 0)
        }else{
            boatDetailsVC.saveBoatDetailsData(id: id)
        }
      
        boatDetailsVC.getBoatDetails { succee in
            if succee {
                self.getGalleryAPI()
            }
        }
    }
    func getGalleryAPI(){
        if isFrom == ""{
            boatDetailsVC.saveBoatDetailsData(id: objBoatListDataModel?.id ?? 0)
        }else{
            boatDetailsVC.saveBoatDetailsData(id: id)
        }
        boatDetailsVC.getBoarGallary { succee in
            if succee {
                if let object =  self.boatDetailsVC.objBoatGallaryModel?.data {
                    self.arrGallary = object
                }
            }
            self.setData()
        }
    }
    func setData()  {
        if let object = boatDetailsVC.objBoatDetailsModel?.data {
            if object.count > 0 {
                
                objBoatDetailsData = object[0]
                ratingView.rating =  Double(objBoatDetailsData?.boatRating ?? "0.0") ?? 0.0
                pickUpAddress.text = objBoatDetailsData?.pickupAddress ?? ""
                captainName.text = "Salim Alsafi"
                boatName.text = objBoatDetailsData?.name ?? ""
                boatPrice.text = "Starting From " + (objBoatDetailsData?.startingFrom ?? "") + "KWD"
                boatDescription.text = objBoatDetailsData?.descriptionValue ?? ""
                boatImage.setImage(withURL: objBoatDetailsData?.featuredImage ?? "", toShowIndicator: true,placeholderImage: PlaceHolderImages.homelaceHolder)
                //boatImage.setImageUsingKF(string: objBoatDetailsData?.featuredImage ?? "", placeholder: PlaceHolderImages.homelaceHolder, isFited: false)
                self.facilitiesCollectionView.isHidden = objBoatDetailsData?.facilities?.count != 0 ? false : true
                if let objFacilities = objBoatDetailsData?.facilities {
                    arrfacilities = objFacilities
                }
                if let objDestinationAddress = objBoatDetailsData?.destinationAddress {
                    arrDestinationAddress = objDestinationAddress
                }
                if let objpackages = objBoatDetailsData?.packages {
                    arrPackage = objpackages
                }
                let lat = Double(objBoatDetailsData?.lat ?? "0.0")
                let long = Double(objBoatDetailsData?.long ?? "0.0")
                let coordinate = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: long ?? 0.0)
                parkingMapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
                addCustomPin(coordinate: coordinate)
            }
        }
        boatImagesCollectionView.reloadData()
        facilitiesCollectionView.reloadData()
    }
    
    @IBAction func viewWillTapped(_ sender: Any) {
        let vc = BoatGallaryVC.instantiate()
        vc.arrGallary = self.arrGallary
        self.pushVC(controller: vc)
    }
    
    @IBAction func bookNowTapped(_ sender: Any) {
        let vc =  SelectDateTimeVC.instantiate()
        vc.objBoatDetailsData = objBoatDetailsData
        self.pushVC(controller: vc)
    }
    
    @IBAction func reviewTapped(_ sender: Any) {
        let vc = CustmerReviewVC.instantiate()
        vc.objBoatDetailsData = self.objBoatDetailsData
        self.pushVC(controller: vc)
    }
    
    func lightboxControllerWillDismiss(_ controller: LightboxController) {}
}

extension BoatDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == facilitiesCollectionView {
            return arrfacilities.count
        } else if collectionView == boatImagesCollectionView {
            return arrGallary.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == boatImagesCollectionView{
            let cell = boatImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "BoatImagesCell", for: indexPath) as! BoatImagesCell
            cell.cellConfig(with: arrGallary[indexPath.row])
            return cell
        }else{
            let cell = facilitiesCollectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesCell", for: indexPath) as! FacilitiesCell
            cell.cellConfig(with: arrfacilities[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == boatImagesCollectionView{
            if VideoType.allCases.contains(where : {$0.rawValue == arrGallary[indexPath.row].image?.suffix(3) ?? "" }){
                showFullImage(tempImage: arrGallary[indexPath.row].image ?? "", isVideo: true)
            }else{
                showFullImage(tempImage: arrGallary[indexPath.row].image ?? "", isVideo: false)
            }
        }
        
    }
    
    func showFullImage(tempImage: String, isVideo : Bool)  {
        guard let aImageURL = URL(string: (UDManager.baseURLPath ?? "") + (tempImage)) else { return }

        let lightImage = isVideo ? LightboxImage(image: UIImage.init(named: "ic_placeholder")!, videoURL: aImageURL) : LightboxImage(imageURL: aImageURL)
        // Create an instance of LightboxController.
        let controller = LightboxController(images: [lightImage])
        
        // Set delegates.
//        controller.pageDelegate = self
        controller.dismissalDelegate = self
        
        // Use dynamic background.
        controller.dynamicBackground = true
        
        // Present your controller.
        self.present(controller, animated: true, completion: nil)
        

        
    }
}

class BoatImagesCell: UICollectionViewCell{
    @IBOutlet weak var img: UIImageView!

    func cellConfig(with object: BoatGallaryDataModel) {
//        if VideoType.allCases.contains(where : {$0.rawValue == object.image?.suffix(3) ?? "" }){
//            img.image = genrateVideoThumbnail(string: (UDManager.baseURLPath ?? "") + (object.image ?? ""))
//        }else{
        img.setImage(withURL: object.image ?? "", toShowIndicator: true,placeholderImage: PlaceHolderImages.homelaceHolder)
           // img.setImageUsingKF(string: object.image ?? "", placeholder: PlaceHolderImages.homelaceHolder,isFited: false)
       // }
    }
    
}

extension BoatImagesCell{
    
    func genrateVideoThumbnail(string: String) -> UIImage{
        var imageToShow = UIImage()
        DispatchQueue.main.async {
            AVAsset(url: URL(string: string)!).genrateThumbnail { image in
                DispatchQueue.main.async {
                    imageToShow = image!
                }
            }
        }
        return imageToShow
    }
}
