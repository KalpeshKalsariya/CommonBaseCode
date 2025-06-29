//
//  AWSManager.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation

class AWSManager: NSObject {
    
    class func uploadMediaToS3Bucket(isForProfile: Bool = false, bucketName: String, mediaKey: String, image: UIImage, fileURL: URL?, type: MediaType, isSuccess: @escaping (Bool) -> (), failure: @escaping (Bool) -> (), progressBlock: @escaping (CGFloat) -> ()) {
        
        let S3BucketName = bucketName
        
        let transferManager = AWSS3TransferUtility.default { error in
            print("AWS Error Block :- \(String(describing: error))")
        }

        if type == .image {
            let expression = AWSS3TransferUtilityMultiPartUploadExpression()
            expression.setValue("public-read-write", forRequestHeader: "x-amz-acl")
            expression.setValue("public-read-write", forRequestParameter: "x-amz-acl")

            
            guard let imageData = image.jpegData(compressionQuality: 0.7) else {
                failure(true)
                return
            }
            print("uploading Image")
            
            let progressBlock: AWSS3TransferUtilityMultiPartProgressBlock = { task, progress in
                progressBlock(CGFloat(progress.fractionCompleted))
            }
            expression.progressBlock = progressBlock

            transferManager.uploadUsingMultiPart(data: imageData, bucket: S3BucketName, key: mediaKey, contentType: "image/jpeg", expression: expression) { task, error in
                if error != nil {
                    failure(true)
                } else {
                    isSuccess(true)
                }
            }
        } else {
            let expression = AWSS3TransferUtilityUploadExpression()
            expression.setValue("public-read-write", forRequestHeader: "x-amz-acl")
            expression.setValue("public-read-write", forRequestParameter: "x-amz-acl")

            let progressBlock: AWSS3TransferUtilityProgressBlock = { task, progress in
                progressBlock(CGFloat(progress.fractionCompleted))
            }
            expression.progressBlock = progressBlock

            guard let url = fileURL else { return }
            
            print("uploading \(type == .video ? "Video" : "File")")

            transferManager.uploadFile(url, bucket: S3BucketName, key: mediaKey, contentType: type == .video ? "video" : "", expression: expression) { task, error in
                if error != nil {
                    failure(true)
                } else {
                    isSuccess(true)
                }
            }
        }
    }
}
