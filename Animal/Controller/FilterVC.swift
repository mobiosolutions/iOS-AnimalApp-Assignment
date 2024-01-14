//
//  FilterVC.swift
//  Animal
//
//  Created by Arvind Mehta on 13/01/24.
//


import Foundation
import UIKit
import Alamofire

class FilterCell: UITableViewCell {
    
    @IBOutlet weak var lblName: RegularLabel!
    @IBOutlet weak var imgCheck: UIImageView!

    var data: HomeModel?{
        didSet{
            lblName.text = data?.title
            
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()

    }
        
}


class FilterVC: UIViewController {
    
    @IBOutlet weak var viewHeader: ViewHeader!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewFooter: UIView!
    
    //MARK: Variables
    var currentPage = 1
    var isLoadingList = false
    var totalItems = 0
    var strFilter = ""
    
    var arrList: [HomeModel] = [ HomeModel(id:0, title: "Elephant", image: "Elephant.jpg"),
                                 HomeModel(id:1, title: "Lion", image: "Lion.png"),
                                 HomeModel(id:2, title: "Fox", image: "Fox.jpg"),
                                 HomeModel(id:3, title: "Dog", image: "Dog.jpg"),
                                 HomeModel(id:4, title: "Shark", image: "Shark.jpg"),
                                 HomeModel(id:5, title: "Turtle", image: "Turtle.jpg"),
                                 HomeModel(id:6, title: "Whale", image: "Whale.jpg"),
                                 HomeModel(id:7, title: "Penguin", image: "Penguin.jpg")
                                 
    ]
    
    //Completion Block
    typealias CompletionBlock = (Bool, String) -> Void
    var completionBlock : CompletionBlock?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
    }
    
    
}


//MARK: - Functions
extension FilterVC{
    private func configureView(){
        viewHeader.viewCtrl = self
        viewHeader.lblHeader.text = "Filter"
        viewHeader.btnBackScreen.isHidden = true
        viewHeader.btnCancel.isHidden = false
        viewHeader.btnClickCallback { result, btn in
            if(result == true && btn == .cancel){
                self.dismiss(animated: true)
            }
        }
    }
    
    private func configureTableView(){
        tblView.estimatedRowHeight = 75
        tblView.rowHeight = UITableView.automaticDimension
        
        viewFooter.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 50)
        tblView.tableFooterView = viewFooter
        tblView.reloadData()
        
       
        
    }
    
    func showFilter(completion: @escaping (_ result: Bool, _ response: String)->()) {
        
        self.completionBlock = completion
    }
    
    @IBAction func btnClearFilterClicked(_ sender: UIButton) {
        completionBlock?(true, "")

        self.dismiss(animated: true)
    }
}


//MARK: - UITableView
extension FilterVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrList.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell") as! FilterCell
        
        cell.selectionStyle = .none

        let data = arrList[indexPath.row]
        cell.data = data
        
        if(strFilter == data.title){
            cell.imgCheck.isHidden = false
        }else{
            cell.imgCheck.isHidden = true
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = arrList[indexPath.row]
        completionBlock?(true, data.title ?? "")

        self.dismiss(animated: true)
       
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
    }
    
    
}

