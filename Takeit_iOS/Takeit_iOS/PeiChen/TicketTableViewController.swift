//
//  TicketTableViewController.swift
//  Tackit
//
//  Created by 傅培禎 on 2021/3/4.
//

import UIKit

class TicketTableViewController: UITableViewController {

    var movies = [Movie]()
    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        movies.append(Movie(name: "FateStayNigtht",  detail: "貓",  image: UIImage(named: "FateStayNigtht")!))
        movies.append(Movie(name: "孩子別哭",  detail: "貓",  image: UIImage(named: "孩子別哭")!))
        movies.append(Movie(name: "幸福剛剛好",  detail: "貓",  image: UIImage(named: "幸福剛剛好")!))
        movies.append(Movie(name: "名偵探柯南",  detail: "貓",  image: UIImage(named: "名偵探柯南")!))
        movies.append(Movie(name: "湯姆貓與傑利鼠",  detail: "貓",  image: UIImage(named: "湯姆貓與傑利鼠")!))
        movies.append(Movie(name: "FateStayNigtht",  detail: "貓",  image: UIImage(named: "FateStayNigtht")!))
        movies.append(Movie(name: "孩子別哭",  detail: "貓",  image: UIImage(named: "孩子別哭")!))
        movies.append(Movie(name: "幸福剛剛好",  detail: "貓",  image: UIImage(named: "幸福剛剛好")!))
        movies.append(Movie(name: "名偵探柯南",  detail: "貓",  image: UIImage(named: "名偵探柯南")!))
        

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
