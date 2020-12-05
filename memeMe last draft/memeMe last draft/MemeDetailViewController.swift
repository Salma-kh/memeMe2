//
//  MemeDetailViewController.swift
//  memeMe last draft
//
//  Created by salma apple on 12/9/18.
//  Copyright © 2018 Udacity. All rights reserved.
//
import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var memeImage: UIImageView!
    
    
    var meme : Meme!
    override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(true)
             memeImage.image = meme.selectedImage
        self.tabBarController?.tabBar.isHidden = true
        
    }
    

    }
