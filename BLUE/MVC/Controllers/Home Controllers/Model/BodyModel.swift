//
//  BodyModel.swift
//  BLUE
//
//

import Foundation

struct BodyModel: Codable {
    var coupon_id, coupon_amount,total,grand_total,boat_id,destination_id,package_id,boat_category,start,end,boat_total,boat_grand_total: String?
    var product: [CartProductModel]?
    
    func toDict() -> [String:Any] {
        var dictionary = [String:Any]()
        if coupon_id != nil {
            dictionary["coupon_id"] = coupon_id
        }
        if coupon_amount != nil {
            dictionary["coupon_amount"] = coupon_amount
        }
        if total != nil {
            dictionary["total"] = total
        }
        if grand_total != nil {
            dictionary["grand_total"] = grand_total
        }
        if boat_id != nil {
            dictionary["boat_id"] = boat_id
        }
        if destination_id != nil {
            dictionary["destination_id"] = destination_id
        }
        if package_id != nil {
            dictionary["package_id"] = package_id
        }
        if boat_category != nil {
            dictionary["boat_category"] = boat_category
        }
        if start != nil {
            dictionary["start"] = start
        }
        if end != nil {
            dictionary["end"] = end
        }
        if boat_total != nil {
            dictionary["boat_total"] = boat_total
        }
        if boat_grand_total != nil {
            dictionary["boat_grand_total"] = boat_grand_total
        }
        if product != nil {
            var arrOfDict = [[String:Any]]()
            for item in product! {
                arrOfDict.append(item.toDict())
            }
            dictionary["product"] = arrOfDict
        }
    
        return dictionary
    }
}


struct CartProductModel:Codable{
    var type,product_id,grand_total,qty: String?
       
       func toDict() -> [String:Any] {
           var dictionary = [String:Any]()
           if type != nil {
               dictionary["type"] = type
           }
           if product_id != nil {
               dictionary["product_id"] = product_id
           }
           if grand_total != nil {
               dictionary["grand_total"] = grand_total
           }
           if qty != nil {
               dictionary["qty"] = qty
           }
           return dictionary
       }
}
