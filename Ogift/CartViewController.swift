//
//  CartViewController.swift
//  Ogift
//
//  Created by Sukumar Anup Sukumaran on 25/01/18.
//  Copyright © 2018 AssaRadviewTech. All rights reserved.
//

import UIKit
import WebKit

class CartViewController: UIViewController, WKNavigationDelegate, UIScrollViewDelegate, UITabBarControllerDelegate {
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    var effect : UIVisualEffect!
    
    lazy private var activityIndicator : CustomActivityIndicatorView = {
        let image : UIImage = UIImage(named: "loading")!
        return CustomActivityIndicatorView(image: image)
    }()

    
    @IBOutlet weak var MainView: UIView!
    
    var webView: WKWebView!
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        effect = visualEffectView.effect
        visualEffectView.effect = nil
       
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0, alpha: 1)
       
         tabBarController?.delegate = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        tabBarController?.delegate = self
        loadWebUrl()
        
    }
    
    override func viewDidLayoutSubviews() {
        
       createWebView()
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if tabBarController.selectedIndex  == 1 {
             print("😝")
            loadWebUrl()
        }
    }
    
    func createWebView() {
        
        addLoadingIndicator()
        
        activityIndicator.startAnimating()
        self.visualEffectView.isHidden = false
        self.visualEffectView.effect = self.effect
        
        webView = WKWebView(frame: CGRect(x: 0, y: 20, width: self.MainView.frame.width, height: self.MainView.frame.height - 20))
        
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false
        
        MainView.addSubview(webView)
        MainView.sendSubview(toBack: webView)
       // addLoadingIndicator()
        print("AddingIndicator")
    }
    
    func checkReachability(){
        if currentReachabilityStatus == .reachableViaWiFi {
            
            print("User is connected to the internet via wifi.")
            
        }else if currentReachabilityStatus == .reachableViaWWAN{
            
            print("User is connected to the internet via WWAN.")
            
        } else {
            print("No internet via WWAN.")
            
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    
    
    func addLoadingIndicator() {
       
        self.MainView.addSubview(activityIndicator)
        activityIndicator.center = self.MainView.center
    }
    
    
    
    func loadWebUrl() {
      
        checkReachability()
        
     //   let url = URL(string: "http://ogift.in")
        let url = URL(string: "http://ogift.in")
        let request = URLRequest(url: url!)
        //request.cachePolicy = .returnCacheDataElseLoad
        webView.load(request)
     
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        activityIndicator.stopAnimating()
        self.visualEffectView.isHidden = true
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
        activityIndicator.startAnimating()
         self.visualEffectView.isHidden = false
        self.visualEffectView.effect = self.effect
        
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        activityIndicator.stopAnimating()
        self.visualEffectView.isHidden = true
  
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            var offset = scrollView.contentOffset
            offset.x = 0
            scrollView.contentOffset = offset
        }
    }
    
}


