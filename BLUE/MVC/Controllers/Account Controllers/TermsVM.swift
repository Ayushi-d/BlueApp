//
//  TermsVM.swift
//  BLUE
//
//  Created by MacBook M1 on 25/11/22.
//

import Foundation
import Moya
import SwiftyJSON

class TermsVM: NSObject {

    // MARK: - Private Properties
    private var isAPICalling = false
    public var objTermsDataModel: TermsModel?
    public var apiRequest: Cancellable?
    
      /// - Parameter completion: get callback for completion
    public func getTerms(_ isShowLoader: Bool = true, completion: @escaping (Bool,TermsModel?) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        Network.request(Service.getTerms, isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].dictionary, !aDictMetaData.isEmpty {
                    let aTempModel = TermsModel(object: aResponse)
                    self.objTermsDataModel = aTempModel
                    completion(true, self.objTermsDataModel)
                } else {
                    completion(false,nil)
                }
            } else {
                completion(false,nil)
            }
        }

    }
    
    public func getRefundPolicy(_ isShowLoader: Bool = true, completion: @escaping (Bool, TermsModel?) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        Network.request(Service.refundPolicy, isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].dictionary, !aDictMetaData.isEmpty {
                    let aTempModel = TermsModel(object: aResponse)
                    self.objTermsDataModel = aTempModel
                    completion(true, self.objTermsDataModel)
                } else {
                    completion(false,nil)
                }
            } else {
                completion(false,nil)
            }
        }

    }
}
