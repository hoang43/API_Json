//
//  ViewController.swift
//  parsingData
//
//  Created by nguyen viet hoang on 8/31/20.
//  Copyright © 2020 nguyen viet hoang. All rights reserved.
//

//https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-codable-data-with-urlsession-and-swiftui
import UIKit


class ViewController: UIViewController {
    var dataList = [Person]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        lazy 
    }
  
    func getData() {
        let myUrl = URL(string: "http://demo0737597.mockable.io/master_data")
        let url = URLSession.shared.dataTask(with: myUrl!){
                data, response, error in
                if  error == nil {
                    let decoder = JSONDecoder()
                    do{
                        let parsingJS = try JSONDecoder().decode(ListPerSon.self, from: data!)
                        self.dataList = parsingJS.data
                        DispatchQueue.main.sync {
                            self.tableView.reloadData()
                        }
                    }catch let error{
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)as! TableViewCell
        let c = dataList[indexPath.row]
        
        cell.lblName.text = "Tên: \(c.userName)"
        cell.lblAdd.text = "Địa chỉ: \(c.location)"
        cell.lblAge.text = "Tuổi: \(c.age)"
        cell.lblMale.text = "Giới tính: \(c.gender)"
        
        let imageURL = URL(string: c.image)
        let task = URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
            if error == nil {
                guard let imgData = data else { return }
                let load = UIImage(data: imgData)
                DispatchQueue.main.async {
                    cell.avatar.image = load
                }
            }
        }.resume()
        
        return cell
    }
    
    
}

