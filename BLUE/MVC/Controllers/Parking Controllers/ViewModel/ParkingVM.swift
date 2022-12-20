//
//  ParkingVM.swift
//  BLUE
//
//  Created by MacBook M1 on 15/11/22.
//

import Foundation
import UIKit
import Moya

class ParkingVM: NSObject {

    // MARK: - Private Properties
    private var isAPICalling = false
    public var objParkingDataModel: MyBookParkingModel?
    public var apiRequest: Cancellable?
    
    public var page: Int?

    public func saveParkingListData(page: Int) {
        self.page = page
    }

    /// - Parameter completion: get callback for completion
    public func getPakingList(_ isShowLoader: Bool = true, completion: @escaping (Bool) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        var param: [String: Any] = [:]
        param[API.Key.page] = page

        Network.request(Service.bookingParkingList(param: param), isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].array, !aDictMetaData.isEmpty {
                    let aTempModel = MyBookParkingModel(object: aResponse)
                    self.objParkingDataModel = aTempModel
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }

    }
}
