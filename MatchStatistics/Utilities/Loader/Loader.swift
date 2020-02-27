//
//  Loader.swift
//  MatchStatistics
//
//  Created by Vikas Karambalkar on 11/02/2020.
//  Copyright © 2020 Vikas Karambalkar. All rights reserved.
//

import Foundation
import SVProgressHUD

class Loader: NSObject {
    
    //MARK: shared instense
    static let shared = Loader()
    
    //MARK: Loader methods
    func showLoader() {
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setBackgroundColor(UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.4))
    }
    
    func showLoader(message: String){
        SVProgressHUD.show(withStatus: message)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setBackgroundColor(UIColor.init(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    func hideLoader() {
        SVProgressHUD.dismiss()
    }
    
}
