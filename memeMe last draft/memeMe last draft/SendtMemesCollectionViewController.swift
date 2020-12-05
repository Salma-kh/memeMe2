//
//  SendtMemesCollectionViewController.swift
//  memeMe last draft
//
//  Created by salma apple on 12/11/18.
//  Copyright © 2018 Udacity. All rights reserved.
//
import Foundation
import UIKit

private let reuseIdentifier = "Cell"

class SendtMemesCollectionViewController: UICollectionViewController {
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }

    @IBOutlet weak var layoutFlow: UICollectionViewFlowLayout!

    @IBAction func sendFromCllectionToMeme1(_ sender: Any) {
        let meme1 = storyboard!.instantiateViewController(withIdentifier: "MemeView")
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
        navigationController!.pushViewController(meme1, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        let xaxis: CGFloat = 0.5
        let yaxis: CGFloat = 0.5
        let dimensionx = (self.view.frame.width -  2 * xaxis)/3
        layoutFlow.minimumLineSpacing = yaxis
        layoutFlow.minimumInteritemSpacing = xaxis
        if self.view.frame.width < self.view.frame.height{
            layoutFlow.itemSize = CGSize( width: dimensionx , height: dimensionx)}
        else{
            layoutFlow.itemSize = CGSize( width: dimensionx/1.5 , height: dimensionx/1.5)
        }
              self.tabBarController?.tabBar.isHidden = false
              self.navigationController?.isNavigationBarHidden = false
              self.collectionView?.reloadData()
    }
    // MARK: UICollectionViewDataSource
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }
 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellProto", for: indexPath) as! CollectionViewCell
        let meme = memes[indexPath.row]
        cell.collectionCellImage.image = meme.selectedImage
        return cell
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition( to: size, with: coordinator)
        let xaxis: CGFloat = 0.5
        let yaxis: CGFloat = 0.5
        let dimensionx = (size.width - 2*xaxis)/3
        layoutFlow.minimumLineSpacing = yaxis
        layoutFlow.minimumInteritemSpacing = xaxis
        if size.width < size.height{
            layoutFlow.itemSize = CGSize( width: dimensionx , height: dimensionx)}
        else{
            layoutFlow.itemSize = CGSize( width: dimensionx/1.5 , height: dimensionx/1.5)
        }
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "Detail") as! MemeDetailViewController
        let meme = memes[indexPath.row]
        controller.meme = meme
        let leftBackButton = UIBarButtonItem()
        leftBackButton.title = "CollectionCellProto"
        navigationItem.backBarButtonItem = leftBackButton
        navigationController?.pushViewController(controller, animated: true)
        
    }

}
