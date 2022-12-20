//
//  Created by Bhikhu
//  Copyright © Bhikhu All rights reserved.
//  Created on 26/03/21

import UIKit

class AppBaseLabel: UILabel {
    enum LabelType: Int {

        case bold24 = 1
        case bold16 = 6
        case bold32 = 19
        case bold20 = 20
        case bold22 = 21

        case semiBold18 = 4
        case semiBold13 = 5
        case semibold13 = 14
        case semiBold15 = 7
        case semiBold16 = 8
        case semiBold11 = 9
        case semiBold12 = 11
        case semiBold17 = 16
        case semiBold24 = 23
        case semiBold22 = 24


        case regular18 = 2
        case regular15 = 3
        case regular11 = 15
        case regular13 = 10
        case regular16 = 12
        case regular20 = 13
        case regular12 = 17
        case regular14 = 18
        case regular24 = 22
    }

    // Programmatically: use the enum
    private var labelType: LabelType = .regular18

    // Left Padding Of Label
    @IBInspectable var leftInset: CGFloat = 0 {
        didSet {
            initialSetup()
        }
    }

    // Right Padding Of Label
    @IBInspectable var rightInset: CGFloat = 0 {
        didSet {
            initialSetup()
        }
    }

    // Change Style with Rounded Border, set by default yes
    @IBInspectable var isLabelRounded: Bool = false {
        didSet {
            initialSetup()
        }
    }

    // Change Style with Background Border, set by default clear
    @IBInspectable var labelBackgroundColor: UIColor = .clear {
        didSet {
            initialSetup()
        }
    }

    // IB: use the adapter
    @IBInspectable var labelFontType: Int {
        get {
            return self.labelType.rawValue
        }
        set( shapeIndex) {
            self.labelType = LabelType(rawValue: shapeIndex) ?? .regular18
            initialSetup()
        }
    }

    override var text: String? {
        didSet {
            if text != nil {
                initialSetup()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()

    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        super.drawText(in: rect.inset(by: insets))

    }

    private func initialSetup() {

        switch labelType {
        case .bold24:
            font = UIFont.sourceSansProBold(size: FontSize.largeTitle.rawValue)
        case .bold20:
            font = UIFont.sourceSansProBold(size: FontSize.LargeMedium.rawValue)
        
        case .bold22:
            font = UIFont.sourceSansProBold(size: FontSize.bold22.rawValue)
            
        case .regular18:
            font = UIFont.sourceSansProRegular(size: FontSize.regularTitle.rawValue)
        case .regular15:
            font = UIFont.sourceSansProRegular(size: FontSize.headerRegular.rawValue)
        case .semiBold18:
            font = UIFont.SourceSansProSemiBold(size: FontSize.regularTitle.rawValue)
        case .semiBold13:
            font = UIFont.SourceSansProSemiBold(size: FontSize.secondarySubtitle.rawValue)
        case .bold16:
            font = UIFont.sourceSansProBold(size: FontSize.title.rawValue)
        case .semiBold15:
            font = UIFont.SourceSansProSemiBold(size: FontSize.headerRegular.rawValue)
        case .semiBold16:
            font = UIFont.SourceSansProSemiBold(size: FontSize.title.rawValue)
        case .semiBold11:
            font = UIFont.SourceSansProSemiBold(size: FontSize.homesmall.rawValue)
        case .regular13:
            font = UIFont.sourceSansProRegular(size: FontSize.secondarySubtitle.rawValue)
        case .semiBold12:
            font = UIFont.SourceSansProSemiBold(size: FontSize.videodetailssmall.rawValue)
        case .regular16:
            font = UIFont.sourceSansProRegular(size: FontSize.title.rawValue)
        case .regular20:
            font = UIFont.sourceSansProRegular(size: FontSize.LargeMedium.rawValue)
        case .semiBold17:
            font = UIFont.SourceSansProSemiBold(size: FontSize.navigationTitle.rawValue)
        case .semiBold24:
            font = UIFont.SourceSansProSemiBold(size: FontSize.largeTitle.rawValue)
        case .regular11:
            font = UIFont.sourceSansProRegular(size: FontSize.homesmall.rawValue)
        case .semibold13:
            font = UIFont.SourceSansProSemiBold(size: FontSize.secondarySubtitle.rawValue)
        case .regular12:
            font = UIFont.sourceSansProRegular(size: FontSize.videodetailssmall.rawValue)
        case .regular14:
            font = UIFont.sourceSansProRegular(size: FontSize.medium.rawValue)
        case .regular24:
            font = UIFont.sourceSansProRegular(size: FontSize.largeTitle.rawValue)
        case .bold32:
            font = UIFont.sourceSansProBold(size: FontSize.bold.rawValue)

        case .semiBold22:
            font = UIFont.SourceSansProSemiBold(size: FontSize.bold22.rawValue)
            
        }

        if isLabelRounded {
            layer.cornerRadius = self.height / 2
            layer.masksToBounds = true
        }
//        backgroundColor = labelBackgroundColor
//        guard let aStrTitle = text?.localized else {
//            print(" ========================== \(String(describing: text!)) NOT FOUND IN Language FILE ==========================")
//            return
//        }
        // Stop infinity loop generated from didSet
        if let aStrTitle = text {
            guard aStrTitle != text! else { return }
            text = aStrTitle
        }
    }
}
