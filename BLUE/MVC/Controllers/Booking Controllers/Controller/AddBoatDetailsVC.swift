//
//  AddBoatDetailsVC.swift
//  BLUE
//
//

import UIKit
import Hero

class AddBoatDetailsVC: UIViewController, StoryboardSceneBased {
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.booking.rawValue, bundle: nil)
    
    @IBOutlet weak var boatNameField: UITextField!
    @IBOutlet weak var boatHeightField: UITextField!
    @IBOutlet weak var boatWidthField: UITextField!
    @IBOutlet weak var boatTypeField: UITextField!
    @IBOutlet weak var boatImage1: UIImageView!
    @IBOutlet weak var boatImage2: UIImageView!
    
    // MARK: Variable
    private lazy var addBoatViewModel: AddBoatViewModel = {
        return AddBoatViewModel()
    }()
    
    var arrImage = [String]()
    var img1: String?
    var img2: String?
    var boatInfo: BoatInfoModel?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func dropdownTapped(_ sender: Any) {
        
    }
    
    @IBAction func addImage1Tapped(_ sender: Any) {
        ChooseImageOptions(isFromfirstImage: true)
    }
    
    @IBAction func addImage2Tapped(_ sender: Any) {
        ChooseImageOptions(isFromfirstImage: false)
    }
    // for add image in attachment
    private func ChooseImageOptions(isFromfirstImage: Bool) {
        ImagePicker.shared.showImagePicker(self, type: [ImagePicker.shared.image], isEditing: false) { _, infoDict in
            if let info = infoDict {
                var newImage: UIImage?
                if let possibleImage = info[.editedImage] as? UIImage {
                    newImage = possibleImage
                } else if let possibleImage = info[.originalImage] as? UIImage {
                    newImage = possibleImage
                }
                guard let image = newImage else { return }
                let maxWidth = min(800, image.size.width)
                let finalImage = newImage?.resizeImage(targetSize: CGSize(width: maxWidth, height: maxWidth))
                self.uploadBoatImage(isFromfirstImage: isFromfirstImage, file: finalImage?.toBase64() ?? "", img: image)
            }
        }
    }
    
    func uploadBoatImage(isFromfirstImage: Bool, file: String, img: UIImage)  {
        addBoatViewModel.callWSUploadImage(file: file) { sucess,uploadImage  in
            if sucess {
                if isFromfirstImage {
                    self.img1 = uploadImage?.data?.url ?? ""
                    self.boatImage1.image = img
                }  else {
                    self.img2 = uploadImage?.data?.url ?? ""
                    self.boatImage2.image = img
                }
            }
        }
    }
    
    @IBAction func procced_tapped(_ sender: Any) {
        if validateData() {
//            addBoatViewModel.callWSAddBoat { sucess, boatID in
//                if sucess {
//                    let vc =  AllBoatsVC.instantiate()
//                    vc.ownerBoatID = boatID ?? 0
//                    self.pushVC(controller: vc)
//                }
//            }
            let vc =  AllBoatsVC.instantiate()
            vc.boatInfo = self.boatInfo
            self.pushVC(controller: vc)
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.poptoViewController()
    }
    
}


/// Validate Value
/// - Returns: Bool

extension AddBoatDetailsVC {
    
    /// Validate Value
    /// - Returns: Bool
    private func validateData() -> Bool {
        if (boatNameField.text ?? "").isBlank{
            // 🚨 Blank Email
            boatNameField.shake()
            AlertMesage.show(.error, message: Localizable.validation.boatName)
            return false
        } else if (boatHeightField.text ?? "").isBlank{
            // 🚨 Blank Not Valid email
            boatHeightField.shake()
            AlertMesage.show(.error, message: Localizable.validation.height)
            return false
        } else if  (boatWidthField.text ?? "").isBlank {
            // 🚨 Blank Phone number
            boatWidthField.shake()
            AlertMesage.show(.error, message: Localizable.validation.widht)
            return false
        } else if  (boatTypeField.text ?? "").isBlank {
            // 🚨 Blank Phone number
            boatTypeField.shake()
            AlertMesage.show(.error, message: Localizable.validation.boatType)
            return false
        }  else if  (boatTypeField.text ?? "").isBlank {
            // 🚨 Blank Phone number
            boatWidthField.shake()
            AlertMesage.show(.error, message: Localizable.validation.boatType)
            return false
        } else if  img1 == nil  {
            boatImage1.shake()
            AlertMesage.show(.error, message: Localizable.validation.boatImage)
            return false
        } else if  img2 == nil  {
                boatImage2.shake()
                AlertMesage.show(.error, message: Localizable.validation.boatImage)
            return false
        }
        arrImage = [String]()
        arrImage.append(img1 ?? "sgsd")
        arrImage.append(img2 ?? "sgsety")
        addBoatViewModel.saveAddData(name: boatNameField.text ?? "", height: boatHeightField.text ?? "", width: (boatWidthField.text ?? ""), boat_type: (boatTypeField.text ?? ""), image: arrImage)
        boatInfo = BoatInfoModel(name: boatNameField.text ?? "", boatType: (boatTypeField.text ?? ""), boatWidth: (boatWidthField.text ?? ""), boatHeight: boatHeightField.text ?? "", boatImages: arrImage)
        // ✅(boatWidthField.text ?? "")
        return true
    }
}


extension AddBoatDetailsVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == boatTypeField {
            getBoatTyp()
        }
    }
    func getBoatTyp() {
        let arrStore = ["Luxury","Sailing","Sports"]
        PickerView.sharedInstance.addPicker((ROOT_FIRST_VC?.rootViewController)!, onTextField: boatTypeField, pickerArray: arrStore as? [String] ?? []) { index, value, isDismiss in
            if !isDismiss {
                self.boatTypeField.text = value
            }
            self.boatTypeField.resignFirstResponder()
        }
    }
}
