//
//  HomeVC.swift
//  Animal
//
//  Created by Arvind Mehta on 13/01/24.
//

import Foundation
import UIKit

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: BoldLabel!

    var data: HomeModel?{
        didSet{
            img.image = UIImage(named: data?.image ?? "")
            lblName.text = data?.title
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = Colors.primary
        lblName.textAlignment = .center
        lblName.textColor = .white
        
    }
}

class HomeVC: UIViewController {
    
    @IBOutlet weak var viewHeader: ViewHeader!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Variables
    
    
    var CollectionViewFlowLayout : UICollectionViewFlowLayout!
    var arrList: [HomeModel] = [ HomeModel(id:0, title: "Elephant", image: "Elephant.jpg"),
                                 HomeModel(id:1, title: "Lion", image: "Lion.png"),
                                 HomeModel(id:2, title: "Fox", image: "Fox.jpg"),
                                 HomeModel(id:3, title: "Dog", image: "Dog.jpg"),
                                 HomeModel(id:4, title: "Shark", image: "Shark.jpg"),
                                 HomeModel(id:5, title: "Turtle", image: "Turtle.jpg"),
                                 HomeModel(id:6, title: "Whale", image: "Whale.jpg"),
                                 HomeModel(id:7, title: "Penguin", image: "Penguin.jpg")
                                 
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureCollectionView()
    }
    
}

//MARK: - Functions
extension HomeVC{
    private func configureView(){
        viewHeader.viewCtrl = self
        viewHeader.lblHeader.text = "Animals"
        viewHeader.btnBackScreen.isHidden = true
        viewHeader.btnFavourite.isHidden = false
        viewHeader.btnClickCallback { result, btn in
            if(result == true && btn == .favourite){
                let storyBoard: UIStoryboard = UIStoryboard(name: eStoryboardName.Home.rawValue, bundle: nil)
                let NextVC = storyBoard.instantiateViewController(withIdentifier: "FavoriteListVC") as! FavoriteListVC
                self.navigationController?.pushViewController(NextVC, animated: true)

            }
        }
        
        
    }
    
    private func configureCollectionView(){
        
        if(CollectionViewFlowLayout == nil){
            CollectionViewFlowLayout = UICollectionViewFlowLayout()
        }
        
        CollectionViewFlowLayout.minimumLineSpacing = 15
        CollectionViewFlowLayout.minimumInteritemSpacing = 15
        CollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom:15, right: 15)
        collectionView.setCollectionViewLayout(CollectionViewFlowLayout, animated: true)
    }
}


//MARK: - CollectionView
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:(collectionView.frame.size.width - 45)/2, height: (collectionView.frame.size.width - 45)/2)

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        cell.data = arrList[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        let storyBoard: UIStoryboard = UIStoryboard(name: eStoryboardName.Home.rawValue, bundle: nil)
        let NextVC = storyBoard.instantiateViewController(withIdentifier: "AnimalListVC") as! AnimalListVC
        NextVC.homeModel = arrList[indexPath.row]
        self.navigationController?.pushViewController(NextVC, animated: true)

        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//        // Check pagination
//        if indexPath.row == arrList.count - 1 && !isLoadingList {
//            if arrList.count < totalItems{
//                isLoadingList = true
//
//                footerView.startAnimating()
//                self.loadMoreItemsForList()
//
//            }
//        }
    }
}
