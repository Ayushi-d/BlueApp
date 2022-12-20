//
//  ProductVM.swift
//  BLUE
//
//  Created by MacBook M1 on 17/11/22.
//

import Foundation
import UIKit
import Moya

class ProductVM: NSObject {

    // MARK: - Private Properties
    private var isAPICalling = false
    public var objProductDataModel: ProductData?
    public var objProductDetailModel: ProductDetailData?
    public var objCategoryDataModel: ProductCategoryData?
    public var objSubCategoryDataModel: ProductSubCategoryData?
    public var apiRequest: Cancellable?
    
    public var page: Int?
    public var subcategory: String?
    public var type: String?
    public var category_id: String?
    public var id: Int?
    
    //-- save product list data
    public func saveProductData(page: Int,subcategory: String) {
        self.page = page
        self.subcategory = subcategory
    }
    //-- save product category data
    public func saveProductCategoryData(type: String) {
        self.type = type
        
    }
    //-- save product SubCategory data
    public func saveProductSubCategoryData(categoryId: String) {
        self.category_id = categoryId
    }
    //-- save product detail data
    public func saveProductDetailData(id: Int) {
        self.id = id
    }

    /// - Parameter completion: get callback for completion
    public func getProductListData(_ isShowLoader: Bool = true, completion: @escaping (Bool) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        var param: [String: Any] = [:]
        
        param[API.Key.page] = page
        param[API.Key.sub_category_id] = subcategory

        Network.request(Service.getProductList(param: param), isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].array, !aDictMetaData.isEmpty {
                    let aTempModel = ProductData(object: aResponse)
                    self.objProductDataModel = aTempModel
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
    public func getProductCategoryData(_ isShowLoader: Bool = true, completion: @escaping (Bool) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        var param: [String: Any] = [:]
        
        param[API.Key.type] = type
      
        
        Network.request(Service.getProductCategory(param: param), isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].array, !aDictMetaData.isEmpty {
                    let aTempModel = ProductCategoryData(object: aResponse)
                    self.objCategoryDataModel = aTempModel
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
    public func getProductSubCategoryData(_ isShowLoader: Bool = true, completion: @escaping (Bool) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        var param: [String: Any] = [:]
        param[API.Key.category_id] = category_id
        param[API.Key.page] = page
        Network.request(Service.getProductSubcategory(param: param), isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].array, !aDictMetaData.isEmpty {
                    let aTempModel = ProductSubCategoryData(object: aResponse)
                    self.objSubCategoryDataModel = aTempModel
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
    public func getProductdetailData(_ isShowLoader: Bool = true, completion: @escaping (Bool) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        var param: [String: Any] = [:]
        
        param[API.Key.id] = id
        Network.request(Service.getProductDetails(param: param), isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].dictionary, !aDictMetaData.isEmpty {
                    let aTempModel = ProductDetailData(object: aResponse)
                    self.objProductDetailModel = aTempModel
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
