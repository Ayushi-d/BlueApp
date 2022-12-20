//
//  CaptainPaymentVC.swift
//  BLUE
//
//  Created by Bhikhu on 15/10/22.
//

import UIKit

class CaptainPaymentVC: UIViewController , StoryboardSceneBased {
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.seafarer.rawValue, bundle: nil)

    
    /// Storyboard  variable
    @IBOutlet weak var tblMethodHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var tblPaymentMethod: UITableView!
    @IBOutlet weak var tblSummary: UITableView!
    @IBOutlet weak var tblSummarHeightConstant: NSLayoutConstraint!
    let paymentImages = [UIImage.init(named: "ic_mastercard"),UIImage.init(named: "ic_visa"),UIImage.init(named: "ic_visa")]
    var arrSummary = [SummaryModel]()
    var selectedIndex : Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()

    }
    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        let obj1 = SummaryModel(product: "Catamaran Boats", price: "50.000 KWD")
        arrSummary.append(obj1)
        tblSummary.register(cellType: PaymentFirstSectionCell.self)
        tblPaymentMethod.register(cellType: PaymentCell.self)
        tblSummary.estimatedRowHeight = 62
        tblSummary.rowHeight = UITableView.automaticDimension
        tblSummary.reloadData()
    }
    // MARK: IB Actions
    @IBAction func btnPayConfimrTapped(_ sender: Any) {
        confirmPayment()
    }

    /// close account popup
     func confirmPayment() {
         UIAlertController.showAlert(controller: self, title: Localizable.CaptainPayment.alert, message: Localizable.CaptainPayment.messsgae, style: .alert, cancelButton: Localizable.Buttons.no, distrutiveButton: Localizable.Buttons.yes, otherButtons: nil) { (_, btnStr) in
            if btnStr == Localizable.Buttons.yes {
                self.pushVC(controller: BottomBarController.instantiate())
                
            }
        }
    }
    
}

// MARK: UITableViewDelegate
extension CaptainPaymentVC :UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblSummary {
            return arrSummary.count
        }else if tableView == tblPaymentMethod {
            return paymentImages.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if tableView == tblSummary {
             let aCell: PaymentFirstSectionCell = tableView.dequeueReusableCell(for: indexPath)
             //aCell.cellConfig(with: arrSummary[indexPath.row])
             return aCell
         } else if tableView == tblPaymentMethod {
             let aCell: PaymentCell = tableView.dequeueReusableCell(for: indexPath)
             aCell.radioImage.image = indexPath.row == selectedIndex ?? 0 ? UIImage.init(named: "ic_selectedRadio") : UIImage.init(named: "ic_unselectedRadio")
             aCell.paymentImage.image = paymentImages[indexPath.row]
             return aCell
         }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == tblSummary {
            Utility.delay(0) {
                self.tblSummarHeightConstant.constant = self.tblSummary.contentSize.height
            }
        } else if tableView == tblPaymentMethod {
            Utility.delay(0) {
                self.tblMethodHeightConstant.constant = self.tblPaymentMethod.contentSize.height
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblPaymentMethod {
            self.selectedIndex = indexPath.row
            tblPaymentMethod.reloadData()
        }
    }
}
