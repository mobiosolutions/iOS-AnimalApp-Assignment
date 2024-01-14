
//  FavoriteListVC.swift
//  Animal
//
//  Created by Arvind Mehta on 13/01/24.
//

import Foundation
import UIKit
import Alamofire

class FavoriteListCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var lblName: RegularLabel!

    var data: PhotoResponse?{
        didSet{
//            img.image = UIImage(named: data?.image ?? "")
            lblName.text = "   \(data?.type ?? "")   "
            img.setImages(url: data?.src?.medium ?? "")
            
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = Colors.primary
        self.btnFavorite.cellShadow(shadowRadius: 10)
        self.lblName.layer.cornerRadius = 12
        self.lblName.clipsToBounds = true
        self.lblName.textColor = Colors.white
        
    }
    
    
}


class FavoriteListVC: UIViewController {
    
    @IBOutlet weak var viewHeader: ViewHeader!
    @IBOutlet weak var tblView: UITableView!
    
    //MARK: Variables
    var currentPage = 1
    var isLoadingList = false
    var totalItems = 0
    
    var strFilter = ""
    var arrList = [PhotoResponse]()

    var arrFilter = [PhotoResponse]()
    var viewNoData: ViewNoData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNoData()
        configureView()
        configureTableView()
        
    }
    
    
}


//MARK: - Functions
extension FavoriteListVC{
    private func configureView(){
        viewHeader.viewCtrl = self
        viewHeader.lblHeader.text = "Favourite Animals"
        viewHeader.btnBackScreen.isHidden = false
        viewHeader.btnFilter.isHidden = false
        viewHeader.btnClickCallback { result, btn in
            if(result == true && btn == .filter){
                let storyBoard: UIStoryboard = UIStoryboard(name: eStoryboardName.Home.rawValue, bundle: nil)
                let NextVC = storyBoard.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
                
                NextVC.strFilter = self.strFilter
                NextVC.showFilter { result, response in
                    if(result == true){
                        
                        self.strFilter = response
                        if(response == ""){
                            self.arrFilter = self.arrList
                        }else{
//                            self.arrFilter = self.arrList.filter{ ($0.url?.lowercased().contains(response.lowercased()))! }
                            self.arrFilter = self.arrList.filter{ ($0.type?.lowercased().contains(response.lowercased()))! }
                        }
                        
                        if(self.arrFilter.count == 0){
                            self.tblView.backgroundView = self.viewNoData
                        }else{
                            self.tblView.backgroundView = nil
                        }

                        self.tblView.reloadData()
                    }
                }
                self.navigationController?.present(NextVC, animated: true)
            }
        }
    }
    
    private func configureTableView(){
        tblView.estimatedRowHeight = 75
        tblView.rowHeight = UITableView.automaticDimension
        tblView.reloadData()
        
        if let list = UserDefaults.standard.data(forKey: "favourite") {
            
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let newList = try decoder.decode([PhotoResponse].self, from: list)
//                var newList = list as? [PhotoResponse]
                arrList = newList
                arrFilter = arrList
                
                if(arrFilter.count == 0){
                    self.tblView.backgroundView = self.viewNoData
                }else{
                    self.tblView.backgroundView = nil
                }
                
                tblView.reloadData()
                
            } catch {
                print("Unable to Decode Note (\(error))")
            }
            
        }
        
    }
    private func configureNoData(){
                
        viewNoData = ViewNoData()
        viewNoData?.viewImg.isHidden = false
        viewNoData?.viewTitle.isHidden = false
        viewNoData?.img.image = UIImage(named: "sad_face")
        
    }
}


//MARK: - UITableView
extension FavoriteListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrFilter.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let photoSize =  arrFilter[indexPath.row]
        
        let newSize = (CGFloat(photoSize.height ?? 0) * screenWidth) / CGFloat(photoSize.width ?? 0)
        return newSize//UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteListCell") as! FavoriteListCell
        
        cell.selectionStyle = .none
        cell.img.backgroundColor = Colors.primary

        let data = arrFilter[indexPath.row]
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
        
//
//            let storyBoard: UIStoryboard = UIStoryboard(name: eStoryboardName.Profile.rawValue, bundle: nil)
//            let NextVC = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
//            NextVC.member_id = id
//            self.navigationController?.pushViewController(NextVC, animated: true)
       
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
    }
    
    @objc func btnFavoriteClicked(sender: UIButton) {
        
        let data = arrFilter[sender.tag]
        
        if let list = UserDefaults.standard.data(forKey: "favourite") {
            
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                var newList = try decoder.decode([PhotoResponse].self, from: list)
//                var newList = list as? [PhotoResponse]
                if newList.firstIndex(where: {$0.id == data.id}) != nil {
                    // it exists, do something
                    newList.remove(at: sender.tag)
                } else {
                    //item could not be found
                    newList.append(data)
                }
                
                let encoder = JSONEncoder()
                   // Encode Note
                let newData = try encoder.encode(newList)
                UserDefaults.standard.set(newData, forKey:"favourite")
              
                self.arrFilter = newList
                
            } catch {
                print("Unable to Decode Note (\(error))")
            }
            
        }else{
            do {
                let encoder = JSONEncoder()
                   // Encode Note
                let newData = try encoder.encode([data])
                UserDefaults.standard.set(newData, forKey:"favourite")
                self.arrFilter = [data]
            } catch {
                print("Unable to Encode Note (\(error))")
            }
              }
        
        print("__________UserDefaults.standard.object(forKey: )___________", UserDefaults.standard.object(forKey: "favourite"))
//          tblView.reloadRowsAt(sender.tag)
        
        if(arrFilter.count == 0){
            self.tblView.backgroundView = self.viewNoData
        }else{
            self.tblView.backgroundView = nil
        }
        
        tblView.reloadData()
    }
}

