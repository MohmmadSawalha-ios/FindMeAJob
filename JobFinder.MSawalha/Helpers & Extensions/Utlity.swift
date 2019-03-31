//
//  Utlity.swift
//  JobFinder.MSawalha
//
//  Created by apple on 3/30/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class Utility {
    static func open(_ URLs: [String]) {
        let application = UIApplication.shared
        for stringURL in URLs {
            if let url = URL(string: stringURL) {
                if application.canOpenURL(url) {
                    application.open(url)
                    return
                }
            }
        }
    }
}


// View Controller indicator.
class ViewControllerUtils {
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     
     @param view - add activity indicator to this view
     */
    func showActivityIndicator(in view: UIView) {
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        view.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     
     @param view - remove activity indicator from this view
     */
    func hideActivityIndicator(from view: UIView) {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
}
