//
//  AddReviewVC.swift
//  BLUE
//
//  Created by MacBook M1 on 29/11/22.
//

import UIKit
import Cosmos

class AddReviewVC: UIViewController,StoryboardSceneBased  {
    
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)

    @IBOutlet weak var starView: CosmosView!
    @IBOutlet weak var feedbackText: UITextView!
    let urlProvider = URLDataProvider()
    var completionblock: ((Bool?) -> Void)?
    var objBoatDetailsData: BoatDetailsData?
    var productDetails: ProductDetails?
    var isFrom = ""
    var bookingID = ""
    var entityID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getReviewDetailApi()
    }
    //
    private var homeVM: HomeViewModel = {
        return HomeViewModel()
    }()
    //
    private func addReviewApi(){

        let requestBody: [String:Any] = ["rating" : "\(starView.rating)","description":feedbackText.text!,"entity_id":"\(entityID)","entity_type": "boat","boat_product_booking_id":bookingID]
        urlProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/review-add")!, httpMethod: RequestMethod.post , requestBody: requestBody.percentEncoded()) { result, statusCode, isSuccess, error in
            if isSuccess{
                DispatchQueue.main.async {
                    AlertMesage.show(.success, message: "Review Added!")
                    self.dismiss(animated: true)
                    self.completionblock?(true)
                }
            }
        }
    }
    
    private func getReviewDetailApi(){
        let requestBody: [String:Any] = ["boat_booking_id" : bookingID]
        urlProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/review-list")!, httpMethod: RequestMethod.post , requestBody: requestBody.percentEncoded(),resultType: BaseResponse<[ReviewBoatData]>.self) { result, statusCode, isSuccess, error in
            if isSuccess{
                DispatchQueue.main.async {
                    self.entityID = result?.data?[0].entity_id ?? 0
                }
            }
        }
    }
    
    
        
    
    
    @IBAction func addReviewTap(_ sender: UIButton){
        addReviewApi()
    }
    
    @IBAction func crossTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
