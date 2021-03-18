//
//  TakeitHomeViewController.swift
//  takeit_top
//
//  Created by Lee on 2021/2/4.
//

import Firebase
import FirebaseFirestore
import FirebaseStorage
import UIKit
import Foundation

//class TopViewController: UIViewController, UICollectionViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
//
//    var allMovie:[Movie]!
//    var searchedMovie : [Movie]!
//
//
//    @IBOutlet weak var segtime: UISegmentedControl!
//
//    @IBOutlet weak var segtype: UISegmentedControl!
//
//    @IBOutlet weak var segindex: UISegmentedControl!
//
//    @IBOutlet weak var movieTV: UITableView!
//
//    @IBOutlet var segmentStyle: [UISegmentedControl]!
//
//    @IBOutlet weak var topPosterCollectionView: UICollectionView!
//
//    @IBOutlet weak var TopSearchBar: UISearchBar!
//
//    @IBOutlet weak var mainSV: UIStackView!
//
//    let imageID = ["001.jpg", "000.jpg", "002.jpg"]
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageID.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCells", for: indexPath) as! CVCell
//        cell.CVimageView.image = UIImage(named: imageID[indexPath.item])
//        return cell
//    }
//
////    let NVsearchBar = UISearchController(searchResultsController: nil)
//
//
//    @objc func keyboardWillShow(notification: Notification) {
//        // 能取得鍵盤高度就讓view上移鍵盤高度，否則上移view的1/3高度
////        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
////            let keyboardRect = keyboardFrame.cgRectValue
////            let keyboardHeight = keyboardRect.height
////            mainSV.frame.origin.y = -keyboardHeight
////        } else {
////            mainSV.frame.origin.y = -mainSV.frame.height / 4
////
////        }
//        let keyFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
//        mainSV.frame.origin.y = keyFrame.origin.y - mainSV.frame.height
//    }
//
//    @objc func keyboardWillHide(notification: Notification) {
//        let keyFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
//        mainSV.frame.origin.y = keyFrame.origin.y - mainSV.frame.height - 44
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        TopSearchBar.barTintColor = UIColor.black
//        TopSearchBar.tintColor = UIColor.white
//        TopSearchBar.searchTextField.textColor = .white
//
//
////        filteredData = data
////
////        if searchText.isEmpty {
////              filteredData = data
////           } else {
////              filteredData = data.filter{$0.title.range(of: searchText, options: .caseInsensitive) != nil }
////           }
////        self.movieTV.reloadData()
//
//
//        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
//        view.addGestureRecognizer(tap)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//
////        self.navigationItem.searchController = NVsearchBar
////        self.navigationItem.searchController?.delegate = self
////        navigationItem.searchController?.searchBar.delegate = self
////        NVsearchBar.searchResultsUpdater = self
////        navigationItem.hidesSearchBarWhenScrolling = false
//
//        segStyle()
//        allMovie = getMovies()
//        searchedMovie = allMovie
//
//        searchedMovie = searchedMovie.sorted { (m1, m2) -> Bool in
//            return m1.release > m2.release
//        }
//
//        topPosterCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .top, animated: true)
//        let flowLayout = topPosterCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
//        let width = UIScreen.main.bounds.width
//        let height = UIScreen.main.bounds.height
//        flowLayout?.itemSize = CGSize(width: width, height: height/4)
//
//
//
//    }
//
//    //navigation searchBar保留keyword
////    var previousText: String = ""
////
////    func willDismissSearchController(_ searchController: UISearchController) {
////        previousText = searchController.searchBar.searchTextField.text ?? ""
////    }
////
////    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
////        searchBar.searchTextField.text = previousText
////        return true
////    }
////
////    func isEnabledForSegment(at segment: Int) -> Bool{
////        return true
////    }
//
////    func getBarState() -> [Bool] {
////
////        var states: [Bool] = []
////        for i in 0..<segmentStyle.count {
////                states.append(isEnabledForSegment(forSegment: i))
////            }
////            return states
////    }
//    func sortNew(){
//
//    searchedMovie = searchedMovie.sorted {$0.release > $1.release}
//        movieTV.reloadData()
//    }
//    func sortOld(){
//
//    searchedMovie = searchedMovie.sorted {$0.release < $1.release}
//        movieTV.reloadData()
//    }
//    func sortanime(){
//
//        searchedMovie = searchedMovie.filter{$0.type == "動畫"}
//        movieTV.reloadData()
//    }
//
//    func sortnonanime(){
//
//        searchedMovie = searchedMovie.filter{$0.type != "動畫"}
//        movieTV.reloadData()
//    }
//
//    func search(){
//
//        let index = segindex.selectedSegmentIndex
//        let type = segtype.selectedSegmentIndex
//
//        if TopSearchBar.text! == "" {
//            if index == 0 {
//                switch type {
//                case 0:
//                    sortNew()
//
//                case 1:
//                    sortNew()
//                    sortanime()
//                case 2:
//                    sortNew()
//                    sortnonanime()
//                default:
//                    sortNew()
//                }
//                }
//            else if index == 1{
//                switch type {
//                case 0:
//                    sortOld()
//                case 1:
//                    sortOld()
//                    sortanime()
//                case 2:
//                    sortOld()
//                    sortnonanime()
//                default:
//                    sortOld()
//                }
//                }
//        }
////        if TopSearchBar.text! != ""{
////            searchedMovie = allMovie.filter{
////                $0.name.uppercased().contains(TopSearchBar.text!.uppercased())
////            }
//
//        if index == 0 {
//            switch type {
//            case 0:
//                sortNew()
//            case 1:
//                sortNew()
//                sortanime()
//            case 2:
//                sortNew()
//                sortnonanime()
//            default:
//                sortNew()
//            }
//        }
//        else if index == 1{
//            switch type {
//            case 0:
//                sortOld()
//            case 1:
//                sortOld()
//                sortanime()
//            case 2:
//                sortOld()
//                sortnonanime()
//            default:
//                sortOld()
//            }
//            }
//        }
//    }
//
////    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
////
////        searchedMovie = allMovie
////
////        search()
////    }
//
//    func updateSearchResults(for searchController: UISearchController) {
//
//    }
//
////    override func viewDidAppear(_ animated: Bool) {
////
////
////    }
//
////    @IBAction func sortType(_ segmentedControl: UISegmentedControl) {
////
////
////        let index = segindex.selectedSegmentIndex
////        searchedMovie = allMovie
////
////        if index == 0{
////            switch segmentedControl.selectedSegmentIndex {
////            case 0:
////                sortNew()
////                search()
////            case 1:
////                sortNew()
////                sortanime()
////                search()
////            case 2:
////                sortNew()
////                sortnonanime()
////                search()
////            default:
////                sortNew()
////                search()
////            }
////        }
////        else {
////            switch segmentedControl.selectedSegmentIndex {
////            case 0:
////                sortOld()
////                search()
////            case 1:
////                sortOld()
////                sortanime()
////                search()
////            case 2:
////                sortOld()
////                sortnonanime()
////                search()
////
////            default:
////                sortOld()
////                search()
////            }
////        }
////        movieTV.reloadData()
////    }
//
//
////    @IBAction func sortTimeAndScore(_ segmentedControl: UISegmentedControl) {
////        let index = segmentStyle[0].selectedSegmentIndex
////        let segtime = segmentStyle[1].selectedSegmentIndex
////
////        switch segmentedControl.selectedSegmentIndex {
////        case 0:
////            break
////        case 1:
////            break
////        default:
////            break
////        }
//
////    }
//
////    @IBAction func sortRelease(_ segmentedControl: UISegmentedControl) {
////
////
////        switch segmentedControl.selectedSegmentIndex {
////        case 0:
////            searchedMovie.sort { (m1, m2) -> Bool in
////                return m1.release > m2.release
////            }
////        case 1:
////            searchedMovie.sort { (m1, m2) -> Bool in
////                return m1.release < m2.release
////            }
////        default:
////            break
////        }
////        movieTV.reloadData()
////    }
//
//
////    func segStyle(){
////        let font = UIFont.systemFont(ofSize: 16)
//
////        for segment in segmentStyle{
////            segment.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .selected)
////            segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
////            segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
////        }
////    }
////    func getMovies() -> [Movie] {
////        var movies = [Movie]()
////
////        movies.append(Movie(name: "123", type: "動畫", grade: "非限制級", release: "2021-01-01", min: 151, url: "www.123.com", image: UIImage(named: "m000.png")!))
////        movies.append(Movie(name: "456", type: "劇情", grade: "非限制級", release: "2021-01-02", min: 140, url: "www.456.com", image: UIImage(named: "m001.png")!))
////        movies.append(Movie(name: "789", type: "懸疑", grade: "非限制級", release: "2021-01-23", min: 120, url: "www.789.com", image: UIImage(named: "m002.png")!))
////        movies.append(Movie(name: "356", type: "喜劇", grade: "非限制級", release: "2021-02-26", min: 151, url: "www.789.com", image: UIImage(named: "m003.png")!))
////        movies.append(Movie(name: "289", type: "劇情", grade: "非限制級", release: "2021-01-20", min: 100, url: "www.789.com", image: UIImage(named: "m004.png")!))
////        movies.append(Movie(name: "289", type: "動畫", grade: "非限制級", release: "2021-01-28", min: 200, url: "www.789.com", image: UIImage(named: "m005.png")!))
////
////        return movies
////    }
////}
////
////
////extension TopViewController: UITableViewDataSource, UITableViewDelegate{
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////
////        return searchedMovie.count
////    }
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////
////        var searchmovie : Movie
////        searchmovie = searchedMovie[indexPath.row]
////        let cell = tableView.dequeueReusableCell(withIdentifier: "tvCell") as! TVCells
////        cell.imageViewCell.image = searchmovie.image
////        cell.textViewCell.text = searchmovie.info
////
////        return cell
////
////    }
////
//
////}
//
