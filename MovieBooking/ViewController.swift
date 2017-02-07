//
//  ViewController.swift
//  MovieBooking
//
//  Created by Chi-Quyen Le on 2/6/17.
//  Copyright © 2017 Chi-Quyen Le. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    let viewModel = SeatViewModel(seats: AppUtils.fakeSeats())
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let maxNumberOfItemsPerRow = AppUtils.maxNumberOfItemsPerRow
        let width = (collectionView.frame.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing * CGFloat(maxNumberOfItemsPerRow - 1)) / CGFloat(maxNumberOfItemsPerRow)
        flowLayout.itemSize = CGSize(width: width, height: width)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfSeats
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SeatCell
        cell.configureCell(type: viewModel.seatTypeAt(position: indexPath.item))
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        do {
            try viewModel.changeStateAt(position: indexPath.item)
            collectionView.reloadData()
        } catch {
            let alertController = UIAlertController(title: "Error", message: "Max number of seats exceeded", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
}
