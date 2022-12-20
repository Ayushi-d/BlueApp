//
//  AddBoatViewModel.swift
//  BLUE
//
//  Created by Bhikhu on 27/10/22.
//

import Foundation

class AddBoatViewModel {

    private var name: String!
    private var height: String!
    private var width: String!
    private var image: [String]!
    private var boat_type: String!
    public var objBoatDataModel: AddBoatModel?    
    

    /// Closure to be executed when a request has completed.
    internal typealias Completion = (User?) -> Void


    /// save user details
    /// - Parameters:
    ///   - email: pass email/phone in string
    ///   - password: password description
    public func saveAddData(name: String,
                            height: String,
                            width: String,
                            boat_type: String,
                            image: [String]) {
        self.name = name
        self.height = height
        self.width = width
        self.boat_type = boat_type
        self.image = image
    }
    /// password
    /// - Parameter completion: as
    /// - Returns: s
    public func callWSAddBoat( completion: @escaping ((Bool, Int?) -> Void)) {
        var param: [String: Any] = [:]
        param[API.Key.name]  = self.name
        param[API.Key.height] = height
        param[API.Key.width] = width
        param[API.Key.image] = image
        param[API.Key.boat_type] = boat_type
        let service = Service.addBoat(param: param)
        Network.request(service) { (aResponse) in
            if aResponse?[API.Response.message] == "Success" {
                //completion(true)
                if let aDictMetaData = aResponse?[API.Response.data].dictionary, !aDictMetaData.isEmpty {
                    let aTempModel = AddBoatModel(object: aResponse)
                    self.objBoatDataModel = aTempModel
                    completion(true,aTempModel.data!.boatId!)
                } else {
                    completion(false,nil)
                }
//                if let aDictData = aResponse?[API.Response.data].dictionary {
//                    // ✅ Success Data is received from the server.
//                    let boatID = aDictData["boat_owner_id"] as! Int
//                    completion(true,boatID)
//                }
            }
          
        }
    }
    /// password
    /// - Parameter completion: as
    /// - Returns: s
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
