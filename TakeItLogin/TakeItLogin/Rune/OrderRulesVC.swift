//
//  OrderRulesViewController.swift
//  Takeit_iOS
//
//  Created by 李易潤 on 2021/2/22.
//

import UIKit
import TPDirect

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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        checkButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        
        //預設按鈕預設圖案及被選取圖案
        self.checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        self.checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        
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

        let alert = UIAlertController(title: "", message: "請選擇支付方式", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let creditCard = UIAlertAction(title: "信用卡", style: .default, handler: {
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
        if let seatSelection = userDefaults.string(forKey: "seatSelection") {
            self.seatSelection = seatSelection
            
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
                    if let result = try? JSONSerialization.jsonObject(with: data!) {
                        if let resultDic = result as? [String: Any] {
                            // 取得 payment_url，在前端使用TPDirect.redirect(payment_url)，讓使用者進行 LINE Pay付款
                            let payment_url = resultDic["payment_url"] as! String
                            self.linePay.redirect(payment_url, with: self, completion: { (linePayResult) in
                                print("\n----------LINE Pay Result--------------")
                                print(linePayResult)
                            })
                        }
                    }
                    
                    
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
}
