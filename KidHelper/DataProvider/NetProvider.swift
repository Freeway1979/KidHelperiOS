//
//  NetProvider.swift
//  KidHelper
//
//  Created by Liu PingAn on 05/03/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

import UIKit

class NetProvider: NSObject {
 
    class func searchBaiduHanyu(text:String,webView:UIWebView)
    {
        let URL_BAIDU_HANYU = "http://hanyu.baidu.com/s?wd=\(text)&from=zici"
        searchText(via: URL_BAIDU_HANYU, webView: webView)
    }
    class func translateEnglish(text:String,webView:UIWebView)
    {
        let RAW_URL = "http://fanyi.baidu.com/?aldtype=85#en/zh/\(text)"
        
        searchText(via: RAW_URL, webView: webView)
    }
    class func searchBaiduBaike(text:String,webView:UIWebView) {
        let URL = "https://baike.baidu.com/item/\(text)"
        searchText(via: URL, webView: webView)
    }
    class func searchWikiBaike(text:String,webView:UIWebView) {
        let URL = "http://www.baike.com/wiki/\(text)"
        searchText(via: URL, webView: webView)
    }
    class func searchText(via url:String,webView:UIWebView)
    {
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = URL(string: urlString!)
        let request:URLRequest  = URLRequest(url: url!)
        webView.loadRequest(request)
    }
}
