//
//  NewsReaderViewController.swift
//  NewsBulletin
//
//  Created by claire.roughan on 12/02/2017.
//  Copyright © 2017 claire.roughan. All rights reserved.
//

import UIKit

class NewsReaderViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    var urlString:String?
    
    var activityIndicatorView: ActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showActivityIndicator()

        let url = NSURL (string: urlString!)
        
        print("\n\n \(urlString)\n\n")
        
        let requestObj = URLRequest(url: url! as URL)
        webView.loadRequest(requestObj)
    }

    // MARK: - UIWebViewDelegate
    func webViewDidFinishLoad(_ webView : UIWebView) {
        self.activityIndicatorView.stopAnimating()
        
    }
    
    
    func showActivityIndicator() {
        
//        self.activityIndicatorView = ActivityIndicatorView(title: "Loading news article ...",
//                                                           center: self.view.center,
//                                                           bgColour: UIColor(red: 126.0/255.0, green: 125.0/255.0, blue: 170.0/255.0, alpha: 0.5),
//                                                           textColour:UIColor.purple)
        
        
         self.activityIndicatorView = ActivityIndicatorView(title: "Loading news article ...",
                                                            center: self.view.center,
                                                            width: 250,
                                                            bgColour:  UIColor(red: 126.0/255.0, green: 125.0/255.0, blue: 170.0/255.0, alpha: 0.5),
                                                            textColour: UIColor.purple)
        
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        self.activityIndicatorView.startAnimating()
    }


}
