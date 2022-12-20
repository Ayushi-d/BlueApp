//
//  AVAsset+Extension.swift
//  BLUE
//
//

import Foundation
import AVKit
import AVFoundation


extension AVAsset{
    func genrateThumbnail(completion: @escaping (UIImage?) -> Void){
        DispatchQueue.global().async {
            let imageGenrator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: 0.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            imageGenrator.generateCGImagesAsynchronously(forTimes: times) { _, image, _, _, _ in
                if let image = image{
                    completion(UIImage(cgImage: image))
                }else{
                    completion(nil)
                }
            }
        }
    }
    
}
