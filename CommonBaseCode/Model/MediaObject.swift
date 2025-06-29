//
//  MediaObject.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation

class MediaObject: NSObject {
    
    var name: String
    var bucketName: String
    var key: String
    var type: MediaType
    var image: UIImage
    var url: URL?
    var actualLink: URL?
    var thumbnailURL: URL?
    var thumbnail: UIImage
    var attachmentID: Int = 0
    var attachmentDisplayName: String
    
    init?(bucketName: String, key: String, type: MediaType, image: UIImage, url: URL?,attachmentID:Int,mainURL: URL?,thumbnailURL: URL?, attachmentDisplayName: String = "") {
        self.bucketName = bucketName
        self.key = key
        self.name = "\(self.bucketName)/\(self.key)"
        self.type = type
        self.image = image
        self.url = url
        self.thumbnail = UIImage()
        self.attachmentID = attachmentID
        self.actualLink = mainURL
        self.thumbnailURL = thumbnailURL
        self.attachmentDisplayName = attachmentDisplayName
    }
    
    
    init(bucket bucketName: String = "",keyName key: String = "",mediaType type: MediaType = .image,mediaImage image: UIImage = UIImage(),mediaURL url: URL? = nil,attachmentID:Int = 0,mainURL: URL? = nil, attachementDisplayName: String = ""){
        
        self.bucketName = bucketName
        self.key = key
        self.name = "\(self.bucketName)/\(self.key)"
        self.type = type
        self.image = image
        self.url = url
        self.thumbnail = UIImage()
        self.attachmentID = attachmentID
        self.actualLink = mainURL
        self.attachmentDisplayName = attachementDisplayName
    }
}
