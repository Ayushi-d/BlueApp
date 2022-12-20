//
//  AppKey.swift
//  BLUE
//
//  Created by Bhikhu on 16/10/22.
//

import Foundation

/// added all private key in cococa keys
struct AppKey {
    
    //static let key = "(G+KbPeSgVkYp3s6v9y$B&E)H@McQfTj"
    static let key : [UInt8] = [115, 101, 9, 22, 57, 114, 71, 14, 60, 116, 73, 4, 43, 17, 81, 107, 45, 27, 91, 121, 25, 4, 103, 116, 19, 98, 111, 62, 10, 68, 118, 55]
    
    
    //static let iv = "-JaNdRgUkXp2s5v8"
    static let iv : [UInt8] = [118, 104, 67, 19, 63, 112, 69, 8, 48, 122, 82, 111, 40, 23, 84, 101]
    
    //    static let ServerClientID =  "367539001722-7ts52rlapjlvcgh07fmn2kk0va6hgsqe.apps.googleusercontent.com"
    static let ServerClientID : [UInt8] = [104, 20, 21, 104, 104, 27, 18, 109, 106, 21, 16, 111, 118, 21, 86, 46, 110, 16, 80, 49, 58, 82, 72, 49, 45, 65, 69, 53, 107, 21, 68, 48, 53, 16, 73, 54, 107, 84, 67, 107, 51, 69, 81, 44, 62, 12, 67, 45, 43, 81, 12, 58, 52, 77, 69, 49, 62, 87, 81, 56, 41, 65, 77, 51, 47, 71, 76, 41, 117, 65, 77, 48]
    
    
    //static let GoogleMap     = "AIzaSyBmVi2uPl08KdCzE8dc8EHwdAGDpJVEbfI"
    static let GoogleMap : [UInt8] = [26, 107, 88, 60, 8, 91, 96, 48, 13, 75, 16, 40, 11, 78, 18, 101, 16, 70, 97, 39, 30, 26, 70, 62, 99, 103, 106, 42, 63, 99, 101, 25, 43, 104, 116, 24, 57, 68, 107]
    
    
    //static let Stripe   = "pk_test_51IuaK5SGMjn8SZhVc632rvVF5FaaJY8uPCK80lftd9diw0W4L9r2dERRMgU2U0PQxmtBSjBS1sWzitBxnAAvFBTg000AGDaTJa"
    static let Stripe : [UInt8] = [43, 73, 125, 41, 62, 81, 86, 2, 110, 19, 107, 40, 58, 105, 23, 14, 28, 111, 72, 51, 99, 113, 120, 53, 13, 65, 20, 110, 105, 80, 84, 11, 29, 23, 100, 60, 58, 104, 123, 101, 46, 114, 97, 22, 99, 18, 78, 59, 47, 70, 27, 57, 50, 85, 18, 10, 111, 110, 27, 47, 105, 70, 103, 15, 9, 111, 69, 8, 105, 119, 18, 13, 10, 90, 79, 41, 25, 113, 72, 31, 8, 19, 81, 10, 33, 75, 86, 31, 35, 76, 99, 28, 45, 100, 96, 9, 60, 18, 18, 109, 26, 101, 102, 60, 15, 104, 67]
    
}


struct GoogleScope {
    static let arrScope =  [
        "https://www.googleapis.com/auth/calendar",
        "https://www.googleapis.com/auth/calendar.events"]

}
