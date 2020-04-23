//
//  MostViewedViewController.swift
//  News_App
//
//  Created by Mihir Vyas on 22/04/20.
//  Copyright © 2020 Mihir Vyas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MostViewedViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
       
    var mySideMenu = false

    fileprivate func CustomNavBar(){
        title = "Recent-News"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomNavBar()
        Api_JSON_Response()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sideBarMenu2(_ sender: Any) {
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
     let request = AF.request("https://newsapi.org/v2/everything?q=apple&from=2020-04-21&to=2020-04-21&sortBy=popularity&apiKey=fa1d50d2ae0b42598b8051ff3dab9b7e")
        request.responseJSON { (myResponse) in
            switch myResponse.result {
            case .success:
                print(myResponse.result)
               // print(myResponse.response)
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
                    let imageurl = i["urlToImage"].stringValue
                    model.URLTOIMAGE.append(imageurl)
                }
                self.tableview.reloadData()
                break
            case .failure:
                print(Error.self)
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

extension MostViewedViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.AUTHOR.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "most") as? mostnewsCell
        cell?.discription.text = model.TITLE[indexPath.row]
        cell?.newimage2.sd_setImage(with: URL(string: model.URLTOIMAGE[indexPath.row]), placeholderImage: UIImage(named: "ic_launcher"))
        return cell!
    }
}
