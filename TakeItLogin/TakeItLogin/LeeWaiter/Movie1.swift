//
//  Movie.swift
//  takeit_top
//
//  Created by Lee on 2021/2/24.
//

import UIKit
import Foundation

class Movie {
    internal init(name: String, type: String, grade: String, release: String, min: TimeInterval, url: String, image: UIImage) {
        self.name = name
        self.type = type
        self.grade = grade
        self.release = release
        self.min = min
        self.url = url
        self.image = image
    }
    
    var name: String
    var type: String
    var grade: String
    var release: String
    var min: TimeInterval
    var url: String
    var image : UIImage
    
    var info: String {
        let text = "電影名: \(name)\n上映日: \(release)\n類型: \(type)\n級別: \(grade)\n片長: \(minTime(interval: min))"
        return text
    }
    
    
    func minTime(interval: TimeInterval) -> NSString {

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
