//
//  Constants.swift
//  ClothingStore
//
//  Created by claire.roughan on 02/12/2016.
//  Copyright © 2016 claire.roughan. All rights reserved.
//

import Foundation
import UIKit

typealias JSONDictionary = [String:AnyObject]


struct NewsFinderUrl {
    private let baseURL = "https://content.guardianapis.com/search?q="
    private let key = "&api-key=a85b05be-9bb6-44b4-ab34-8f98b0946cc1"
    private let searchTerm = "children"
    
    func getFullUrl() -> String {
        return baseURL + searchTerm + key
    }
}


struct NewsArticle {
    private var  _sectionName:String?
    private var  _title :String?
    private var  _webArticleUrl:String?
    
    init(section:String, title:String, article:String) {
        self._sectionName = section
        self._title = title
        self._webArticleUrl = article
    }
    
    
    var sectionName: String {
        return _sectionName!  
    }
    
    var title: String {
        return _title! 
    }
    
    var webArticleUrl: String {
        return _webArticleUrl!
    }
}


enum NewsSection {
    case world
    case society
    case opinion
    case life
    case other
   
    var sectionColour:UIColor {
        switch self {
        case .world: return UIColor.green
        case .society: return UIColor.blue
        case .opinion: return UIColor.yellow
        case .life: return UIColor.magenta
        case .other: return UIColor.cyan
        }
    }
}



