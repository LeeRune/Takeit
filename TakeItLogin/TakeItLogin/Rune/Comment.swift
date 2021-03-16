//
//  Comment.swift
//  Takeit_iOS
//
//  Created by 李易潤 on 2021/2/24.
//

import Foundation

//class Movie {
//    var movie_id = ""
//    var moviename = ""
//    var comments = comment()
//    
//    init() {
//        
//    }
//    
//    init(documentData: [String : Any]) {
//        movie_id = documentData["Movie_ID"] as? String ?? ""
//        moviename = documentData["MovieName"] as? String ?? ""
//        
//    }
//    
//    func documentData() -> [String : Any] {
//        let documentData = ["Movie_ID":movie_id,
//        "MovieName":moviename]
//        return documentData
//    }
//}

class Commenta {
    var uid = ""
    var comment_detail = ""
    var comment_star = 0
    var comment_id = ""
    var comment_updatetime = ""
    
    init() {
        
    }
    
    init(documentData: [String : Any]) {
        uid = documentData["UID"] as? String ?? ""
        comment_detail = documentData["Comment_Detail"] as? String ?? ""
        comment_star = documentData["Comment_Star"] as? Int ?? 0
        comment_id = documentData["Comment_ID"] as? String ?? ""
        comment_updatetime = documentData["Comment_Updatetime"] as? String ?? ""
    }
    
    func documentData() -> [String : Any] {
        let documentData = ["UID":uid,
        "Comment_Detail":comment_detail,
        "Comment_Star":comment_star,
        "Comment_ID":comment_id,
        "Comment_Updatetime":comment_updatetime] as [String : Any]
        return documentData
    }
}

class Food {
    var food_id = ""
    var food_price = 0
    var movie_id = ""

    init() {
        
    }
    
    init(documentData: [String : Any]) {
        food_id = documentData["Food_ID"] as? String ?? ""
        food_price = documentData["Food_Price"] as? Int ?? 0
        movie_id = documentData["Movie_ID"] as? String ?? ""
    }
    
    func documentData() -> [String : Any] {
        let documentData = ["Food_ID":food_id,
        "Food_Price":food_price,
        "Movie_ID":movie_id] as [String : Any]
        return documentData
    }
}

class Order {
    var uid = ""
    var movie_id = ""
    var order_id = ""
    var movie_name = ""
    var order_station = ""
    var order_date = ""
    var order_time = ""
    var order_count = ""
    var order_amount = ""
    var order_seat = ""
    var order_updatetime = ""
    
    init() {
        
    }
    
    init(documentData: [String : Any]) {
        uid = documentData["UID"] as? String ?? ""
        movie_id = documentData["Movie_ID"] as? String ?? ""
        order_id = documentData["Order_ID"] as? String ?? ""
        movie_name = documentData["Movie_Name"] as? String ?? ""
        order_station = documentData["Order_Station"] as? String ?? ""
        order_date = documentData["Order_Date"] as? String ?? ""
        order_time = documentData["Order_Time"] as? String ?? ""
        order_count = documentData["Order_Count"] as? String ?? ""
        order_amount = documentData["Order_Amount"] as? String ?? ""
        order_seat = documentData["Order_Seat"] as? String ?? ""
        order_updatetime = documentData["Order_Updatetime"] as? String ?? ""
    }
    
    func documentData() -> [String : Any] {
        let documentData = ["UID":uid,
        "Movie_ID":movie_id,
        "Order_ID":order_id,
        "Movie_Name":movie_name,
        "Order_Station":order_station,
        "Order_Date":order_date,
        "Order_Time":order_time,
        "Order_Count":order_count,
        "Order_Amount":order_amount,
        "Order_Seat":order_seat,
        "Order_Updatetime":order_updatetime]
        
        return documentData
    }
}

class Report {
    var uid = ""
    var report_id = ""
    var report_uid = ""
    var report_detail = ""
    var report_reason = ""
    var report_updatetime = ""
    var report_movie_id = ""
    var report_comment_id = ""
    
    init() {
        
    }
    
    init(documentData: [String : Any]) {
        uid = documentData["UID"] as? String ?? ""
        report_id = documentData["Report_ID"] as? String ?? ""
        report_uid = documentData["Report_UID"] as? String ?? ""
        report_detail = documentData["Report_Detail"] as? String ?? ""
        report_reason = documentData["Report_Reason"] as? String ?? ""
        report_movie_id = documentData["Report_Movie_ID"] as? String ?? ""
        report_comment_id = documentData["Report_Comment_ID"] as? String ?? ""
        report_updatetime = documentData["Report_Updatetime"] as? String ?? ""
        
    }
    
    func documentData() -> [String : Any] {
        let documentData = ["UID":uid,
        "Report_ID":report_id,
        "Report_UID":report_uid,
        "Report_Detail":report_detail,
        "Report_Reason":report_reason,
        "Report_Movie_ID":report_movie_id,
        "Report_Comment_ID":report_comment_id,
        "Report_Updatetime":report_updatetime]
        
        return documentData
    }
}

class Station {
    var station_id = ""
    var one = [Int]()
    var two = [Int]()
    var three = [Int]()
    
    init() {
        
    }
    
    init(documentData: [String : Any]) {
        station_id = documentData["Staion_ID"] as? String ?? ""
        one = documentData["one"] as? [Int] ?? [0]
        two = documentData["two"] as? [Int] ?? [0]
        three = documentData["three"] as? [Int] ?? [0]
    }
    
    func documentData() -> [String : Any] {
        let documentData = ["Staion_ID":station_id,
        "one":one,
        "two":two,
        "three":three] as [String : Any]
        
        return documentData
    }
}
