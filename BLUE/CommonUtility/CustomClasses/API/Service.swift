import Foundation
import Moya
import Alamofire
import SwiftyJSON
import UIKit

// 1:
// MARK: - API Services
enum Service {

    // -- User Login

    // Login user to the application.
    case login(param: [String: Any])
    
    case socaiLogin(param: [String: Any])

    // Register user to the application.
    case singUp(param: [String: Any])
    
    // Chnages Passsword to the application.
    case changePassword(param: [String: Any])
    
    case forgotPassword(param: [String: Any])

    case verifyPin(param: [String: Any])
    // Get farere category sub category
    case categorysubcategory
    
    // Get Boat list from sub category
    case getBoatList(param: [String: Any])
    
    // Updatr User Profile
    case userUpdate(param: [String: Any])
    
    case userUpdateSocail(param: [String: Any])
    
    //getReviews
    case getReviewList(param: [String: Any])
    
    case boatBooking(param: [String:Any])
    
    // Updatr User Profile
    case checkTimeslot(param: [String: Any])
    
    // get Boat Details
    case getBoatDetails(param: [String: Any])
    
    //getMyBoat
    case myBoats(param: [String: Any])
    
    // get Boat Gallery
    case getBoatGallary(param: [String: Any])
    
    case addReview(param: [String: Any])
    
    // get product-list
    case productList(param: [String: Any])
    
    // get product-list
    case parkingList(param: [String: Any])
    
    case bookingParkingList(param: [String:Any])
    
    // Add Boat
    case addBoat(param: [String: Any])
    
    //getSeafarer list
    case getSeafarerList(param: [String: Any])
    
    //addSeafarer
    case addSeafarerList(param: [String: Any])
    
    //get seafarerCategory
    case seafarerCategory
    
    //get product list
    case getProductList(param:[String:Any])
    
    //get product list
    case getProductCategory(param:[String:Any])
    
    //get product list
    case getProductDetails(param:[String:Any])
    
    //get product list
    case getProductSubcategory(param:[String:Any])
    
    // Upload Image
    case UploadImage(param: [String: Any])
    
    //Get terms and Condition
    case getTerms
    
    case refundPolicy

}


// 2:
extension Service: TargetType {

    /// The type of HTTP task to be performed.
    var task: Task {

        switch self {

        case .login(let param),
            .socaiLogin(let param),
            .changePassword(let param),
            .forgotPassword(let param),
            .verifyPin(let param),
            .getBoatList(let param),
            .userUpdate(let param),
            .userUpdateSocail(let param),
            .getReviewList(let param),
            .boatBooking(let param),
            .addReview(let param),
            .checkTimeslot(let param),
            .getBoatDetails(let param),
            .myBoats(let param),
            .productList(let param),
            .parkingList(let param),
            .bookingParkingList(let param),
            .getBoatGallary(let param),
            .addBoat(let param),
            .getSeafarerList(let param),
            .addSeafarerList(let param),
            .getProductList(let param),
            .getProductDetails(let param),
            .getProductCategory(let param),
            .getProductSubcategory(let param),
            .UploadImage(let param),
            .singUp(param: let param):
        return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        
        case  .categorysubcategory:
            return .requestPlain
            
        case .getTerms, .refundPolicy:
            return .requestPlain
            
        case .seafarerCategory:
            return .requestPlain

        
        }
    }

    /// The target's base `URL`.
    var baseURL: URL {

        if let url = URL(string: API.URL.BASE_URL) {
            return url
        }
        fatalError("UNABLE TO CREATE URL FOR API CALL")
    }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {

        switch self {

        // User Login Registration
        case .login:
            return "login"
        case .socaiLogin:
            return "social-login"
        case .singUp:
            return "register"
        case .changePassword:
            return "change-password"
        case .forgotPassword:
            return "forgotPassword"
        case .verifyPin:
            return "verifyPin"
        case .getBoatList:
            return "boats-list"
            
        case .userUpdate:
            return "update-user"
            
        case .userUpdateSocail:
            return "update-social-user"
            
        case .getReviewList:
            return "review-list"
            
        case .boatBooking:
            return "boat-booking"
            
        case .addReview:
            return "review-add"
            
        case .getBoatDetails:
            return "boats-detail"
        
        case .myBoats:
            return "list-owner-boat"
            
        case .productList:
            return "product-list"
            
        case .parkingList:
            return "parking-list"
            
        case .bookingParkingList:
            return "my-parking-booking"
            
        case .categorysubcategory:
            return "category-subcategory"
            
        case .addBoat:
            return "add-owner-boat"
            
        case .checkTimeslot:
            return "available-time-slots"
            
        case .getBoatGallary:
            return "gallery-images"
            
        case .UploadImage:
            return "upload-image"
        
        case .getSeafarerList:
            return "list-seafarer"
            
        case .addSeafarerList:
            return "add-seafarer"
            
        case .seafarerCategory:
            return "seafarer-category"
            
        case .getTerms:
            return "terms-service"
        case .refundPolicy:
            return "refund-policy"
        case .getProductList:
            return "product-list"
        case .getProductDetails:
            return "product-details"
        case .getProductCategory:
            return "product-category"
        case .getProductSubcategory:
            return "product-sub-category"
            
        }
    }

    /// The HTTP method used in the request.
    var method: Moya.Method {

        switch self {
        case  .categorysubcategory:
            return .get
        case .seafarerCategory:
            return .get
        case .getTerms, .refundPolicy:
            return .get
        default:
            return .post
        }
    }

    /// Provides stub data for use in testing.
    var sampleData: Data {
        return Data()
    }

    /// The headers to be used in the request.
    var headers: [String: String]? {

        if let userAuthToken = UserManager.shared.authToken {
            return ["Accept": "application/json",
                    "Authorization": "Bearer \(userAuthToken)"]
        }
        return ["Content-Type": "application/json"] // + aDictMetaData
    }

    func uploadTask(param: [String: Any]) -> Task {

        var arrBodyData: [Moya.MultipartFormData] = []
        for (key, value) in param {
            if let img = value as? UIImage {
                if let data: Data = img.jpegData(compressionQuality: 0.8) {
                    let strImageName = "thumbImage_\(Utility.timestamp).jpeg"

                    arrBodyData.append(MultipartFormData(provider: .data(data), name: key, fileName: strImageName, mimeType: MimeType.ImageJPG.type))
                }
            } else if let aUrl = value as? URL {
                if let videoData = try? Data(contentsOf: aUrl) {

                    let lastpath = aUrl.lastPathComponent.lowercased()

                    arrBodyData.append(MultipartFormData(provider: .data(videoData), name: key, fileName: lastpath, mimeType: aUrl.mimeType()))
                }
            } else {
                arrBodyData.append(MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: key))
            }
        }
        return .uploadMultipart(arrBodyData)
    }
}
