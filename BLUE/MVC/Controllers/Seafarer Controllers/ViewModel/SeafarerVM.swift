//
//  SeafarerVM.swift
//  BLUE
//
//  Created by Bhikhu on 18/10/22.
//

import Foundation
import UIKit
import Moya

class SeafarerVM: NSObject {

    // MARK: - Private Properties
    private var isAPICalling = false
    public var objSeafarerModel: SeafarerModel?
    public var apiRequest: Cancellable?
    public var objSeafarerCategory: SeafarerCategoryModel?

    
    private var name: String!
    private var phone_no: String!
    private var nationality: String!
    private var category: String!
    private var language: String!
    private var experince: String!
    private var baot_experince: String!
    private var license_number: String!
    private var age: String!
    private var images: [String]!



    
    public var page: Int?

    public func saveSeafarerData(page: Int) {
        self.page = page
    }
    
    public func addSeafarerData(name: String,
                                phone_no: String,
                                nationality: String,
                                category: String,
                                language: String,
                                experince: String,
                                baot_experince: String,
                                license_number: String,
                                images: [String],
                                age: String){
        self.name = name
        self.phone_no = phone_no
        self.nationality = nationality
        self.category = category
        self.language = language
        self.experince = experince
        self.baot_experince = baot_experince
        self.license_number = license_number
        self.images = images
        self.age = age
        
    }

    /// - Parameter completion: get callback for completion
  
    /// Function to get category and subcategory details -
    /// - Parameter completion: get callback for completion
    public func getSeafrerList(_ isShowLoader: Bool = true, completion: @escaping (Bool) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        
        var param: [String: Any] = [:]
        param[API.Key.page] = page
        
        Network.request(Service.getSeafarerList(param: param), isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].array, !aDictMetaData.isEmpty {
                    let aTempModel = SeafarerModel(object: aResponse)
                    self.objSeafarerModel = aTempModel
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }

    }
    
    public func getSeafararCategory(_ isShowLoader: Bool = true, completion: @escaping (Bool) -> Void) {
//        if isAPICalling { return }
        isAPICalling = true
        Network.request(Service.seafarerCategory, isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].array, !aDictMetaData.isEmpty {
                    let aTempModel = SeafarerCategoryModel(object: aResponse)
                    self.objSeafarerCategory = aTempModel
                    print(aDictMetaData,"sdfghj")
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }

    }
    
    public func addSeafrer(_ isShowLoader: Bool = true, completion: @escaping (Bool, String) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        var param: [String: Any] = [:]
        param[API.Key.name] = name
        param[API.Key.phone_no] = phone_no
        param[API.Key.nationality] = nationality
        param[API.Key.age] = age
        param[API.Key.category] = category
        param[API.Key.language] = language
        param[API.Key.experince] = experince
        param[API.Key.baot_experince] = baot_experince
        param[API.Key.license_number] = license_number
        param[API.Key.images] = images
        Network.request(Service.addSeafarerList(param: param), isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                 let message = aResponse[API.Response.message].string
                completion(true, message ?? "Success")
            } else {
                completion(false,"error")
            }
        }

    }
    
    public func callWSUploadImage( file: String ,completion: @escaping ((Bool, UploadImage?) -> Void)) {
        var param: [String: Any] = [:]
        param[API.Key.str_extension]  = ".jpeg"
        param[API.Key.str_file] = file
        let service = Service.UploadImage(param: param)
        Network.request(service) { (aResponse) in
            if let response = aResponse {
                if let aDictMetaData = response[API.Response.data].dictionary, !aDictMetaData.isEmpty {
                    let aTempModel = UploadImage(object: response)
                    completion(true, aTempModel)
                } else {
                    completion(false, nil)
                }
            } else {
                completion(false, nil)
            }
        }
    }
    
}
