//
//  DetailViewController.swift
//  News_App
//
//  Created by Mihir Vyas on 23/04/20.
//  Copyright © 2020 Mihir Vyas. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON

class DetailViewController: UIViewController {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsContent: UITextView!
    @IBOutlet weak var sharebutton: UIButton!
    
    var newsimagecontent = String()
    var textcontent = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func shareInfo(_ sender: Any) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
        self.newsContent.text = textcontent
        DispatchQueue.global().async {
        let imageurl = NSURL(string: self.newsimagecontent)
        let imagedata = NSData(contentsOf: imageurl! as URL )
            
        if (imagedata != nil) {
             DispatchQueue.main.async {
            self.newsImage.image  = UIImage(data: imagedata! as Data)
           
            }
        }
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
