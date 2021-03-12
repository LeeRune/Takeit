//
//  CommentDetailViewController.swift
//  Takeit_iOS
//
//  Created by 李易潤 on 2021/2/23.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class CommentDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var comment: UIButton!
    var test: String = ""
    var xOffset:CGFloat = 35
    var ratingStar = [UIButton]()
    var commentStars = 0
    let reportRes = ["歧視語言","色情內容","散佈廣告","洩漏劇情","重複留言","攻擊他人","其他原因"]
    var movieID: String = ""
    var db: Firestore!
    var storage: Storage!
    var movies: [Movie]!
    var commentsArray: [Commenta]!
    var comments: Commenta!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comment.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        db = Firestore.firestore()
        storage = Storage.storage()
        movies = [Movie]()
        commentsArray = [Commenta]()
        comments = Commenta()
        showAllComments()
        movieID = "2gqYScw0gbYnCQmPul7v"
        
    }
    
    @objc func showAllComments() {
        db.collection("movies").document("2gqYScw0gbYnCQmPul7v").collection("comments").getDocuments { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("showAllComments() error: \(error!.localizedDescription)")
                return
            }
            var comments = [Commenta]()
//            var comments = [movie[comment]]
            for document in snapshot.documents {
                // 呼叫自訂Spot建構式可以將document data轉成spot
                comments.append(Commenta(documentData: document.data()))
            }
            self.commentsArray = comments
            self.commentsArray.sort  { $0.comment_updatetime > $1.comment_updatetime
            }
            self.tableView.reloadData()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return reportRes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        test = reportRes[row]
        print("reportRes[row]:\(reportRes[row])")
        return reportRes[row]
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let report = UIContextualAction(style: .normal, title: "檢舉") { (action, view, bool) in
            
            tableView.setEditing(false, animated: true)
            let alert = UIAlertController(title: "檢舉原因", message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let ok = UIAlertAction(title: "送出", style: .default, handler: { (_) in
                
                let checkalert = UIAlertController(title: "您的檢舉已送交審查", message: "", preferredStyle: .alert)
                let check = UIAlertAction(title: "確認", style: .default, handler: nil)
                checkalert.addAction(check)
                self.present(checkalert, animated: true, completion: nil)
            })
            
            
            let pickerView = UIPickerView()
            pickerView.dataSource = self
            pickerView.delegate = self
            pickerView.selectRow(0, inComponent: 0, animated: true)
            pickerView.frame = CGRect(x: 73, y: 40, width: 120, height: 110)
            
            //設定alert大小
            let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
            
            alert.view.addConstraint(height)
            alert.view.addSubview(pickerView)
            alert.addAction(cancel)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        report.backgroundColor = .red
        let swipeActions = UISwipeActionsConfiguration(actions: [report])
        swipeActions.performsFirstActionWithFullSwipe = false
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentPersons", for: indexPath) as! CommentDetailCell
        let commentb = commentsArray[indexPath.row]
        cell.commentLabel.text = commentb.comment_detail
        cell.starImage.image = UIImage(named: "\(commentb.comment_star)star")
        
        //取評論區大頭貼
        let imageRef = Storage.storage().reference().child("userPhoto/\(commentb.uid)")
        
        // 設定最大可下載10M
        imageRef.getData(maxSize: 10 * 1024 * 1024) { (data, error) in
            if let imageData = data {
                cell.photoImage.image = UIImage(data: imageData)
            } else {
                cell.photoImage.image = UIImage(named: "noImage")
                print(error != nil ? error!.localizedDescription : "Downloading error!")
            }
        }

        return cell
    }
    
    @IBAction func comment(_ sender: Any) {
        xOffset = 40
        commentStars = 0
        ratingStar.removeAll()

        let commentAlert = UIAlertController(title: "", message: "喜歡這部電影嗎？\n給個評分跟評論吧！", preferredStyle: .alert)
        commentAlert.addTextField(configurationHandler: { textField in
            
            textField.placeholder = "請輸入評論..."
            textField.delegate = self
            textField.returnKeyType = .done
        })
        for i in 0...4{
            let star = UIButton()
            star.tag = i
            commentStars = star.tag
            star.frame = CGRect(x: xOffset, y: 115, width: 40, height: 40)
            star.setImage(UIImage(systemName: "star"), for: .normal)
            star.setImage(UIImage(systemName: "star.fill"), for: .selected)
            star.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 40), forImageIn: .normal)
            xOffset = xOffset + 40
            ratingStar.append(star)
            commentAlert.view.addSubview(star)
            star.addTarget(self, action: #selector(rating), for: UIControl.Event.touchUpInside)
            
        }
        
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "送出", style: .default, handler: { (_) in
            let id = self.db.collection("movies").document(self.movieID).collection("comments").document().documentID
//            let userUID = UserDefaults.standard.string(forKey: "user_uid_key")!
            let userID = "seLN7gL9GTcry5L1BKjZYMDoZnO2"
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let result = formatter.string(from: date)
            self.comments.comment_id = id
            self.comments.comment_detail = commentAlert.textFields?[0].text ?? ""
            self.comments.comment_star = self.commentStars
            self.comments.uid = userID
            self.comments.comment_updatetime = result
            self.addOrReplace(comment: self.comments)
            //評論後重整tableView
            self.showAllComments()
            let checkalert = UIAlertController(title: "評論成功", message: "", preferredStyle: .alert)
            let check = UIAlertAction(title: "確認", style: .default, handler: { (_) in

            })
            checkalert.addAction(check)
            
            self.present(checkalert, animated: true, completion: nil)
        })
        
        commentAlert.addAction(cancel)
        commentAlert.addAction(ok)
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: commentAlert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 210)
        commentAlert.view.addConstraint(height)
        self.present(commentAlert, animated: true, completion: nil)
    }
    
    @objc func rating(_ sender: UIButton) {
        
        for i in 0...sender.tag{
            let rating = ratingStar[i]
            rating.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        for i in sender.tag + 1..<5{
            let rating = ratingStar[i]
            rating.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        textField.resignFirstResponder()
        return true
    }
    
    // 新增或修改Firestore上的景點
    func addOrReplace(comment: Commenta) {
        // 如果Firestore沒有該ID的Document就建立新的，已經有就更新內容
        db.collection("movies").document(movieID).collection("comments").document(comment.comment_id).setData(comment.documentData()) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
