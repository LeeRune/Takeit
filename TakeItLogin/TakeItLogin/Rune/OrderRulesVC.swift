//
//  OrderRulesViewController.swift
//  Takeit_iOS
//
//  Created by 李易潤 on 2021/2/22.
//

import UIKit
import TPDirect
import Firebase
import FirebaseFirestore
import FirebaseStorage

class OrderRulesVC: UIViewController {
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var orderRulesTextView: UITextView!
    
    //TapPay路徑
    let frontend_rediret_url = "https://example.com/front-end-redirect"
    let backend_notify_url = "https://example.com/back-end-notify"
    
    var linePay: TPDLinePay!
    var movieName: String = ""
    var citySelection: String = ""
    var stationSelection: String = ""
    var dateSelection: String = ""
    var timeSelection: String = ""
    var amount: String = ""
    var seatSelection: String = ""
    var tpdCard : TPDCard!
    var tpdForm : TPDForm!
    var merchant : TPDMerchant!
    var consumer : TPDConsumer!
    var cart     : TPDCart!
    var movieID: String = ""
    var db: Firestore!
    var storage: Storage!
    var ordersArray: [Order]!
    var orders: Order!
    var station: Station!
    var seatArray: Station!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        checkButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        
        //預設按鈕預設圖案及被選取圖案
        self.checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        self.checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        movieID = "2gqYScw0gbYnCQmPul7v"
        movieName = "神力女超人"
        stationSelection = "信義威秀影城"
        dateSelection = "03/12"
        timeSelection = "13:00"
        amount = "600"
        seatSelection = "第3排7號\n第3排8號"
        db = Firestore.firestore()
        storage = Storage.storage()
        ordersArray = [Order]()
        orders = Order()
        station = Station()
        
        loadData()
    }
    
    @IBAction func checkButton(_ sender: UIButton) {
        
        if sender.isSelected {
            
            self.checkButton.isSelected = false
            self.agreeButton.backgroundColor = UIColor.darkGray
            self.agreeButton.isEnabled = false
        } else {
            
            self.checkButton.isSelected = true
            self.agreeButton.isEnabled = true
            self.agreeButton.backgroundColor = UIColor.systemRed
        }
    }
    
    @IBAction func agreeButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "訂票資訊", message: "電影名稱：\(movieName)\n影城：\(stationSelection)\n日期：\(dateSelection)\n場次：\(timeSelection)\n金額：\(amount)\n座位：\(seatSelection)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "確認", style: .default) { ACTION in
            self.showPay()
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        
        station.station_id = self.db.collection("stations").document("EaIHFDOomX8cczurdJ7I").documentID

        print(seatArray)
        
    }
    
    //支付方式Alert
    func showPay(){
        let alert = UIAlertController(title: "", message: "請選擇支付方式", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let creditCard = UIAlertAction(title: "信用卡", style: .default, handler: {
            ACTION in
            let creditview = UIView()
            creditview.frame = CGRect(x: 15, y: 60, width: 260, height: 80)
            self.tpdForm = TPDForm.setup(withContainer: creditview)
            let creditAlert = UIAlertController(title: "", message: "請輸入信用卡資訊", preferredStyle: .alert)
            let creditOk = UIAlertAction(title: "確定", style: .default) { ACTION in
                self.tpdCard = TPDCard.setup(self.tpdForm)
                self.tpdCard.onSuccessCallback { (prime, cardInfo, cardIdentifier, merchantReferenceInfo) in
                        self.generatePayByPrimeForSandBox(prime: prime!)
                    }.onFailureCallback { (status, msg) in
                        print("status : \(status), msg : \(msg)")
                    }.getPrime()
                let payOkAlert = UIAlertController(title: "", message: "付款成功", preferredStyle: .alert)
                        let payOk = UIAlertAction(title: "確定", style: .default, handler: {
                            ACTION in
                            let id = self.db.collection("orders").document().documentID
                //            let userUID = UserDefaults.standard.string(forKey: "user_uid_key")!
                            let userID = "SJwwaqgTGiQRxjdlwYV6Yhj6Kb33"
                            let date = Date()
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let result = formatter.string(from: date)
                            self.orders.uid = userID
                            self.orders.order_id = id
                            self.orders.movie_id = self.movieID
                            self.orders.movie_name = self.movieName
                            self.orders.order_station = self.stationSelection
                            self.orders.order_date = self.dateSelection
                            self.orders.order_time = self.timeSelection
                            self.orders.order_amount = self.amount
                            self.orders.order_seat = self.seatSelection
                            self.orders.order_updatetime = result
                            self.addOrder(order: self.orders)
                            
                            
                            //跳回首頁
                            self.navigationController?.popToRootViewController(animated: true)
                        })
                payOkAlert.addAction(payOk)
                        self.present(payOkAlert, animated: true, completion: nil)
            }
            let creditCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let height:NSLayoutConstraint = NSLayoutConstraint(item: creditAlert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
            
            creditAlert.view.addConstraint(height)
            creditAlert.view.addSubview(creditview)
            creditAlert.addAction(creditOk)
            creditAlert.addAction(creditCancel)
            self.present(creditAlert, animated: true, completion: nil)
        })
        let apple = UIAlertAction(title: "ApplePay", style: .default, handler: {
            ACTION in
            let alert = UIAlertController(title: "", message: "付款成功", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "確定", style: .default, handler: {
                        ACTION in
                        
                        //跳回首頁
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
        })
        let line = UIAlertAction(title: "LinePay", style: .default, handler: {
            ACTION in
            
            // 初始化TPDLinePay物件
            self.linePay = TPDLinePay.setup(withReturnUrl: "MayLinePayDemo://com.ron.MyLinePayDemo")

            // 檢查裝置是否可使用LINE Pay
            if (TPDLinePay.isLinePayAvailable()){
                
                // linePay呼叫getPrime()以取得prime，並從onSuccessCallback取得
                self.linePay.onSuccessCallback { (prime) in
                    self.generatePayByPrimeForSandBox(prime: prime!)
                }.onFailureCallback { (status, msg) in
                    print("status : \(status), msg : \(msg)")
                }.getPrime()
            } else {
                
                // 開啟App Store的Line App安裝畫面
                TPDLinePay.installLineApp()
            }
            
            //跳回首頁
            self.navigationController?.popToRootViewController(animated: true)
        })
        
        alert.addAction(creditCard)
        alert.addAction(apple)
        alert.addAction(line)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    //讀取UserDefault資料
    func loadData() {

        let userDefaults = UserDefaults.standard
        if let movieName = userDefaults.string(forKey: "movieName") {
            self.movieName = movieName
        }
        if let citySelection = userDefaults.string(forKey: "citySelection") {
            self.citySelection = citySelection
        }
        if let stationSelection = userDefaults.string(forKey: "stationSelection") {
            self.stationSelection = stationSelection
        }
        if let dateSelection = userDefaults.string(forKey: "dateSelection") {
            self.dateSelection = dateSelection
        }
        if let timeSelection = userDefaults.string(forKey: "timeSelection") {
            self.timeSelection = timeSelection
        }
        if let amount = userDefaults.string(forKey: "amount") {
            self.amount = amount
        }
        if let seatArray = userDefaults.object(forKey: "seatArray"){
            self.seatArray = seatArray as! Station
        }
    }
    
    func generatePayByPrimeForSandBox(prime: String) {
        let url_TapPay = URL(string: tapPaySanbox)
        var cardholderDic = [String: String]()
        cardholderDic["name"] = "Lee"
        cardholderDic["phone_number"] = "+886912345678"
        cardholderDic["email"] = "lee@email.com"
        
        var resultUrlDic = [String: String]()
        resultUrlDic["frontend_redirect_url"] = self.frontend_rediret_url
        resultUrlDic["backend_notify_url"] = self.backend_notify_url
        
        var paymentDic = [String: Any]()
        paymentDic["partner_key"] = partnerKey
        paymentDic["prime"] = prime
        paymentDic["merchant_id"] = merchantId
        paymentDic["amount"] = amount
        paymentDic["currency"] = "TWD"
        paymentDic["order_number"] = "SN0001"
        paymentDic["details"] = "電影名稱：\n\(movieName)\n影城：\n\(stationSelection)\n日期：\n\(dateSelection)\n場次：\n\(timeSelection)\n座位：\(seatSelection)"
        paymentDic["cardholder"] = cardholderDic
        paymentDic["result_url"] = resultUrlDic
        
        executeTask(url_TapPay!, paymentDic) { (data, response, error) in
            if error == nil {
                if data != nil {
                    let text = String(data: data!, encoding: .utf8)!
                    print("\n----------Success--------------")
                    print(text)
                }
            }
        }
    }
    
    func executeTask(_ url: URL, _ requestParam: [String: Any], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let jsonData = try? JSONSerialization.data(withJSONObject: requestParam) {
            // 將輸出資料列印出來除錯用
            print("output: \(String(data: jsonData, encoding: .utf8)!)")
            var request = URLRequest(url: url)
            // request header要加上Content-Type與x-api-key設定，否則支付失敗
            request.addValue(partnerKey, forHTTPHeaderField: "x-api-key")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
            request.httpBody = jsonData
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: completionHandler)
            task.resume()
        } else {
            print("executeTask error")
        }
    }
    
    func merchantSetting() {
        merchant = TPDMerchant()
        merchant.merchantName               = merchantName
        merchant.countryCode                = "TW" // 國碼
        merchant.currencyCode               = "TWD" // 交易貨幣
        merchant.supportedNetworks          = [.amex, .masterCard, .visa]
    }
    func replaceBlock(station: Station) {
        // 如果Firestore沒有該ID的Document就建立新的，已經有就更新內容
        db.collection("stations").document("EaIHFDOomX8cczurdJ7I").setData(station.documentData()) { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                // 新增成功回前頁
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    func addOrder(order: Order) {
        // 如果Firestore沒有該ID的Document就建立新的，已經有就更新內容
        db.collection("orders").document(order.order_id).setData(order.documentData()) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}
