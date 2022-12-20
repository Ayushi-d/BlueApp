//
//  AddCaptainVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 28/09/22.
//

import UIKit

class AddCaptainVC: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var mobileNoField: UITextField!
    @IBOutlet weak var AgeField: UITextField!
    @IBOutlet weak var NationalityField: UITextField!
    @IBOutlet weak var languageField: UITextField!
    @IBOutlet weak var experienceField: UITextField!
    @IBOutlet weak var boatExpField: UITextField!
    @IBOutlet weak var licenseNoField: UITextField!
    @IBOutlet weak var licenseImage1: UIImageView!
    @IBOutlet weak var licenseImage2: UIImageView!
    
    var arrImage = [String]()
    var img1: String?
    var img2: String?

    private lazy var seafarerVM: SeafarerVM = {
        return SeafarerVM()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func image1Tapped(_ sender: Any){
        ChooseImageOptions(isFromfirstImage: true)

    }
    
    @IBAction func image2Tapped(_ sender: Any){
        ChooseImageOptions(isFromfirstImage: false)

    }
    
    @IBAction func addButtonTapped(_ sender: Any){
        if validateData(){
            seafarerVM.addSeafrer { isSuccess, message in
                if isSuccess{
                    AlertMesage.show(.success, message: message)
                    self.poptoViewController()
                }
            }
        }
    }
    
    @IBAction func backTapped(_ sender: Any){
        self.poptoViewController()
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
        seafarerVM.callWSUploadImage(file: file) { sucess,uploadImage  in
            if sucess {
                if isFromfirstImage {
                    self.img1 = uploadImage?.data?.url ?? ""
                    self.licenseImage1.image = img
                }  else {
                    self.img2 = uploadImage?.data?.url ?? ""
                    self.licenseImage2.image = img
                }
            }
        }
    }
    
}

extension AddCaptainVC {
    
    /// Validate Value
    /// - Returns: Bool
    private func validateData() -> Bool {
        if (nameField.text ?? "").isBlank{
            // 🚨 Blank Email
            nameField.shake()
            AlertMesage.show(.error, message: Localizable.validation.fisrtaname)
            return false
        } else if !(mobileNoField.text ?? "").isNumeric{
            // 🚨 Blank Not Valid email
            mobileNoField.shake()
            AlertMesage.show(.error, message: Localizable.validation.number)
            return false
        } else if  (AgeField.text ?? "").isBlank {
            // 🚨 Blank Phone number
            AgeField.shake()
            AlertMesage.show(.error, message: Localizable.validation.age)
            return false
        } else if  (NationalityField.text ?? "").isBlank {
            // 🚨 Blank Phone number
            NationalityField.shake()
            AlertMesage.show(.error, message: Localizable.validation.nationality)
            return false
        } else if  (languageField.text ?? "").isBlank {
            // 🚨 Blank Phone number
            languageField.shake()
            AlertMesage.show(.error, message: Localizable.validation.languages)
            return false
        } else if  (experienceField.text ?? "").isBlank {
            // 🚨 Blank Phone number
            experienceField.shake()
            AlertMesage.show(.error, message: Localizable.validation.experience)
            return false
        } else if  (boatExpField.text ?? "").isBlank {
            // 🚨 Blank Phone number
            boatExpField.shake()
            AlertMesage.show(.error, message: Localizable.validation.boatExperience)
            return false
        } else if  (licenseNoField.text ?? "").isBlank {
            // 🚨 Blank Phone number
            licenseNoField.shake()
            AlertMesage.show(.error, message: Localizable.validation.licenseNumber)
            return false
        }else if  img1 == nil  {
            licenseImage1.shake()
            AlertMesage.show(.error, message: Localizable.validation.liceneseImage)
            return false
        } else if  img2 == nil  {
            licenseImage2.shake()
                AlertMesage.show(.error, message: Localizable.validation.liceneseImage)
            return false
        }
        arrImage = [String]()
        arrImage.append(img1 ?? "sgsd")
        arrImage.append(img2 ?? "sgsety")
        
        seafarerVM.addSeafarerData(name: (nameField.text ?? ""), phone_no: (mobileNoField.text ?? ""), nationality: (NationalityField.text ?? ""), category: "1", language: (languageField.text ?? ""), experince: (experienceField.text ?? ""), baot_experince: (boatExpField.text ?? ""), license_number: (licenseNoField.text ?? ""),images: arrImage, age: AgeField.text ?? "")
        // ✅
        return true
    }
}

