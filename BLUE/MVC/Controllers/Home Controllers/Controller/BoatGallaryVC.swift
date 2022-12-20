//
//  BoatGallaryVC.swift
//  BLUE
//
//  Created by Bhikhu on 22/10/22.
//

import UIKit
import Lightbox
class BoatGallaryVC: UIViewController, StoryboardSceneBased, LightboxControllerDismissalDelegate {
    
    

    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)
    @IBOutlet weak var collectionView: UICollectionView!
    var arrGallary = [BoatGallaryDataModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()
    }

    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        collectionView.register(cellType: GallryCell.self)
        collectionView.reloadData()
    }
    
    func lightboxControllerWillDismiss(_ controller: LightboxController) {
        
    }

}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension BoatGallaryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrGallary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let aCell: GallryCell = collectionView.dequeueReusableCell(for: indexPath)
        aCell.cellConfig(with: arrGallary[indexPath.row])
        return aCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if VideoType.allCases.contains(where : {$0.rawValue == arrGallary[indexPath.row].image?.suffix(3) ?? "" }){
            showFullImage(tempImage: arrGallary[indexPath.row].image ?? "", isVideo: true)
        }else{
            showFullImage(tempImage: arrGallary[indexPath.row].image ?? "", isVideo: false)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 2

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
    
    func showFullImage(tempImage: String, isVideo: Bool)  {
        guard let aImageURL = URL(string: (UDManager.baseURLPath ?? "") + (tempImage)) else { return }

        let lightImage = isVideo ? LightboxImage(image: UIImage.init(named: "ic_placeholder")!, videoURL: aImageURL) : LightboxImage(imageURL: aImageURL)
        
        // Create an instance of LightboxController.
        let controller = LightboxController(images: [lightImage])
        
        // Set delegates.
//        controller.pageDelegate = self
        controller.dismissalDelegate = self
        
        // Use dynamic background.
        controller.dynamicBackground = true
        
        // Present your controller.
        self.present(controller, animated: true, completion: nil)
        

        
    }

}


