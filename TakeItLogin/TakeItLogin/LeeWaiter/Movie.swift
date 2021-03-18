//
//  Movie.swift
//  takeit_top
//
//  Created by Lee on 2021/2/24.
//

import UIKit
import Foundation
import FirebaseFirestore

class Movie {
    
    init(documentData: [String : Any]) {
        Movie_ID = documentData["Movie_ID"] as? String ?? ""
        imdb = documentData["imdb"] as? String ?? ""
        intro = documentData["intro"] as? String ?? ""
        movieName = documentData["movieName"] as? String ?? ""
        poster = documentData["poster"] as? String ?? ""
        release = documentData["release"] as? String ?? ""
        runtime = Int(documentData["runtime"] as? TimeInterval ?? 0)
        type = documentData["type"] as? String ?? ""
        viedourl = documentData["viedourl"] as? String ?? ""
    }
    
    func documentData() -> [String : Any] {
        let documentData = [
        "Movie_ID":Movie_ID,
        "imdb":imdb,
        "intro":intro,
        "movieName":movieName,
        "poster":poster,
        "release":release,
        "runtime":runtime,
        "type":type,
        "viedourl":viedourl
        ] as [String : Any]
        return documentData
    }
    
    var Movie_ID = ""
    var imdb = ""
    var intro = ""
    var movieName = ""
    var poster = ""
    var release = ""
    var runtime = 0
    var type = ""
    var viedourl = ""

    let originFont = UIFont(name: "System", size: 12)
    let Font01 = UIFont(name: "System", size: 20)
    
    var info: String {
        let text = "電影名: \(movieName)\n上映日: \(release)\n類型: \(type)\nIMDB分數: \(imdb)\n片長: \(calTime(interval: TimeInterval(runtime)))"
        return text
    }
    
    
    func calTime(interval: TimeInterval) -> NSString {

      let ti = NSInteger(interval)
        
//      let seconds = ti % 60
      let minutes = (ti % 100)
      let hours = (ti / 100)
    
      return NSString(format: "%0.2d時 %0.2d分",hours,minutes)
    }

    
//    let formatter = DateComponentsFormatter()
//    let second: TimeInterval = 62410
//    let message = formatter.string(from: second)
    
//      `Movie_Type_ID` INT NULL COMMENT '電影類型ID(FK)',
//      `Grade_Type_ID` INT NULL COMMENT '分級類型ID(FK)',
//      `Name`  '電影名稱',
//      `Release_Date` DATETIME NOT NULL COMMENT '上映日期',
//      `Photo` LONGBLOB NULL DEFAULT NULL COMMENT '電影圖片',
//      `Intro` VARCHAR(500) NOT NULL COMMENT '電影簡介',
//      `URL` VARCHAR(100) NOT NULL COMMENT '預告URL',
//      `Min` INT NOT NULL COMMENT '電影長度',
//      `Director` VARCHAR(50) NOT NULL COMMENT '導演',
//      `Actor` VARCHAR(100) NOT NULL COMMENT '演員',
//
//
//
//     `Name` VARCHAR(50) NOT NULL COMMENT '影城名稱',
//      `Phone` CHAR(10) NULL DEFAULT NULL COMMENT '影城電話',
//      `Address` VARCHAR(200) NULL DEFAULT NULL COMMENT '影城地址',
//      `Longitude` DOUBLE NOT NULL COMMENT '經度',
//      `Latitude` DOUBLE NOT NULL COMMENT '緯度',
//      `Photo` LONGBLOB NULL DEFAULT NULL COMMENT '影城照片',
//      `Intro` VARCHAR(500) NULL DEFAULT NULL COMMENT '影城簡介',
//      `City_ID` INT NULL COMMENT '縣市ID',
//      `Area_ID` INT NULL COMMENT '地區ID',
}
