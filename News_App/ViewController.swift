//
//  ViewController.swift
//  News_App
//
//  Created by Mihir Vyas on 22/04/20.
//  Copyright © 2020 Mihir Vyas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    
    var mySideMenu = false
//    var AUTHOR = [String]()
//    var TITLE = [String]()
//    var URLTOIMAGE = [String]()
    
    fileprivate func CustomNavBar(){
       
//        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomNavBar()
        Api_JSON_Response()
        //tableview.estimatedRowHeight = 300
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sideBarMenu(_ sender: Any) {
        if (mySideMenu) {
                leadingConst.constant = -240
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn, animations: {
                    self.view.layoutIfNeeded()
                })
            } else {
                leadingConst.constant = 0
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn, animations: {
                    self.view.layoutIfNeeded()
                })
            }
            
            mySideMenu = !mySideMenu
    }
    
    func Api_JSON_Response() {
     let request = AF.request("https://newsapi.org/v2/everything?q=bitcoin&from=2020-03-23&sortBy=publishedAt&apiKey=e7b73f6a613c4587b3fd961edaf00da4")
        request.responseJSON { (myResponse) in
            switch myResponse.result {
            case .success:
                print(myResponse.result)
                let myresult = try? JSON(data: myResponse.data!)
                print("al:- \(myresult!["articles"])")
                let resultArray = myresult!["articles"]
               model.AUTHOR.removeAll()
               model.TITLE.removeAll()
               model.URLTOIMAGE.removeAll()
                for i in resultArray.arrayValue {
                    let author = i["author"].stringValue
                    model.AUTHOR.append(author)
                    let title = i["description"].stringValue
                    model.TITLE.append(title)
                    print("mihir:::: \(String(describing: model.TITLE))")
                    let imageurl = i["urlToImage"].stringValue
                    model.URLTOIMAGE.append(imageurl)
                    let mycontent = i["content"].stringValue
                    model.content.append(mycontent)
                }
                self.tableview.reloadData()
                break
            case .failure:
                print(Error.self)
            }
        }
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.AUTHOR.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "top") as? topnewsCell
        cell?.titletext.text = model.TITLE[indexPath.row]
        cell?.newsImage.sd_setImage(with: URL(string: model.URLTOIMAGE[indexPath.row]), placeholderImage: UIImage(named: "ic_launcher"))
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detail") as? DetailViewController
        controller?.newsimagecontent = model.URLTOIMAGE[indexPath.row]
        controller?.textcontent = model.content[indexPath.row]
        controller?.hidesBottomBarWhenPushed = true
         self.navigationController?.pushViewController(controller!, animated: true)
    }
}
