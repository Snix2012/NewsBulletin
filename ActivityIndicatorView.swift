//
//  ActivityIndicatorView.swift
//  ClothingStore
//
//  Created by claire.roughan on 07/12/2016.
//  Copyright © 2016 claire.roughan. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {

    var view: UIView!
    
    var activityIndicator: UIActivityIndicatorView!
    
    var title: String!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // init(title: String, center: CGPoint, width: CGFloat = 200.0, height: CGFloat = 50.0, bgColour: UIColor, textColour:UIColor)
    init(title: String, center: CGPoint, width: CGFloat?, height: CGFloat = 50.0, bgColour: UIColor, textColour:UIColor)
    {
        
        let theWidth = width ?? 200
       // let theHeight = height ?? 50
        
        
        self.title = title
       
        let x = center.x - theWidth/2.0
        let y = center.y - height/2.0
        
        self.view = UIView(frame: CGRect(x: x, y: y, width: theWidth, height: height))
        self.view.backgroundColor = bgColour
        self.view.layer.cornerRadius = 10
        
        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.activityIndicator.color = UIColor.black
        self.activityIndicator.hidesWhenStopped = false
        
        let titleLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        titleLabel.text = title
        titleLabel.textColor = textColour
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 0
        
        self.view.addSubview(self.activityIndicator)
        self.view.addSubview(titleLabel)
        
        super.init(frame: self.view.frame)
    }
    
    
    
    func getViewActivityIndicator() -> UIView
    {
        return self.view
    }
    
    func startAnimating()
    {
        self.activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopAnimating()
    {
        self.activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        
        self.view.removeFromSuperview()
    }
}
