//
//  LoginVC.swift
//  TwitterClient
//
//  Created by Azamat Kushmanov on 9/13/17.
//  Copyright © 2017 Azamat Kushmanov. All rights reserved.
//

import UIKit
import TwitterKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            
            if (session != nil) {
                print("signed in as \(session!.userName)");
                
            } else {
                print("error: \(error?.localizedDescription)");
            }
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
