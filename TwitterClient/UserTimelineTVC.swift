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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshUserTimeline), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.refreshUserTimeline()
    }
    
    func refreshUserTimeline(){
        self.tableView.refreshControl?.endRefreshing()
        
        self.dataSource = TWTRUserTimelineDataSource.init(screenName: nil, userID: Twitter.sharedInstance().sessionStore.session()?.userID, apiClient: TWTRAPIClient(), maxTweetsPerRequest: 50, includeReplies: true, includeRetweets: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
