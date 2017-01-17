//
//  DetailViewController.swift
//  MasterDetail
//
//  Created by Tomas Radvansky on 17/01/2017.
//  Copyright © 2017 Tomas Radvansky. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var postBodylabel: UILabel!
    @IBOutlet weak var postCommentCountLabel: UILabel!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var authorObject:UserObject?
    var comments:[CommentObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Automatic cell height
        self.mainTableView.estimatedRowHeight = 100.0
        self.mainTableView.rowHeight = UITableViewAutomaticDimension
        
        self.configurePost()
        self.configureUser()
        self.configureComments()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Data Loading
    var detailItem: PostObject? {
        didSet {
            // Update the view.
            self.configurePost()
            self.loadUser()
            self.loadComments()
        }
    }
    
    func loadUser()
    {
        if let userID:Int = self.detailItem?.userId
        {
            APICommunicator.sharedInstance.getUserById(id: userID, completionHandler: { (user:UserObject?, err:Error?) in
                if let error:Error = err
                {
                    print(error.localizedDescription)
                }
                else if let userObject:UserObject = user
                {
                    self.authorObject = userObject
                    self.configureUser()
                }
                
            })
        }
    }
    
    func loadComments()
    {
        if let postID:Int = self.detailItem?.id
        {
            APICommunicator.sharedInstance.getCommentsByPostId(postId: postID, completionHandler: { (comments:[CommentObject]?, err:Error?) in
                if let error:Error = err
                {
                    print(error.localizedDescription)
                }
                else if let commentObjects:[CommentObject] = comments
                {
                    self.comments = commentObjects
                    self.configureComments()
                }
            })
        }
    }
    
    // MARK: UI
    
    func configurePost() {
        if let detail = self.detailItem {
            if let name = self.userNameLabel {
                name.text = "name"
            }
            if let email = self.userEmailLabel {
                email.text = "email@email.sk"
            }
            if let body = self.postBodylabel {
                body.text = detail.body
            }
            if let comment = self.postCommentCountLabel {
                comment.text = "1"
            }
        }
    }
    
    func configureUser() {
        if let user = self.authorObject {
            if let name = self.userNameLabel {
                name.text = user.name
            }
            if let email = self.userEmailLabel {
                email.text = user.email
            }
        }
    }
    
    func configureComments() {
        if let comments = self.comments {
            if let comment = self.postCommentCountLabel {
                comment.text = "\(comments.count)"
            }
            self.mainTableView.reloadData()
        }
    }
    
    // MARK: UITableViewDelegate + UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.comments == nil
        {
            return 0
        }
        return self.comments!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let commentCell:CommentCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        let commentObject:CommentObject = self.comments![indexPath.row]
        
        commentCell.nameLabel.text = commentObject.name
        commentCell.emailLabel.text = commentObject.email
        commentCell.bodyLabel.text = commentObject.body
        
        return commentCell
    }
    
}

