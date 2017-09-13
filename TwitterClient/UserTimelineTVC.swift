//
//  UserTimelineTVC.swift
//  TwitterClient
//
//  Created by Azamat Kushmanov on 9/13/17.
//  Copyright © 2017 Azamat Kushmanov. All rights reserved.
//

import UIKit
import TwitterKit

class UserTimelineTVC: TWTRTimelineViewController {
    
    var refreshTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshUserTimeline), for: UIControlEvents.valueChanged)
        
        self.refreshTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(refreshUserTimeline), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchLoggedUser()
        self.refreshUserTimeline()
    }
    
    func fetchLoggedUser(){
        let sessionStore = Twitter.sharedInstance().sessionStore
        
        if let currentSession = sessionStore.session() {
            TWTRAPIClient().loadUser(withID: currentSession.userID, completion: { (fetchedUser, error) in
                if let user = fetchedUser {
                    self.navigationItem.title = "@\(user.screenName) Лента"
                }
            })
        }
    }
    
    func refreshUserTimeline(){
        self.tableView.refreshControl?.endRefreshing()
        
        let sessionStore = Twitter.sharedInstance().sessionStore
        
        if let currentSession = sessionStore.session() {
            self.dataSource = TWTRUserTimelineDataSource.init(screenName: nil, userID: currentSession.userID, apiClient: TWTRAPIClient(), maxTweetsPerRequest: 50, includeReplies: true, includeRetweets: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logout(_ sender: Any) {
        
        let sessionStore = Twitter.sharedInstance().sessionStore
        
        if let currentSession = sessionStore.session() {
            sessionStore.logOutUserID(currentSession.userID)
            self.navigationController?.popViewController(animated: true)
        }
        
    }

}
