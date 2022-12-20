//
//  Enum.swift
//  BLUE
//
//  Created by Bhikhu on 16/10/22.
//

import Foundation
import UIKit

enum MimeType {

    case VideoMP4
    case VideoMOV
    case ImageJPG

    var type: String {
        switch self {
        case .VideoMP4:
            return "video/mp4"
        case .VideoMOV:
            return "video/quicktime"
        case .ImageJPG:
            return "image/jpeg"
        }
    }
}

public enum RegistationType: String {

    case normal
    case facebook
    case linkedin
    case apple

}

enum VideoType: String, CaseIterable{
    case avi = "avi"
    case flv = "flv"
    case mp4 = "mp4"
    case mpeg = "mpeg"
    case mpeg4 = "mpeg4"
    case threegpp = "3gpp"
    case threegp = "3gp"
    case move = "mov"
    case wmv = "wmv"

}
