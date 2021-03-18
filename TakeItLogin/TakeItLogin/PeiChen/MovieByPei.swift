//
//  Movie.swift
//  Tackit
//
//  Created by 傅培禎 on 2021/3/15.
//

import UIKit
import Foundation
import FirebaseFirestore


class MovieByPei {
    
    var name: String!
    var detail: String!
    var image: UIImage!


    init(name: String, detail: String, image: UIImage!) {
        self.name = name
        self.detail = detail
        self.image = image
    }
    
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
    
    
    
}
