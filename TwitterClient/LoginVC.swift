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
        
        let sessionStore = Twitter.sharedInstance().sessionStore
        
        if sessionStore.session() != nil {
            let listTweetsTVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserTimelineTVC") as! UserTimelineTVC
            self.navigationController?.pushViewController(listTweetsTVC, animated: false)
        }
        
        
        
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            
            if (session != nil) {
                print("signed in as \(session!.userName)");
                
                let listTweetsTVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserTimelineTVC") as! UserTimelineTVC
                self.navigationController?.pushViewController(listTweetsTVC, animated: false)
                
            } else {
                if error != nil {
                    let alertController = UIAlertController(title: "Ошибка", message: error?.localizedDescription, preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .cancel)
                    alertController.addAction(okButton)
                 
                    self.present(alertController, animated: true, completion: nil)
                }
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
