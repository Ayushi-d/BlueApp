//
//  TimeSlotCell.swift
//  BLUE
//
//

import UIKit

class TimeSlotCell: UICollectionViewCell {
    
    @IBOutlet weak var timeStamp: UILabel!
    var selectedArr = [String]()
    
//    override var isSelected: Bool {
//            didSet {
//                if self.isSelected {
//                    if selectedArr.count < 3{
//                        setSelected()
//                    }
//                }
//                else {
//                    if selectedArr.count < 3{
//                        setUnselected()
//                    }
//                }
//            }
//        }
    
    override func awakeFromNib() {
        
    }
    
    
    func setSelected(){
        self.timeStamp.textColor = .white
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.borderColor = UIColor.init(named: "ButtonColor")?.cgColor
        self.contentView.backgroundColor = UIColor.init(named: "DarkBlue")
       }
       
       func setUnselected(){
           self.timeStamp.textColor = .black
           self.contentView.layer.borderWidth = 0
           self.contentView.backgroundColor = UIColor.init(named: "BlueViewColor")
       }
    
}
