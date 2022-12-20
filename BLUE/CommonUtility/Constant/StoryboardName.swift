//
//  Created by Bhikhu
//  Copyright © Bhikhu All rights reserved.
//  Created on 15/05/20

import Foundation
import UIKit

enum StoryboardName: String {
    case home = "Home"
    case bottomBarStoryBoard = "BottomBar"
    case seafarer = "Seafarer"
    case booking = "Booking"
    case parking = "Parking"
    case account = "Account"
    case main = "Main"

    var instance: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: MAIN_BUNDLE)
    }

    @discardableResult
    func instantiate<T: UIViewController>(viewController: T.Type, function: String = #function, line: Int = #line, file: String = #file) -> T {
        let storyboardID = (viewController as UIViewController.Type).storyboardID

        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(rawValue) Storyboard.\nFile: \(file) \nLine Number: \(line) \nFunction: \(function)")
        }

        return scene
    }

    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }

}

extension UIViewController {
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID: String {
        return "\(self)"
    }

    static func instantiate(fromStoryboard: StoryboardName) -> Self {
        return fromStoryboard.instantiate(viewController: self)
    }
}
