//
//  NewsItemViewController.swift
//  NewsBulletin
//
//  Created by claire.roughan on 11/02/2017.
//  Copyright © 2017 claire.roughan. All rights reserved.
//

import UIKit
import Alamofire



class NewsItemViewController: UICollectionViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
       
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 15.0, bottom: 10.0, right: 15.0)
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let reuseIdentifier = "NewsCell"
    fileprivate var selectedArticle:NewsArticle? = nil
    fileprivate var activityIndicatorView: ActivityIndicatorView!
    fileprivate var newsDataArr = [NewsArticle]()
    fileprivate let customNavigationAnimationController = CustomNavigationAnimationController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getNewsData()
        navigationController?.delegate = self
    }
    
    
    func updateUI() {
      
        UIView.animate(withDuration: 1.0, animations: {
            self.collectionView?.reloadData()
            
        }, completion: nil)
    }


    func getNewsData() {
        
        showActivityIndicator()
        
        let url = NewsFinderUrl().getFullUrl()
        
        Alamofire.request(url).responseJSON { response in
            
            print("URL= \(response.request!)")
            print(response.result)

            if response.result.isSuccess {
                
                 self.activityIndicatorView.stopAnimating()
                 self.parseData(JSONData: response.data!)
                
                DispatchQueue.main.async {
                 self.updateUI()
                }
            }
        }
    }

    
    func showActivityIndicator() {
        
        self.activityIndicatorView = ActivityIndicatorView(title: "Loading data...",
                                                           center: self.view.center,
                                                           width: nil,
                                                           bgColour: UIColor(red: 126.0/255.0, green: 125.0/255.0, blue: 170.0/255.0, alpha: 0.5),
                                                           textColour:UIColor.purple)
        
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        self.activityIndicatorView.startAnimating()
    }
    
    
    
    func parseData(JSONData: Data) {
        
        do {
            var myJson =  try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers)as? JSONDictionary
            if let response = myJson?["response"]  as? JSONDictionary {
                
                if let results = response["results"] {
                    
                    for i in 0..<results.count {
                        let item = (results as! NSArray)[i] as! JSONDictionary
                        let title = item["webTitle"] as? String
                        let newsArticle = item["webUrl"] as? String
                        let section = item["sectionName"] as? String

                        let newsStory = NewsArticle.init(section:section!, title:title!, article:newsArticle!)
                        
                        newsDataArr.append(newsStory)
                    }
                }
            }
        } catch  {
            print(error)
        }
    }
    
    
    // MARK: - request for an animation controller to navigate
    func navigationController(_ animationControllerForfromtonavigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        customNavigationAnimationController.reverse = operation == .pop
        return customNavigationAnimationController
    }
    
     // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "viewNewsSegue") {
            
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            
            let nextVC = segue.destination as! NewsReaderViewController
            nextVC.urlString = (self.selectedArticle?.webArticleUrl)!
        }
    }
}



extension NewsItemViewController {
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return newsDataArr.count
    }
    
   
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! NewsItemCollectionViewCell
        
        let aNewsArticle = newsDataArr[indexPath.row]
        
       
        
        cell.titleLabel.text = aNewsArticle.title
        cell.sectionLabel.text = aNewsArticle.sectionName
        
        cell.backgroundColor =  getCellSectionColour(sectionName: aNewsArticle.sectionName).withAlphaComponent(0.2)
        
        return cell
    }
    
    
    func getCellSectionColour(sectionName:String) -> UIColor {
        
        var cellcolour:UIColor?
        
        if sectionName.lowercased().range(of:"world") != nil{
            cellcolour = NewsSection.world.sectionColour
        }
        else if sectionName.lowercased().range(of:"society") != nil{
            cellcolour = NewsSection.society.sectionColour
        }
        else if sectionName.lowercased().range(of:"opinion") != nil{
            cellcolour = NewsSection.opinion.sectionColour
        }
        else if sectionName.lowercased().range(of:"life") != nil{
            cellcolour = NewsSection.life.sectionColour
        }
        else {
            cellcolour = NewsSection.other.sectionColour
        }

        return cellcolour!
    }
    
    
    // MARK:- UICollectionViewDelegate
    
     override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
       
       self.selectedArticle = self.newsDataArr[indexPath.row]
       self.performSegue(withIdentifier: "viewNewsSegue", sender: self)
    }
    
    // MARK:- UICollectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

}

