//
//  CustmerReviewVC.swift
//  BLUE
//
//  Created by Bhikhu on 14/10/22.
//

import UIKit
class CustmerReviewVC: UIViewController, StoryboardSceneBased {
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)

//    @IBOutlet weak var price: AppBaseLabel!
//    @IBOutlet weak var productDescription: AppBaseLabel!
//    @IBOutlet weak var productName: AppBaseLabel!
//    @IBOutlet weak var location: AppBaseLabel!
//    @IBOutlet weak var tblHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noReviewLabel: AppBaseLabel!
    var objBoatDetailsData: BoatDetailsData?
    var productDetails: ProductDetails?
    let urlProvider = URLDataProvider()
    var isFrom = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()
    }
    
    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        //setData()
        getReviewApi()
        tblView.register(cellType: ReviewCell.self)
        tblView.estimatedRowHeight = 115
        tblView.rowHeight = UITableView.automaticDimension
        
    }
    
    //View model
    private var homeVM: HomeViewModel = {
        return HomeViewModel()
    }()
    
    private var objReviewData = [CustomerReviewData]()
    //
    private func getReviewApi(){
        let requestBody: [String:Any] = ["boat_id": objBoatDetailsData?.id ?? 0]
        urlProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/boat-rating-list")!, httpMethod: RequestMethod.post , requestBody: requestBody.percentEncoded(),resultType: BaseResponse<[CustomerReviewData]>.self) { result, statusCode, isSuccess, error in
            if isSuccess{
                DispatchQueue.main.async {
                    self.objReviewData.removeAll()
                    self.objReviewData = result?.data ?? []
                    self.noReviewLabel.isHidden = self.objReviewData.count == 0 ? false : true
                    self.tblView.reloadData()
                }
            }
        }
       
    }
    // MARK: IB Actions
    @IBAction func btnHomeTapped(_ sender: Any) {
        self.pushVC(controller: BottomBarController.instantiate())

    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.poptoViewController()
    }
    
    
}
// MARK: UITableViewDelegate
extension CustmerReviewVC :UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return objReviewData.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell: ReviewCell = tableView.dequeueReusableCell(for: indexPath)
         aCell.cellConfig(object: objReviewData[indexPath.row])
        return aCell
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        Utility.delay(0) {
//            self.tblHeightConstant.constant = self.tblView.contentSize.height
//        }
//    }
//
//    func setData(){
//        price.text = "\(productDetails?.price ?? "0.0")KWD"
//        productName.text = productDetails?.name
//        productDescription.text = productDetails?.description
//    }
}
