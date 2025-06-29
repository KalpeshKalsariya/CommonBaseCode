//
//  FileDownloader.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation

class FileDownloader {
    
    static func loadFileSync(mediaObj: MediaObject, completion: @escaping (String?, Error?) -> Void)
    {
        guard let url = mediaObj.url else { return }
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        var folder = ""
        if mediaObj.type == .file {
            folder = "\(AppConstant.LocalFolderType.files)/\(url.lastPathComponent)"
        } else if mediaObj.type == .image {
            folder = "\(AppConstant.LocalFolderType.images)/\(url.lastPathComponent)"
        } else {
            folder = "\(AppConstant.LocalFolderType.videos)/\(url.lastPathComponent)"
        }
        
        let destinationUrl = documentsUrl.appendingPathComponent(folder)
        
        //        if FileManager().fileExists(atPath: destinationUrl.path)
        //        {
        //            print("File already exists [\(destinationUrl.path)]")
        //            completion(destinationUrl.path, nil)
        //        }
        //        else
        if let dataFromURL = NSData(contentsOf: url)
        {
            if dataFromURL.write(to: destinationUrl, atomically: true)
            {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            }
            else
            {
                let fileManager = FileManager()
                var folderType = ""
                if mediaObj.type == .file {
                    folderType = "\(AppConstant.LocalFolderType.files)"
                } else if mediaObj.type == .image {
                    folderType = "\(AppConstant.LocalFolderType.images)"
                } else {
                    folderType = "\(AppConstant.LocalFolderType.videos)"
                }
                do {
                    try fileManager.createDirectory(at: documentsUrl.appendingPathComponent(folderType), withIntermediateDirectories: true, attributes: nil)
                    if dataFromURL.write(to: destinationUrl, atomically: true) {
                        print("file saved [\(destinationUrl.path)]")
                        completion(destinationUrl.path, nil)
                    } else {
                        print("error saving file")
                        let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                        completion(destinationUrl.path, error)
                    }
                } catch(let error) {
                    completion(destinationUrl.path, error)
                }
                
                //                print("error saving file")
                //                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                //                completion(destinationUrl.path, error)
            }
        }
        else
        {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion(destinationUrl.path, error)
        }
    }
    
    static func loadFileAsync(mediaObj: MediaObject, completion: @escaping (String?, Error?) -> Void)
    {
        guard let url = mediaObj.url else { return }
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var folder = ""
        if mediaObj.type == .file {
            folder = "\(AppConstant.LocalFolderType.files)/\(url.lastPathComponent)"
        } else if mediaObj.type == .image {
            folder = "\(AppConstant.LocalFolderType.images)/\(url.lastPathComponent)"
        } else {
            folder = "\(AppConstant.LocalFolderType.videos)/\(url.lastPathComponent)"
        }
        
        let destinationUrl = documentsUrl.appendingPathComponent(folder)
        
        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            completion("File already exists!", nil)
        }
        else
        {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler:
                                            {
                data, response, error in
                if error == nil
                {
                    if let response = response as? HTTPURLResponse
                    {
                        if response.statusCode == 200
                        {
                            if let data = data
                            {
                                if let _ = try? data.write(to: destinationUrl, options: .atomic)
                                {
                                    completion("File saved", error)
                                    self.saveFileToPhotos(url: destinationUrl, type: mediaObj.type)
                                }
                                else
                                {
                                    let fileManager = FileManager()
                                    var folderType = ""
                                    if mediaObj.type == .file {
                                        folderType = "\(AppConstant.LocalFolderType.files)"
                                    } else if mediaObj.type == .image {
                                        folderType = "\(AppConstant.LocalFolderType.images)"
                                    } else {
                                        folderType = "\(AppConstant.LocalFolderType.videos)"
                                    }
                                    do {
                                        try fileManager.createDirectory(at: documentsUrl.appendingPathComponent(folderType), withIntermediateDirectories: true, attributes: nil)
                                        if let _ = try? data.write(to: destinationUrl, options: .atomic) {
                                            completion("File saved", nil)
                                            self.saveFileToPhotos(url: destinationUrl, type: mediaObj.type)
                                        } else {
                                            completion("Error saving file", error)
                                        }
                                    } catch(let error) {
                                        completion("Error saving file", error)
                                    }
                                }
                            }
                            else
                            {
                                let error = NSError(domain:"Error downloading file", code:1001, userInfo:nil)
                                completion("Error downloading file", error)
                            }
                        } else {
                            let error = NSError(domain:"Error downloading file", code:1001, userInfo:nil)
                            completion("Error downloading file", error)
                        }
                    } else {
                        let error = NSError(domain:"Error downloading file", code:1001, userInfo:nil)
                        completion("Error downloading file", error)
                    }
                }
                else
                {
                    completion("Error downloading file", error)
                }
            })
            task.resume()
        }
    }
    
    class func checkIfFileExists(mediaObj: MediaObject) -> Bool {
        guard let url = mediaObj.url else { return false }
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var folder = ""
        if mediaObj.type == .file {
            folder = "\(AppConstant.LocalFolderType.files)/\(url.lastPathComponent)"
        } else if mediaObj.type == .image {
            folder = "\(AppConstant.LocalFolderType.images)/\(url.lastPathComponent)"
        } else {
            folder = "\(AppConstant.LocalFolderType.videos)/\(url.lastPathComponent)"
        }
        
        let destinationUrl = documentsUrl.appendingPathComponent(folder)
        
        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            return true
        } else {
            return false
        }
    }
    
    class func saveFileToPhotos(url: URL, type: MediaType) {
        PHPhotoLibrary.shared().performChanges {
            if type == .image {
                PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
            } else if type == .video {
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
            }
        } completionHandler: { isSuccess, error in
        }
    }
}
