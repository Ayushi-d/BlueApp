//
//  BoatViewModel.swift
//  BLUE
//
//  Created by Bhikhu on 19/10/22.
//

import Foundation

import Foundation
import Foundation
import UIKit
import Moya

class BoatViewModel: NSObject {

    // MARK: - Private Properties
    private var isAPICalling = false
    public var objBoatDetailsModel: BoatDetailsModel?
    public var objBoatGallaryModel: BoatGallaryModel?
    public var objMyBoatModel: MyBoatModel?
    public var apiRequest: Cancellable?
    
    
    public var id: Int?
    public var category: Int?
    public var sub_category: Int?
    public var page: Int?
    
    
    /// save boat list data
    /// - Parameters:
    ///   - search: String
    ///   - category: Int
    ///   - sub_category: Int
    ///   - page: Int
    public func saveBoatDetailsData(id: Int) {
        self.id = id
    }

    public func saveMyBoatData(page: Int){
        self.page = page
    }
    
    /// Function to get Boat Details -
    /// - Parameter completion: get callback for completion
    public func getBoatDetails(_ isShowLoader: Bool = true, completion: @escaping (Bool) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        var param: [String: Any] = [:]
        param[API.Key.id] = self.id
        Network.request(Service.getBoatDetails(param: param), isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].array, !aDictMetaData.isEmpty {
                    let aTempModel = BoatDetailsModel(object: aResponse)
                    self.objBoatDetailsModel = aTempModel
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }

    }
    
    /// Function to get Boat Details -
    /// - Parameter completion: get callback for completion
    public func getBoarGallary(_ isShowLoader: Bool = false, completion: @escaping (Bool) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        var param: [String: Any] = [:]
        param[API.Key.boat_id] = self.id
        Network.request(Service.getBoatGallary(param: param), isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].array, !aDictMetaData.isEmpty {
                    let aTempModel = BoatGallaryModel(object: aResponse)
                    self.objBoatGallaryModel = aTempModel
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }

    }
    //MYboats
    public func myBoats(_ isShowLoader: Bool = true, completion: @escaping (Bool) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        var param: [String: Any] = [:]
        param[API.Key.page] = self.page
        Network.request(Service.myBoats(param: param), isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].array, !aDictMetaData.isEmpty {
                    let aTempModel = MyBoatModel(object: aResponse)
                    self.objMyBoatModel = aTempModel
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
