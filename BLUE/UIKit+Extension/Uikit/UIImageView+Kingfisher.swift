//
//  UIImageView+Kingfisher.swift
//  Unicorn
//
//  Created by Unicorn 12/04/21.
//  Copyright © 2021 Unicorn Ltd. All rights reserved.
//

import UIKit
import Kingfisher


extension UIImageView {

    
    /// set global cotent mode
    func setContentModelFit()  {
        self.contentMode = .scaleAspectFit
    }
    
    /// - Util function to add image with caching
    func setImageUsingKF(string: String?, placeholder: UIImage? , isFited: Bool = true) {
        ///  ====  Append base media path here
        let updatedString = (UDManager.baseURLPath ?? "") + (string ?? "")
        self.kf.setImage(with: URL(string: updatedString), placeholder: placeholder, options: [.cacheOriginalImage])
        if isFited {
            
            self.setContentModelFit()
        } 
        
    }
    
    
    /// for image rounde
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }

    
    /// - Util function to add image with caching
    func setImageUsingKFForCountry(string: String?, placeholder: UIImage?) {
        let updatedString =   "https://www.countryflags.io/" + (string ?? "") + "/flat/64.png"
        self.kf.setImage(with: URL(string: updatedString), placeholder: placeholder, options: [.cacheOriginalImage])
    }


    func isEqualToImage(_ image: UIImage) -> Bool {
        return self.image?.pngData() == image.pngData()
    }

    func setImage(withURL url: String, toShowIndicator: Bool = true, placeholderImage: UIImage?) {
        let updatedString = (UDManager.baseURLPath ?? "") + (url )
        let activityIndicator = UIActivityIndicatorView()
        if toShowIndicator {
            self.layoutIfNeeded()
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
            self.addSubview(activityIndicator)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                activityIndicator.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
            }
        }

        self.kf.setImage(with: URL(string: updatedString), placeholder: placeholderImage, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: { (_) in
            if toShowIndicator {
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                }
            }
        })
    }
}


extension UIImage
{
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {

        let size = self.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? self

    }
    func getSizeIn(_ type: DataUnits) -> Double {
        guard let data = resizeImage() else {
            return 0
        }

        var size: Double = 0.0

        switch type {
        case .byte:
            size = Double(data.count)
        case .kilobyte:
            size = Double(data.count) / 1024
        case .megabyte:
            size = Double(data.count) / 1024 / 1024
        case .gigabyte:
            size = Double(data.count) / 1024 / 1024 / 1024
        }

        return size
    }
    
    public enum DataUnits: String {
        case byte, kilobyte, megabyte, gigabyte
    }

    // image compression
    func resizeImage() -> Data? {
        var actualHeight = Float(size.height)
        var actualWidth = Float(size.width)
        let maxHeight: Float = 800.0
        let maxWidth: Float = 800.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 1.0
        // 50 percent compression

        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                // adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            } else if imgRatio > maxRatio {
                // adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            } else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }

        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img!.jpegData(compressionQuality: CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return imageData
    }
}
