//
//  SeatViewController.swift
//  SeatTest
//
//  Created by 李易潤 on 2021/1/31.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class SeatVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var minusChildButton: UIButton!
    @IBOutlet weak var addChildButton: UIButton!
    @IBOutlet weak var minusAdultButton: UIButton!
    @IBOutlet weak var addAdultButton: UIButton!
    @IBOutlet weak var childCountLabel: UILabel!
    @IBOutlet weak var adultCountLabel: UILabel!
    @IBOutlet weak var seatSelectLabel: UILabel!
    @IBOutlet weak var seatOrderLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var seatID: UILabel!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet var memberSelection: [UIButton]!
    @IBOutlet weak var screen: UIView!
    @IBOutlet weak var seatCollectionView: UICollectionView!
    
    
    let buttonPadding:CGFloat = 10
    
    var classTitle = ["one","two","three"]
//    var seatLayout = ["One":[1,1,1,1,1,1,1,2,2,1],
//                      "Two":[2,1,1,1,1,1,1,2,2,2,
//                              1,2,1,1,1,1,1,2,2,1,
//                              1,1,1,1,1,1,1,2,2,1],
//                      "Three":[1,1,1,1,1,1,1,2,2,1,
//                                1,1,1,1,1,1,1,2,2,1,
//                                1,1,1,1,1,1,1,2,2,1,
//                                1,1,1,1,2,1,1,1,1,1,
//                                1,1,2,2,2,2,1,1,1,1,
//                                1,2,2,1,1,1,2,2,2,1]]
    var seatLayout = Dictionary<String, Array<Int>>()
//        = [
//        "One":[1,1,1,1,1,1,1,2,2,1],
//                      "Two":[2,1,1,1,1,1,1,2,2,2,
//                              1,2,1,1,1,1,1,2,2,1,
//                              1,1,1,1,1,1,1,2,2,1],
//                      "Three":[1,1,1,1,1,1,1,2,2,1,
//                                1,1,1,1,1,1,1,2,2,1,
//                                1,1,1,1,1,1,1,2,2,1,
//                                1,1,1,1,2,1,1,1,1,1,
//                                1,1,2,2,2,2,1,1,1,1,
//                                1,2,2,1,1,1,2,2,2,1]]
//    var seatLayout: [String:Any] = ["Station_ID": "aaa",
//        "One":[1,1,1,1,1,1,1,2,2,1],
//                      "Two":[2,1,1,1,1,1,1,2,2,2,
//                              1,2,1,1,1,1,1,3,3,1,
//                              1,1,1,1,1,1,1,2,2,1],
//                      "Three":[1,1,1,1,1,1,1,2,2,1,
//                                1,1,1,1,1,1,1,2,2,1,
//                                1,1,1,1,1,1,1,2,2,1,
//                                1,1,1,1,2,1,1,1,1,1,
//                                1,1,2,2,2,2,1,1,1,1,
//                                1,2,2,1,1,1,2,2,2,1]]
//    guard let seatLayout = document.data() else { retur; }
    
//    guard let seatLayout["One"] = document.data()["One"] as? [Int] else {
//        return;
//    }
    var totalFoodCount: Int = 0
    var seatCount: Int = 0
    var selectCount: Int = 0
    var adultCount: Int = 0
    var childCount: Int = 0
    var seatAmount: Int = 0
    var foodAmount: Int = 0
    var scView:UIScrollView!
    var xOffset:CGFloat = 10
    var foodCountArray = [UILabel]()
//    var foodSaleArray = [400,300,300,200,100,300,400,500,200,100]
    var seatRow: Int = 0
    var seatColumn: Int = 0
    var seatSelected: String = ""
    var movieID: String = ""
    var db: Firestore!
    var storage: Storage!
    var movies: [Movie]!
    var foodArray: [Food]!
    var stationArray: [Station]!

    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...memberSelection.count-1{
            memberSelection[i].contentVerticalAlignment = .fill
            memberSelection[i].contentHorizontalAlignment = .fill
        }
        
        screen.layer.cornerRadius = 3
        screen.layer.masksToBounds = true
        movieID = "2gqYScw0gbYnCQmPul7v"
        db = Firestore.firestore()
        storage = Storage.storage()
        foodArray = [Food]()
        movies = [Movie]()
        stationArray = [Station]()
        showAllStations()
        showAllFoods()
    }
    
    func showAllFoods() {
        db.collection("movies").document("2gqYScw0gbYnCQmPul7v").collection("foods").getDocuments { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("showAllComments() error: \(error!.localizedDescription)")
                return
            }
            var foods = [Food]()
            for document in snapshot.documents {
                // 呼叫自訂Spot建構式可以將document data轉成spot
                foods.append(Food(documentData: document.data()))
            }
            self.foodArray = foods
            self.addScrollFood()
        }
    }
    
    func showAllStations() {
        db.collection("stations").getDocuments { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("showAllStations() error: \(error!.localizedDescription)")
                return
            }
            var stations = [Station]()
            for document in snapshot.documents {
                // 呼叫自訂Spot建構式可以將document data轉成spot
                stations.append(Station(documentData: document.data()))
            }
            self.stationArray = stations
            self.seatLayout = ["one" : self.stationArray[0].one, "two" : self.stationArray[0].two, "three" : self.stationArray[0].three]
            self.seatCollectionView.reloadData()

        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return classTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("3")
        
        return (seatLayout[classTitle[section]]?.count) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let deviceWidth = (view.frame.width/10)-10
        return CGSize(width: deviceWidth, height: deviceWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seatCell", for: indexPath) as! seatCell
        if seatLayout[classTitle[indexPath.section]]![indexPath.row] == 0 {
            
            cell.seat.image = nil
        }else if seatLayout[classTitle[indexPath.section]]![indexPath.row] == 1 {
            
            cell.seat.image = #imageLiteral(resourceName: "filled")
        }else if seatLayout[classTitle[indexPath.section]]![indexPath.row] == 2 {
            
            cell.seat.image = #imageLiteral(resourceName: "unFilled")
        }else{
            
            cell.seat.image = #imageLiteral(resourceName: "selected")
        }
        
        //儲存已選位置
        if seatLayout[classTitle[indexPath.section]]![indexPath.row] == 3{
            if(indexPath.row/10) > 0{
                seatRow = (indexPath.section + 1) + (indexPath.row / 10)
                seatColumn = (indexPath.row % 10) + 1
                seatSelected = "第\(seatRow)排\(seatColumn)號"
            }else{
                
                seatRow = indexPath.section + 1
                seatColumn = indexPath.row + 1
                seatSelected = "第\(seatRow)排\(seatColumn)號"
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if seatLayout[classTitle[indexPath.section]]![indexPath.row] != 0 && seatLayout[classTitle[indexPath.section]]![indexPath.row] != 1 {
            
            if seatLayout[classTitle[indexPath.section]]![indexPath.row] != 3{
                
                seatLayout[classTitle[indexPath.section]]![indexPath.row] = 3

                seatCount += 1
                if seatCount == 1{
                    
                    showBottomView()
                    addAdultButton.isEnabled = true
                    addChildButton.isEnabled = true
                }
            }else{
                
                seatLayout[classTitle[indexPath.section]]![indexPath.row] = 2
                seatCount -= 1
                if seatCount == 0{
                    
                    hideBottomView()
                    addAdultButton.isEnabled = false
                    addChildButton.isEnabled = false
                }
                
                adultCount = 0
                childCount = 0
                seatAmount = 0
                adultCountLabel.text = "\(adultCount)"
                childCountLabel.text = "\(childCount)"
                seatSelectLabel.text = "\(adultCount + childCount)"
                seatID.text = "金額：\(seatAmount)"
                addAdultButton.isEnabled = true
                addChildButton.isEnabled = true
                minusAdultButton.isEnabled = false
                minusChildButton.isEnabled = false
            }
            
            seatOrderLabel.text = String(seatCount)
            seatCollectionView.reloadData()
        }
        
    }
    
    func showBottomView(){
        seatCollectionView.scrollsToTop = true
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            
            self.bottomViewHeight.constant = 50
            self.view.layoutIfNeeded()
            self.seatID.text = "金額：0"
            self.payButton.setTitle("結帳", for: .normal)
        }
        
        animator.startAnimation()
    }
    
    func hideBottomView(){
        
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.bottomViewHeight.constant = 0
            self.view.layoutIfNeeded()
            self.payButton.setTitle("", for: .normal)
        }
        
        animator.startAnimation()
    }
    
    //建立餐點ScrollView
    func addScrollFood(){

        scView = UIScrollView(frame: CGRect(x: 0, y: 610, width: view.bounds.width, height: 140))
        view.addSubview(scView)
        scView.translatesAutoresizingMaskIntoConstraints = false
//        print("foodArray1:\(foodArray)")
        for i in 0 ... foodArray.count-1 {
            
            let foodButton = UIButton()
//            let foodbutton = UIImage()
            let addFoodCountButton = UIButton()
            let minusFoodCountButton = UIButton()
            let foodCountLabel = UILabel()
            foodCountArray.append(foodCountLabel)
            
            //賦予按鈕tag值做為點擊判斷
            addFoodCountButton.tag = i
            minusFoodCountButton.tag = i
            
            //調整各個元件位置
            foodButton.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 140, height: 80)
            addFoodCountButton.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding) + foodButton.frame.height, width: 30 , height: 30)
            minusFoodCountButton.frame = CGRect(x: xOffset + addFoodCountButton.frame.width + 80, y: CGFloat(buttonPadding) + foodButton.frame.height, width: 30, height: 30)
            foodCountLabel.frame = CGRect(x: xOffset + addFoodCountButton.frame.width, y: CGFloat(buttonPadding) + foodButton.frame.height, width: 80, height: 30)
            
            let foodsArray = foodArray[i]
            let imageRef = Storage.storage().reference().child("foodPhoto/\(foodsArray.food_id).jpg")

            // 設定最大可下載10M
            imageRef.getData(maxSize: 10 * 1024 * 1024) { (data, error) in
                if let imageData = data {
                    foodButton.setImage(UIImage(data: imageData), for: .normal)
                }
            }
            
//            foodButton.setImage(UIImage(named: "1"), for: .normal)
            addFoodCountButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
            minusFoodCountButton.setImage(UIImage(systemName: "minus.circle"), for: .normal)
            
            //設定按鈕大小
            addFoodCountButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
            minusFoodCountButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
            
            foodCountLabel.text = "0"
            foodCountLabel.textAlignment = NSTextAlignment.center
            
            //按鈕點擊時觸發事件
            addFoodCountButton.addTarget(self, action: #selector(clickAdd), for: UIControl.Event.touchUpInside)
            minusFoodCountButton.addTarget(self, action: #selector(clickMinus), for: UIControl.Event.touchUpInside)
            
            xOffset = xOffset + CGFloat(buttonPadding) + foodButton.frame.size.width
            scView.addSubview(foodButton)
            scView.addSubview(addFoodCountButton)
            scView.addSubview(foodCountLabel)
            scView.addSubview(minusFoodCountButton)
        }
        
        scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)
    }
    
    @IBAction func addAdult(_ sender: Any) {
        
        adultCount += 1
        adultCountLabel.text = "\(adultCount)"
        seatSelectLabel.text = "\(adultCount + childCount)"
        seatAmount = (adultCount * 300) + (childCount * 250)
        seatID.text = "金額：\(seatAmount)"
        if seatSelectLabel.text == seatOrderLabel.text{
            
            addAdultButton.isEnabled = false
            addChildButton.isEnabled = false
            payButton.isEnabled = true
            payButton.backgroundColor = UIColor.systemRed
        }
        
        minusAdultButton.isEnabled = true
    }
    
    @IBAction func minusAdult(_ sender: Any) {
        
        payButton.isEnabled = false
        payButton.backgroundColor = UIColor.darkGray
        adultCount -= 1
        adultCountLabel.text = "\(adultCount)"
        seatSelectLabel.text = "\(adultCount + childCount)"
        seatAmount = (adultCount * 300) + (childCount * 250)
        seatID.text = "金額：\(seatAmount)"
        if adultCountLabel.text == "0"{
            
            minusAdultButton.isEnabled = false
        }
        
        addAdultButton.isEnabled = true
        addChildButton.isEnabled = true
    }
    
    @IBAction func addChild(_ sender: Any) {
        
        childCount += 1
        childCountLabel.text = "\(childCount)"
        seatSelectLabel.text = "\(adultCount + childCount)"
        seatAmount = (adultCount * 300) + (childCount * 250)
        seatID.text = "金額：\(seatAmount)"
        if seatSelectLabel.text == seatOrderLabel.text{
            
            addAdultButton.isEnabled = false
            addChildButton.isEnabled = false
            payButton.isEnabled = true
            payButton.backgroundColor = UIColor.systemRed
        }
        
        minusChildButton.isEnabled = true
    }
    
    @IBAction func minusChild(_ sender: Any) {
        
        payButton.isEnabled = false
        payButton.backgroundColor = UIColor.darkGray
        childCount -= 1
        childCountLabel.text = "\(childCount)"
        seatSelectLabel.text = "\(adultCount + childCount)"
        seatAmount = (adultCount * 300) + (childCount * 250)
        seatID.text = "金額：\(seatAmount)"
        if childCountLabel.text == "0"{
            
            minusChildButton.isEnabled = false
        }
        
        addAdultButton.isEnabled = true
        addChildButton.isEnabled = true
    }
   
    @IBAction func payButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "OrderRulesSegue", sender: 0)
    }
    
    @objc func clickAdd(_ sender: UIButton) {
        

        let foodSale = foodArray[sender.tag].food_price
        let foodCount = foodCountArray[sender.tag]
        var total: Int = 0
        
        for i in 0...foodArray.count - 1{
            total += Int(foodCountArray[i].text ?? "") ?? 0
            
        }
        
        if total < Int(seatSelectLabel.text ?? "") ?? 0{
            
            totalFoodCount += 1
            foodCount.text = "\(totalFoodCount)"
            foodAmount = (Int(foodCount.text ?? "") ?? 0) * foodSale
            seatID.text = "金額：\(seatAmount + foodAmount)"
            print(total)
        }else{
            
            total = Int(seatSelectLabel.text ?? "") ?? 0
        }
    }
    @objc func clickMinus(_ sender: UIButton) {
        
        let foodSale = foodArray[sender.tag].food_price
        let foodCount = foodCountArray[sender.tag]
        var total: Int = 0
//        var totalFoodCount: Int = 0
        
        for i in 0...foodCountArray.count - 1{

            total += Int(foodCountArray[i].text ?? "") ?? 0
        }
        totalFoodCount -= 1
        
        if totalFoodCount < 0{
            
            totalFoodCount = 0
        }
        print(total)
        foodCount.text = "\(totalFoodCount)"
        foodAmount = (Int(foodCount.text ?? "") ?? 0) * foodSale
        seatID.text = "金額：\(seatAmount + foodAmount)"
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        saveData()
    }
    
    //將總金額、所選座位資料存入UserDefault
    func saveData(){
        
        let userDefaults = UserDefaults.standard
        let amount = seatAmount + foodAmount
        let seatSelection = seatSelected
        userDefaults.set(amount, forKey: "amount")
        userDefaults.set(seatSelection, forKey: "seatSelection")
    }
    
}
