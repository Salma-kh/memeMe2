//
//  SendtMemesTableViewController.swift
//  memeMe last draft
//
//  Created by salma apple on 12/11/18.
//  Copyright © 2018 Udacity. All rights reserved.
//
import Foundation
import UIKit

class SendtMemesTableViewController: UITableViewController {
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    @IBAction func tableToMeme(_ sender: Any) {
        let memeController = storyboard!.instantiateViewController(withIdentifier: "MemeView")
        //Hide the bar with the back button and the tab Bar
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        self.navigationController!.pushViewController(memeController, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //make Sure the tab bar is present and navigation bar are present
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         return memes.count
    
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
       let cell = tableView.dequeueReusableCell(withIdentifier: "TableCellProto") as! TableViewCell
       let meme = memes[indexPath.row]
       cell.TableCellImage.image = meme.selectedImage
       cell.TableCellLabel.text = meme.topText + " " + meme.bottomText
        return cell
    }
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = storyboard!.instantiateViewController(withIdentifier: "Detail") as! MemeDetailViewController
        let meme = memes[indexPath.row]
        controller.meme = meme
        //set the titile of the back button
        let backButton = UIBarButtonItem()
        backButton.title = "Table View Controller"
        navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
