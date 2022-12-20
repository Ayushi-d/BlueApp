//
//  TImeSlotVM.swift
//  BLUE
//
//  Created by MacBook M1 on 17/11/22.
//

import Foundation
import UIKit
import Moya
import SwiftyJSON

class TimeSlotVM: NSObject {

    // MARK: - Private Properties
    private var isAPICalling = false
    public var objTimeSlotDataModel: TimeSlotModel?
    public var apiRequest: Cancellable?
    
    public var startTime: String?
    public var endTime:String?
    
    public func saveTimeSlotData(startTime: String,endTime: String) {
        self.endTime = endTime
        self.startTime = startTime
    }

    /// - Parameter completion: get callback for completion
    public func getAvailableTimeSlot(_ isShowLoader: Bool = true, completion: @escaping (Bool,[String: Any]?) -> Void) {
        if isAPICalling { return }
        isAPICalling = true
        var param: [String: Any] = [:]
        param[API.Key.startTime] = startTime
        param[API.Key.endTime] = endTime
        
        Network.request(Service.checkTimeslot(param: param), isShowLoader: isShowLoader) { (jsonResponse) in
            self.isAPICalling = false
            if let aResponse = jsonResponse {
                if let aDictMetaData = aResponse[API.Response.data].dictionary, !aDictMetaData.isEmpty {
                    let aTempModel = TimeSlotModel(object: aResponse)
                    self.objTimeSlotDataModel = aTempModel
                    completion(true,aDictMetaData)
                } else {
                    completion(false,nil)
                }
            } else {
                completion(false,nil)
            }
        }

    }
}
