//
//  TakeitHomeViewController.swift
//  takeit_top
//
//  Created by Lee on 2021/2/4.
//

import UIKit
import Foundation
import FirebaseFirestore
import FirebaseStorage
import Firebase


class TopViewController: UIViewController, UICollectionViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    var allMovie:[Movie] = []
    var searchedMovie:[Movie] = []
    var db: Firestore!
    var storage: Storage!
    
    
    @IBOutlet weak var segtime: UISegmentedControl!
    
    @IBOutlet weak var segtype: UISegmentedControl!
    
    @IBOutlet weak var segindex: UISegmentedControl!
    
    @IBOutlet weak var movieTV: UITableView!
    
    @IBOutlet var segmentStyle: [UISegmentedControl]!
    
    @IBOutlet weak var topPosterCollectionView: UICollectionView!
    
    @IBOutlet weak var TopSearchBar: UISearchBar!
    
    @IBOutlet weak var mainSV: UIStackView!
    
    let imageID = ["001.jpg", "000.jpg", "002.jpg"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCells", for: indexPath) as! CVCell
        cell.CVimageView.image = UIImage(named: imageID[indexPath.item])
        return cell
    }
    
//    let NVsearchBar = UISearchController(searchResultsController: nil)
    
    
    @objc func keyboardWillShow(notification: Notification) {
        // 能取得鍵盤高度就讓view上移鍵盤高度，否則上移view的1/3高度
//        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRect = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRect.height
//            mainSV.frame.origin.y = -keyboardHeight
//        } else {
//            mainSV.frame.origin.y = -mainSV.frame.height / 4
//
//        }
        let keyFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        mainSV.frame.origin.y = keyFrame.origin.y - mainSV.frame.height
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let keyFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        mainSV.frame.origin.y = keyFrame.origin.y - mainSV.frame.height - 44
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        TopSearchBar.barTintColor = UIColor.black
        TopSearchBar.tintColor = UIColor.white
        TopSearchBar.searchTextField.textColor = .white
        
        db = Firestore.firestore()
        storage = Storage.storage()
//        filteredData = data
//
//        if searchText.isEmpty {
//              filteredData = data
//           } else {
//              filteredData = data.filter{$0.title.range(of: searchText, options: .caseInsensitive) != nil }
//           }
//        self.movieTV.reloadData()
        
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        self.navigationItem.searchController = NVsearchBar
//        self.navigationItem.searchController?.delegate = self
//        navigationItem.searchController?.searchBar.delegate = self
//        NVsearchBar.searchResultsUpdater = self
//        navigationItem.hidesSearchBarWhenScrolling = false

        segStyle()
        getMovies { (movies) in
            self.allMovie = movies
            self.searchedMovie = self.allMovie
            self.searchedMovie = self.searchedMovie.sorted { (m1, m2) -> Bool in
                return m1.release > m2.release
            }
            self.movieTV.reloadData()
        }
        
        topPosterCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .top, animated: true)
        let flowLayout = topPosterCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        flowLayout?.itemSize = CGSize(width: width, height: height/4)
        
       
    }
    
    //navigation searchBar保留keyword
//    var previousText: String = ""
//
//    func willDismissSearchController(_ searchController: UISearchController) {
//        previousText = searchController.searchBar.searchTextField.text ?? ""
//    }
//
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        searchBar.searchTextField.text = previousText
//        return true
//    }
//
//    func isEnabledForSegment(at segment: Int) -> Bool{
//        return true
//    }
    
//    func getBarState() -> [Bool] {
//
//        var states: [Bool] = []
//        for i in 0..<segmentStyle.count {
//                states.append(isEnabledForSegment(forSegment: i))
//            }
//            return states
//    }
    func sortNew(){
        
    searchedMovie = searchedMovie.sorted {$0.release > $1.release}
        movieTV.reloadData()
    }
    func sortOld(){
        
    searchedMovie = searchedMovie.sorted {$0.release < $1.release}
        movieTV.reloadData()
    }
    
    func sorthigh(){
        searchedMovie = searchedMovie.sorted {$0.imdb > $1.imdb}
            movieTV.reloadData()
    }
    
    func sortlow(){
        searchedMovie = searchedMovie.sorted {$0.imdb < $1.imdb}
            movieTV.reloadData()
    }
    
    func sortanime(){
    
        searchedMovie = searchedMovie.filter{$0.type.contains("動畫")}
        movieTV.reloadData()
        
    }
   
    func sortAct(){
        
        searchedMovie = searchedMovie.filter{$0.type.contains("動作")}
        
        movieTV.reloadData()
    }
    
    func sortLove(){
        searchedMovie = searchedMovie.filter{$0.type.contains("愛情")}
        movieTV.reloadData()
    }
    func sortHor(){
        searchedMovie = searchedMovie.filter{$0.type.contains("恐怖")}
        movieTV.reloadData()
    }
    
    
    func search(){
        
        let index = segindex.selectedSegmentIndex
        let type = segtype.selectedSegmentIndex
        
        if TopSearchBar.text! == "" {
            if index == 0 {
                switch type {
                case 0:
                    sortNew()
                    
                case 1:
                    sortNew()
                    sortanime()
                case 2:
                    sortNew()
                    sortAct()
                default:
                    sortNew()
                }
                }
            else if index == 1{
                switch type {
                case 0:
                    sortOld()
                case 1:
                    sortOld()
                    sortanime()
                case 2:
                    sortOld()
                    sortAct()
                default:
                    sortOld()
                }
                }
        }
        if TopSearchBar.text! != ""{
            searchedMovie = allMovie.filter{
                $0.movieName.uppercased().contains(TopSearchBar.text!.uppercased())
            }
            
        if index == 0 {
            switch type {
            case 0:
                sortNew()
            case 1:
                sortNew()
                sortanime()
            case 2:
                sortNew()
                sortAct()
            default:
                sortNew()
            }
        }
        else if index == 1{
            switch type {
            case 0:
                sortOld()
            case 1:
                sortOld()
                sortanime()
            case 2:
                sortOld()
                sortAct()
            default:
                sortOld()
            }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
        searchedMovie = allMovie
        
        search()
    }

    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       
    }
    
    @IBAction func sortType(_ segmentedControl: UISegmentedControl) {
        
        let time = segtime.selectedSegmentIndex
        let index = segindex.selectedSegmentIndex
        searchedMovie = allMovie
        
        if index == 0 && time == 0{
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                sortNew()
                search()
            case 1:
                sortNew()
                sortanime()
                search()
            case 2:
                sortNew()
                sortAct()
                search()
            case 3:
                sortNew()
                sortLove()
                search()
            case 4:
                sortNew()
                sortHor()
                search()
            default:
                sortNew()
                search()
            }
        }
        else if index == 1 && time == 0{
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                sortOld()
                search()
            case 1:
                sortOld()
                sortanime()
                search()
            case 2:
                sortOld()
                sortAct()
                search()
            case 3:
                sortOld()
                sortLove()
                search()
            case 4:
                sortOld()
                sortHor()
                search()
            default:
                sortOld()
                search()
            }
            }
            else if index == 0 && time == 1{
                switch segmentedControl.selectedSegmentIndex {
                case 0:
                    sorthigh()
                    search()
                case 1:
                    sorthigh()
                    sortanime()
                    search()
                case 2:
                    sorthigh()
                    sortAct()
                    search()
                case 3:
                    sorthigh()
                    sortLove()
                    search()
                case 4:
                    sorthigh()
                    sortHor()
                    search()
                default:
                    sorthigh()
                    search()
                }
            }
            else if index == 1 && time == 1{
                switch segmentedControl.selectedSegmentIndex {
                case 0:
                    sortlow()
                    search()
                case 1:
                    sortlow()
                    sortanime()
                    search()
                case 2:
                    sortlow()
                    sortAct()
                    search()
                case 3:
                    sortlow()
                    sortLove()
                    search()
                case 4:
                    sortlow()
                    sortHor()
                    search()
                default:
                    sortlow()
                    search()
                }
            }
        movieTV.reloadData()
        }
    


    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func sortTimeAndScore(_ segmentedControl: UISegmentedControl) {
        search()
       
        let index = segindex.selectedSegmentIndex
        let time = segtime.selectedSegmentIndex
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            segindex.setTitle("最近上映", forSegmentAt: 0)
            segindex.setTitle("最舊排序", forSegmentAt: 1)
            
        case 1:
            segindex.setTitle("最高分", forSegmentAt: 0)
            segindex.setTitle("最低分", forSegmentAt: 1)
            
        default:
            break
        }
        
        movieTV.reloadData()
        if index == 0{
            
            if time == 0{
                searchedMovie.sort { (m1, m2) -> Bool in
                    return m1.release > m2.release
                }
            }else if time == 1{
                searchedMovie.sort { (m1, m2) -> Bool in
                    return m1.imdb > m2.imdb
                }
            }
        }else if index == 1{
            search()
            if time == 0{
                
                searchedMovie.sort { (m1, m2) -> Bool in
                    return m1.release < m2.release
                }
            }else if time == 1{
                searchedMovie.sort { (m1, m2) -> Bool in
                    return m1.imdb < m2.imdb
                }
            }
            
        }
        movieTV.reloadData()
        
    }
    
    @IBAction func sortRelease(_ segmentedControl: UISegmentedControl) {
        search()
        
        let time = segtime.selectedSegmentIndex
        if time == 0{
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            searchedMovie.sort { (m1, m2) -> Bool in
                return m1.release > m2.release
            }
        case 1:
            searchedMovie.sort { (m1, m2) -> Bool in
                return m1.release < m2.release
            }
        default:
            break
        }
        movieTV.reloadData()
        }else {
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                searchedMovie.sort { (m1, m2) -> Bool in
                    return m1.imdb > m2.imdb
                }
            case 1:
                searchedMovie.sort { (m1, m2) -> Bool in
                    return m1.imdb < m2.imdb
                }
            default:
                break
            }
        movieTV.reloadData()
        }
    }
    
    
    func segStyle(){
        let font = UIFont.systemFont(ofSize: 16)
//        segtype.backgroundColor =
        for segment in segmentStyle{
            segment.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .selected)
            segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
            segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemTeal], for: .normal)
            segment.layer.borderWidth = 2
            segment.layer.borderColor = CGColor(red: 0, green: 0.3, blue: 0.5, alpha: 1)
    
        }
    }
    
    
    func getMovies(completion: @escaping ([Movie]) -> Void) {
        var movies = [Movie]()
        db.collection("movies").getDocuments { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
               return
            }
            for document in querySnapshot.documents {
                let movie = Movie(documentData: document.data())
                movies.append(movie)
            }
            completion(movies)
        }
    }
    
}

extension TopViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchedMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var showCell : Movie
        showCell = searchedMovie[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tvCell") as! TVCells
        if showCell.poster.isEmpty{
             cell.imageViewCell.image = UIImage(named: "noimage")
        }else{
//          cell.imageViewCell.image = showCell.image)
//            let cell_Image = storage.reference().child(showCell.poster)
//            print(cell_Image)
//            cell_Image.getData(maxSize: 10*1024*1024) { (data, error) in
//                if let imageData = data {
//                    cell.imageViewCell.image = UIImage(data: imageData)
//                }else{
//                    cell.imageViewCell.image = UIImage(named: "noimage")
//                }
//            }
            let task = URLSession.shared.dataTask(with:  URL(string: showCell.poster)!) { data, res, err in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.imageViewCell.image = UIImage(data: data)
                    }
                } else {
//                    print("err: \(err)")
                }
            }
            cell.task = task
            task.resume()
            
//            cell.imageViewCell.image = try? UIImage(data: Data(contentsOf: URL(string: showCell.poster)!))
            cell.textViewCell.text = showCell.info
            
            
        }
        return cell
    }
}


