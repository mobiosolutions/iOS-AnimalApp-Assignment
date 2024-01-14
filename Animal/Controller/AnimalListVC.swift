//
//  AnimalListVC.swift
//  Animal
//
//  Created by Arvind Mehta on 13/01/24.
//

import Foundation
import UIKit
import Alamofire

class AnimalListCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnFavorite: UIButton!

    var data: PhotoResponse?{
        didSet{
//            img.image = UIImage(named: data?.image ?? "")
//            lblName.text = data?.title
            img.setImages(url: data?.src?.medium ?? "")
            
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = Colors.primary
        self.btnFavorite.cellShadow(shadowRadius: 10)
        
    }
    
    
}


class AnimalListVC: UIViewController {
    
    @IBOutlet weak var viewHeader: ViewHeader!
    @IBOutlet weak var tblView: UITableView!
    
    //MARK: Variables
    var homeModel = HomeModel()
    var currentPage = 1
    var isLoadingList = false
    var totalItems = 0
    
    var arrList = [PhotoResponse]()

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
        apiPhotoList()
    }
    
    
}


//MARK: - Functions
extension AnimalListVC{
    private func configureView(){
        viewHeader.viewCtrl = self
        viewHeader.lblHeader.text = homeModel.title ?? ""
        viewHeader.btnBackScreen.isHidden = false
    }
    
    private func configureTableView(){
        tblView.estimatedRowHeight = 75
        tblView.rowHeight = UITableView.automaticDimension
        tblView.reloadData()
        
    }
}


//MARK: - UITableView
extension AnimalListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrList.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let photoSize =  arrList[indexPath.row]
        
        let newSize = (CGFloat(photoSize.height ?? 0) * screenWidth) / CGFloat(photoSize.width ?? 0)
        return newSize//UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalListCell") as! AnimalListCell
        
        cell.selectionStyle = .none
        cell.img.backgroundColor = Colors.primary

        let data = arrList[indexPath.row]
        cell.data = data
        
        if let list = UserDefaults.standard.data(forKey: "favourite")  {
            
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let newList = try decoder.decode([PhotoResponse].self, from: list)
//
                if newList.firstIndex(where: {$0.id == data.id}) != nil {
                    // it exists, do something
                    cell.btnFavorite.isSelected = true
                } else {
                    //item could not be found
                    cell.btnFavorite.isSelected = false
                }
                
            } catch {
                print("Unable to Decode Note (\(error))")
            }
            
            
        }
        cell.btnFavorite.tag = indexPath.row
        cell.btnFavorite.addTarget(self, action: #selector(btnFavoriteClicked(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        let data = arrList[indexPath.row]
        
        self.configureFavourite(index: indexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == arrList.count - 1 {
                if totalItems > arrList.count && !isLoadingList{
                    
                    tblView.startSpinner()
                    
                    isLoadingList = true
                    currentPage += 1
                    self.apiPhotoList()
                }
            }
        }
    }
    
    @objc func btnFavoriteClicked(sender: UIButton) {
        
//        var data = arrList[sender.tag]
        
        self.configureFavourite(index: sender.tag)
    }
    
    @objc func configureFavourite(index: Int) {
        
        var data = arrList[index]

     
        if let list = UserDefaults.standard.data(forKey: "favourite") {
            
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                var newList = try decoder.decode([PhotoResponse].self, from: list)
//                var newList = list as? [PhotoResponse]
                if newList.firstIndex(where: {$0.id == data.id}) != nil {
                    // it exists, do something
                    newList.remove(at: index)
                } else {
                    //item could not be found
                    data.type = homeModel.title
                    newList.append(data)
                }
                
                let encoder = JSONEncoder()
                   // Encode Note
                let newData = try encoder.encode(newList)
                UserDefaults.standard.set(newData, forKey:"favourite")
              
                
            } catch {
                print("Unable to Decode Note (\(error))")
            }
            
        }else{
            do {
                let encoder = JSONEncoder()
                   // Encode Note
                data.type = homeModel.title
                let newData = try encoder.encode([data])
                UserDefaults.standard.set(newData, forKey:"favourite")

            } catch {
                print("Unable to Encode Note (\(error))")
            }
              }
        
        print("__________UserDefaults.standard.object(forKey: )___________", UserDefaults.standard.object(forKey: "favourite"))
        tblView.reloadData()
    }
}


//MARK: - Apis
extension AnimalListVC{
    
    private func apiPhotoList(){
        
        
        let photoListVM = PhotoViewModel()
        photoListVM.isShowLoader = currentPage == 1 ? true : false
        let param : Parameters = [
            ApiKey.page: currentPage,
            ApiKey.limit:Constants.page_limit,
            ApiKey.query: homeModel.title ?? "",
            ApiKey.size: "medium"]
        photoListVM.param = param
        photoListVM.apiPhotoList()
        
        photoListVM.bindPhotoVMToController = { (success) -> () in
            
            self.tblView.stopSpinner()
            self.isLoadingList = false

            if success{
                
                guard let data = photoListVM.photoListData?.photos else { return print("guard let return")}
                
                print("________data________",data)
//                guard let photoList = data else { return print("guard let return")}
                
                self.totalItems = photoListVM.photoListData?.totalResults ?? 0
                //Do something with your page update
                
                self.configureTableData(photoResponse: data)
            }
        }
    }
    
    private func configureTableData(photoResponse: [PhotoResponse]) {

        if(self.currentPage == 1){
            self.arrList = photoResponse
        }else{
            self.arrList.append(contentsOf: photoResponse)
        }
        if(self.currentPage == 1 && self.arrList.count == 0){
//            self.tblView.backgroundView = self.viewNoDataYestrday
        }else{
            self.tblView.backgroundView = nil
        }
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }
}
