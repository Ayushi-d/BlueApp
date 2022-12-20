//
//  BaseResponse.swift
//  BLUE
//
//

import Foundation


struct BaseResponse<T:Codable>:Codable{
    var status: Int?
    var message: String?
    var type: String?
    var data :T?
    var review: T?
}

