//
//  HomeViewModel.swift
//  BLUE
//
//  Created by Bhikhu on 18/10/22.
//

import Foundation
import Foundation
import UIKit
import Moya

class HomeViewModel: NSObject {

    // MARK: - Private Properties
    private var isAPICalling = false
    public var objBoatListDataModel: BoatListModel?
    public var objHomeDataModel: HomeModel?
    public var objReviewDataModel: ReviewListModel?
    public var apiRequest: Cancellable?
    
    
    public var search: String?
    public var category: Int?
    public var sub_category: Int?
    public var page: Int?
    public var boat_booking_id: Int?
    public var rating: String?
    public var descriptio: String?
    public var entity: String?
    
    
    /// save boat list data
    /// - Parameters:
    ///   - search: String
    ///   - category: Int
    ///   - sub_category: Int
    ///   - page: Int
    public func saveBoatListData(search: String,
                                 category: Int,
                                 sub_category: Int,
                                 page: Int) {
        self.search = search
        self.category = category
        self.sub_category = sub_category
        self.page = page
    }
    ///
    public func saveAddReviewData(boatid: Int,rating: String,description: String,entity:String){
        self.rating = rating
        self.descriptio = description
        self.entity = entity
        self.boat_booking_id = boatid
    }
    ///
    public func saveReviewListData(boat_booking_id: Int){
        self.boat_booking_id = boat_booking_id
    }

    
    /// Function to get Boat List -
    ///
    public func getBoatCategory(_ isShowLoader: Bool = true, completion: @escaping (Bool) -> Void) {
        if isAPICalling { return }
        isAPICalling = true

        Network.request(Service.categorysubcategory, isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].dictionary, !aDictMetaData.isEmpty {
                    let aTempModel = HomeModel(object: aResponse)
                    self.objHomeDataModel = aTempModel
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }

    }

    /// - Parameter completion: get callback for completion
    public func getBoatList(_ isShowLoader: Bool = true, completion: @escaping (Bool) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        var param: [String: Any] = [:]
        param[API.Key.search] = self.search
        param[API.Key.category] = category
        param[API.Key.sub_category] = sub_category
        param[API.Key.page] = page

        Network.request(Service.getBoatList(param: param), isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].array, !aDictMetaData.isEmpty {
                    let aTempModel = BoatListModel(object: aResponse)
                    self.objBoatListDataModel = aTempModel
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }

    }
    
    ////////
    public func getReviewList(_ isShowLoader: Bool = true, completion: @escaping (Bool) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        var param: [String: Any] = [:]
        param[API.Key.boat_booking_id] = self.boat_booking_id
       

        Network.request(Service.getReviewList(param: param), isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].dictionary, !aDictMetaData.isEmpty {
                    let aTempModel = ReviewListModel(object: aResponse)
                    self.objReviewDataModel = aTempModel
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }

    }
    ////
    public func addReview(_ isShowLoader: Bool = true, completion: @escaping (Bool) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        var param: [String: Any] = [:]
        param[API.Key.boat_booking_id] = self.boat_booking_id
        param[API.Key.rating] = self.rating
        param[API.Key.entity_id] = self.entity
        param[API.Key.description] = self.descriptio

        Network.request(Service.getReviewList(param: param), isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].array, !aDictMetaData.isEmpty {
//                    let aTempModel = ReviewListModel(object: aResponse)
//                    self.objReviewDataModel = aTempModel
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }

    }
    public func rating( completion: @escaping ((Bool) -> Void)) {
        var param: [String: Any] = [:]
         
       
        param[API.Key.boat_booking_id] = self.boat_booking_id
        param[API.Key.rating] = self.rating
        param[API.Key.entity_id] = self.entity
        param[API.Key.description] = self.descriptio
        
        let service = Service.getReviewList(param: param)
        Network.request(service) { (aResponse) in
            if let aDictData = aResponse?[API.Response.data].dictionary {
                // ✅ Success Data is received from the server.
                
                completion(true)
                // Handle success reponse.
            }else{
                completion(false)
            }
        }
    }

}
