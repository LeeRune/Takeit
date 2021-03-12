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
        "Order_Amount":order_amount,
        "Order_Seat":order_seat,
        "Order_Updatetime":order_updatetime]
        
        return documentData
    }
}