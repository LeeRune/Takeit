//
//  TicketTableViewController.swift
//  Tackit
//
//  Created by 傅培禎 on 2021/3/4.
//

import UIKit

class TicketTableViewController: UITableViewController {

    var movies = [MovieByPei]()
    var selectedIndex = 0
    
    @IBAction func payTicket(_ sender: Any) {
        /* 建立標題為"Exit"，訊息為"Do you really want to exit?"，樣式為.alert(長得像Alert View)的Alert Controller */
        let alertController = UIAlertController(title: "嗨，", message: "想要兌票嗎?", preferredStyle: .alert)
        
        /* 建立標題為"Ok"，樣式為.default(預設樣式)的按鈕 */
        let ok = UIAlertAction(title: "我要兌票", style: .default) {
            /* alertAction代表被點擊的按鈕 */
            (alertAction) in
            
            
        }
        /* 建立標題為"Cancel"，樣式為.cancel(取消樣式)的按鈕 */
        let cancel = UIAlertAction(title: "還不想", style: .cancel) {_ in
            
        }
        /* Alert Controller加上ok與cancel按鈕 */
        alertController.addAction(ok)
        alertController.addAction(cancel)

        /* 呼叫present()才會跳出Alert Controller */
        self.present(alertController, animated: true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = UIScreen.main.bounds.size
        movies.append(MovieByPei(name: "FateStayNigtht",  detail: "貓",  image: UIImage(named: "FateStayNigtht")!))
        movies.append(MovieByPei(name: "孩子別哭",  detail: "貓",  image: UIImage(named: "孩子別哭")!))
        movies.append(MovieByPei(name: "幸福剛剛好",  detail: "貓",  image: UIImage(named: "幸福剛剛好")!))
        movies.append(MovieByPei(name: "名偵探柯南",  detail: "貓",  image: UIImage(named: "名偵探柯南")!))
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "退票") { (action, view, bool) in
            self.movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        delete.backgroundColor = .red
        // delete.image = UIImage(named: "delete")

        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        // true代表滑到底視同觸發第一個動作；false代表滑到底也不會觸發任何動作
        swipeActions.performsFirstActionWithFullSwipe = false
        return swipeActions
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "movieCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! WwTableViewCell
        let movie = movies[indexPath.row]
        cell.imgView?.image = movie.image
        cell.lebView?.text = movie.name
        
        tableView.rowHeight = 180
        tableView.estimatedRowHeight = 0
        
//        cell.textLabel?.text = movie.name
//        cell.imageView?.image = movie.image
        return cell
    }
    
    
}
