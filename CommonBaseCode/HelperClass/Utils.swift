//
//  Utils.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation

class Utils: NSObject {
    
    class func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }
    
    //MARK: - Get Currency String Method
    class func getCurrencyString(fromAmount amount: Float) -> String? {
        return Utils.getCurrencyString(fromAmountString: String(format: "%.2f", amount))
    }
    
    class func getCurrencyString(fromAmountString amount: String?) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.isLenient = true
        formatter.generatesDecimalNumbers = true
        
        let temp = "\(amount ?? "")"
        let number = formatter.number(from: temp) as? NSDecimalNumber
        if let aNumber = number {
            return formatter.string(from: aNumber)
        }
        return nil
    }
    
    
    class func getFloatFromString(amount_currency: String?) -> Float? {
        var amount : String = "0"
        if  (amount_currency?.count)! > 0 {
            amount = amount_currency!
        }
        
        amount = amount.replacingOccurrences(of: "$", with: "")
        amount = amount.replacingOccurrences(of: "₹", with: "")
        amount = amount.replacingOccurrences(of: ",", with: "")
        amount = amount.replacingOccurrences(of: "Charge ", with: "")
        let amount_float = (amount as NSString).floatValue
        return amount_float
    }
    
    //MARK: - Price Format Method
    class func getModifyCurrencyStyle(_ amount: String?, font: UIFont?) -> NSMutableAttributedString? {
        return Utils.getAttrbutedCurrencyString(-13, andFontSize: font, andAmount: amount)
    }
    
    class func getAttrbutedCurrencyString(_ offset: NSNumber?, andFontSize font: UIFont?, andAmount str: String?) -> NSMutableAttributedString? {
        
        var str = str
        str = str?.replacingOccurrences(of: ".", with: "")
        
        let tempstring = str
        let buyString = NSMutableAttributedString(string: tempstring ?? "")
        let customFont = UIFont(name: font?.fontName ?? "", size: (font?.pointSize ?? 0.0) + 20)
        
        if let aFont = customFont, let anOffset = offset {
            buyString.setAttributes([NSAttributedString.Key.font: aFont, NSAttributedString.Key.baselineOffset: anOffset], range: NSRange(location: 1, length: (str?.count ?? 0) - 3))
        }
        
        return buyString
    }
    
    class func containsSelectedId(check:[[[String]]], forElement: [[String]]) -> Bool {
        return check.contains { element in
            
            return areEqual(a: element, b: forElement)
        }
    }
    
    class func areEqual( a:[[String]],  b:[[String]]) -> Bool {
        for i in 0..<a.count {
            let sorteda = a[i].sorted()
            let sortedb = b[i].sorted()
            
            if sorteda != sortedb {
                return false
            }
        }
        return true
    }
    
    //MARK: - Price Format Method
    class func priceCurrencyStyle(offset: NSNumber , andfontSize font: UIFont, andAmount strAmount : String) -> NSMutableAttributedString {
        let tempstring = strAmount.replacingOccurrences(of: ".", with: "")
        let buyString = NSMutableAttributedString(string: tempstring)
        let customFont = UIFont(name: font.fontName , size: font.pointSize + 20)
        if let aFont = customFont {
            buyString.setAttributes([NSAttributedString.Key.font: aFont, NSAttributedString.Key.baselineOffset: offset], range: NSRange(location: 1, length: strAmount.count - 3))
        }
        return buyString
    }
    
    //MARK: - Adding Space In textfield Method
    class func addPaddingInTextField(sender: UITextField) {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5.0, height: 20.0))
        sender.leftView = paddingView
        sender.leftViewMode = .always
    }
    
    class func getDeviceCountrySymbol() -> String?{
        var currencySymbol : String = ""
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            print(countryCode)
            
            let currencySymbolCode = getCurrencySymbolFromCode(countryCode: countryCode)
            print(currencySymbolCode)
            
            currencySymbol = getSymbolForCurrencyCode(code: currencySymbolCode)!
            print(currencySymbol)
        }
        
        return currencySymbol
    }
    
    class func getCurrencySymbolFromCode(countryCode : String) -> String{
        let countryCodeCA = countryCode
        let localeIdCA = NSLocale.localeIdentifier(fromComponents: [ NSLocale.Key.countryCode.rawValue : countryCodeCA])
        let localeCA = NSLocale(localeIdentifier: localeIdCA)
        let currencyCodeCA = localeCA.object(forKey: NSLocale.Key.currencyCode)
        return currencyCodeCA! as! String
    }
    
    class func getSymbolForCurrencyCode(code: String) -> String? {
        //let locale = NSLocale(localeIdentifier: code)
        //let currency = locale.displayName(forKey: .currencySymbol, value: code)
        //return currency
        
        let locale = NSLocale(localeIdentifier: code)
        let currencySymbol = "\(locale.displayName(forKey: .currencySymbol, value: code) ?? "")"
        return currencySymbol
    }
    
    class func getBytesFromHexString(_ strIn: String) -> NSData? {
        
        guard let chars = strIn.cString(using: String.Encoding.utf8) else { return nil}
        var i = 0
        let length = strIn.count
        
        let data = NSMutableData(capacity: length/2)
        var byteChars: [CChar] = [0, 0, 0]
        
        var wholeByte: CUnsignedLong = 0
        
        while i < length {
            byteChars[0] = chars[i]
            i+=1
            byteChars[1] = chars[i]
            i+=1
            wholeByte = strtoul(byteChars, nil, 16)
            data?.append(&wholeByte, length: 1)
        }
        
        return data
    }
    
    class func pathZigZagForView(givenView: UIView) ->UIBezierPath {
        let width = givenView.frame.size.width
        let height = givenView.frame.size.height
        
        let givenFrame = givenView.frame
        let zigZagWidth = CGFloat(7)
        let zigZagHeight = CGFloat(5)
        var yInitial = height-zigZagHeight
        
        let zigZagPath = UIBezierPath(rect: givenFrame.insetBy(dx: 5, dy: 5))
        zigZagPath.move(to: CGPoint(x:0, y:0))
        zigZagPath.addLine(to: CGPoint(x:0, y:yInitial))
        
        var slope = -1
        var x = CGFloat(0)
        var i = 0
        while x < width {
            x = zigZagWidth * CGFloat(i)
            let p = zigZagHeight * CGFloat(slope) - 5
            let y = yInitial + p
            let point = CGPoint(x: x, y: y)
            zigZagPath.addLine(to: point)
            slope = slope*(-1)
            i += 1
        }
        
        zigZagPath.addLine(to: CGPoint(x:width,y: 0))
        
        yInitial = 0 + zigZagHeight
        x = CGFloat(width)
        i = 0
        while x > 0 {
            x = width - (zigZagWidth * CGFloat(i))
            let p = zigZagHeight * CGFloat(slope) + 5
            let y = yInitial + p
            let point = CGPoint(x: x, y: y)
            zigZagPath.addLine(to: point)
            slope = slope*(-1)
            i += 1
        }
        zigZagPath.close()
        return zigZagPath
    }
    
    class func applyZigZagEffect(givenView: UIView) {
        let shapeLayer = CAShapeLayer(layer: givenView.layer)
        givenView.backgroundColor = UIColor.clear
        shapeLayer.path = pathZigZagForView(givenView: givenView).cgPath
        shapeLayer.frame = givenView.bounds
        shapeLayer.frame.size.width = 1000
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.masksToBounds = false
        shapeLayer.shadowOpacity = 1
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 3
        
        givenView.layer.addSublayer(shapeLayer)
    }
    
    class func sendSocketEmitData(socketID: String, screenName: String) {
        
        var dictlanguages = [String]()
        dictlanguages.append("\(Locale.current.identifier)")
        
        var dictscreen = [String: AnyObject]()
        dictscreen["screen"] = ["height": "\(AppConstant.ScreenSize.SCREEN_HEIGHT)",
                                "width": "\(AppConstant.ScreenSize.SCREEN_WIDTH)"] as AnyObject
        
        
        var pageName: String = screenName.replacingOccurrences(of: "VC", with: "")
        pageName = pageName.replacingOccurrences(of: "MainViewController", with: "BaseView")
        
        var dictdata = [String: AnyObject]()
        dictdata["data"] = ["token": "login user access token",
                            "page_title": "Dashboard",
                            "page_path": "\(pageName)",
                            "user_id": "Login User Id"] as AnyObject
        
        var dictMain = [String:AnyObject]()
        dictMain["data"] = dictdata["data"]
        
        if let json = try? JSONSerialization.data(withJSONObject: dictMain, options: []) {
            if let content = String(data: json, encoding: .utf8) {
                print("Socket JSON: \(content)")
                
                SocketManager.shared.emit(emitterName: AppConstant.SocketKeys.socketEvent.kActivity, params: content)
                
                SocketManager.shared.listen(listnerName: AppConstant.SocketKeys.socketEvent.kActivityReplay) { responseData in
                    guard let arrAID = responseData as? [String] else { return }
                    let strAID = arrAID[0]
                    print("Socket Replay Id: \(strAID)")
                }
            }
        }
    }
    
    class func convertDictionaryToJsonString(dictionary: JSONType) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Error converting dictionary to JSON string: \(error)")
        }
        return nil
    }
    
    class func timeAgoSince(_ date: Date) -> String {
        //    print(date)
        let calendar = Calendar.current
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        dateFormatter.dateFormat = "dd-MMM-YYYY HH:mm:ss"
        let strCurrentDate : NSString = dateFormatter.string(from: now) as NSString
        dateFormatter.dateFormat = "dd-MMM-YYYY HH:mm:ss"
        let strFormated : NSString = String(format: "%@ 23:59:59", strCurrentDate) as NSString
        dateFormatter.dateFormat = "dd-MMM-YYYY HH:mm:ss"
        let nowDate = dateFormatter.date(from: strFormated as String)
        
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: date, to: nowDate!, options: [])
        print(components)
        if let year = components.year, year >= 2 {
            //        return "\(year) years ago"
            return "Last year"
        }
        
        if let year = components.year, year >= 1 {
            return "Last year"
        }
        
        if let month = components.month, month >= 2 {
            //        return "\(month) months ago"
            return "Last year"
        }
        
        if let month = components.month, month >= 1 {
            return "Last month"
        }
        
        if let week = components.weekOfYear, week >= 2 {
            //        return "\(week) weeks ago"
            //        return "Last week"
            return "Last month"
        }
        
        if let week = components.weekOfYear, week >= 1 {
            return "Last week"
        }
        
        if let day = components.day, day >= 2 {
            //        return "\(day) days ago"
            return "Last week"
        }
        
        if let day = components.day, day >= 1 {
            return "Yesterday"
        }
        
        if let hour = components.hour, hour >= 2 {
            //        return "\(hour) hours ago"
            return "Today"
        }
        
        if let hour = components.hour, hour >= 1 {
            //        return "An hour ago"
            return "Today"
        }
        
        if let minute = components.minute, minute >= 2 {
            //        return "\(minute) minutes ago"
            return "Today"
        }
        
        if let minute = components.minute, minute >= 1 {
            //        return "A minute ago"
            return "Today"
        }
        
        if let second = components.second, second >= 3 {
            //        return "\(second) seconds ago"
            return "Today"
        }
        
        return "Just now"
        
    }
    
    class func timeAgoSinceString(strDate : String) -> Int {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        dateFormatter.dateFormat = "dd-MMM-YYYY HH:mm:ss"
        let strCurrentDate = dateFormatter.string(from: now)
        dateFormatter.dateFormat = "dd-MMM-YYYY HH:mm:ss"
        let strFormated = String(format: "%@ 23:59:59", strCurrentDate)
        dateFormatter.dateFormat = "dd-MMM-YYYY HH:mm:ss"
        let nowDate = dateFormatter.date(from: strFormated as String)
        let nowTimeInMiliSeconds : TimeInterval = (nowDate?.timeIntervalSince1970)!*1000
        var CurrentintervalString = String(format: "%f", nowTimeInMiliSeconds)
        CurrentintervalString = CurrentintervalString.replacingOccurrences(of: ".000000", with: "")
        
        dateFormatter.dateFormat = "dd-MMM-YYYY HH:mm:ss"
        let serverDate = dateFormatter.date(from: strDate as String)
        let serverTimeInMiliSeconds : TimeInterval = (serverDate?.timeIntervalSince1970)!*1000
        var ServerintervalString = String(format: "%f", serverTimeInMiliSeconds)
        ServerintervalString = ServerintervalString.replacingOccurrences(of: ".000000", with: "")
        
        let diffnow = (Double(CurrentintervalString) ?? 0) - (Double(ServerintervalString) ?? 0)
        var different = Int(diffnow)
        let secondsInMilli: Int = 1000
        let minutesInMilli: Int = secondsInMilli * 60
        let hoursInMilli: Int = minutesInMilli * 60
        let daysInMilli: Int = hoursInMilli * 24
        let elapsedDays: Int = different / daysInMilli
        different = different % daysInMilli
        let elapsedHours: Int = different / hoursInMilli
        different = different % hoursInMilli
        let elapsedMinutes: Int = different / minutesInMilli
        different = different % minutesInMilli
        let elapsedSeconds: Int = different / secondsInMilli
        
        // Hear Return 0 For Today
        // 1 For Yesterday
        // 2 For Last Week
        // 3 For Last Month
        // 4 For Older
        
        different = different % secondsInMilli
        
        if elapsedDays == 0 {
            if elapsedHours == 0 {
                if elapsedMinutes == 0 {
                    if elapsedSeconds < 0 {
                        return 0
                    } else {
                        if elapsedDays > 0 && elapsedSeconds < 59 {
                            return 0
                        } else {
                            return 0
                        }
                    }
                } else {
                    return 0
                }
            } else {
                return 0
            }
        } else {
            if elapsedDays == 1 {
                return 1
            } else if elapsedDays <= 7 {
                return 2
            } else if elapsedDays <= 30 {
                return 3
            } else {
                return 4
            }
        }
    }
    
    class func openURLInBrowser(url:URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    class func convertCalendarTimeDisplay(dateString: String) -> String {
        if dateString == "" {
            return ""
        }
        var value = String()
        var hrStr = ""
        var minStr = ""
        var isAM = false
        let str = dateString
        let arrTime = str.components(separatedBy: ":")
        if arrTime.isEmpty {
            return ""
        }
        
        if let hr = Int(arrTime[0]) {
            
            if hr >= 12 {
                isAM = false
                if hr == 12 {
                    hrStr = "\(hr)"
                } else {
                    if (hr - 12) < 10 {
                        hrStr = "0\(hr - 12)"
                    } else {
                        hrStr = "\(hr - 12)"
                    }
                }
                
            } else {
                isAM = true
                hrStr = "\(hr)"
            }
            
        }
        
        if let min = Int(arrTime[1]) {
            
            if min < 10 {
                minStr = "0\(min)"
            } else {
                minStr = "\(min)"
            }
            
        }
        
        if isAM {
            value = "\(hrStr):\(minStr) AM"
        } else {
            value = "\(hrStr):\(minStr) PM"
        }
        
        return value
    }
    
    class func resolutionForVideo(url: URL) -> CGSize? {
        guard let track = AVURLAsset(url: url).tracks(withMediaType: AVMediaType.video).first else { return nil }
        let size = track.naturalSize.applying(track.preferredTransform)
        return CGSize(width: abs(size.width), height: abs(size.height))
    }
    
    class func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    class func getDuration(second:CGFloat) -> String {
        if second > 0 {
            let hours = Int(second / 3600)
            let minutes = Int((second.truncatingRemainder(dividingBy: 3600)) / 60)
            let seconds = Int(second.truncatingRemainder(dividingBy: 60))
            
            var time = ""
            if hours > 0
            {
                time = NSString (format: "%02d:%02d:%02d",hours ,minutes,seconds) as String
            }
            else{
                time = NSString (format: "%02d:%02d",minutes,seconds) as String
            }
            return time
        }
        else {
            return "00:00"
        }
    }
    
    class func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        return nil
    }
    
    class func checkCameraPermisson(compltion:@escaping(Bool) -> Void){
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            compltion(true)
            // Already Authorized
        } else {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
                if granted == true {
                    // User granted
                    compltion(true)
                } else {
                    compltion(false)
                    // User rejected
                }
            })
        }
    }
    
    // to check photoLibrary Permission
    class func checkPhotoLibraryPermission(compltion:@escaping(Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            compltion(true)
            //handle authorized status
        case .denied, .restricted :
            compltion(false)
            //handle denied status
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    compltion(true)
                    // as above
                case .denied, .restricted:
                    compltion(false)
                    // as above
                case .notDetermined:
                    compltion(true)
                    // won't happen but still
                case .limited:
                    compltion(true)
                @unknown default:
                    compltion(true)
                }
            }
        case .limited:
            compltion(true)
        @unknown default:
            compltion(true)
        }
    }
    
    class func setStringForKey(_ value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
        
    class func fetchString(forKey key: String) -> String {
        if UserDefaults.standard.string(forKey: key) == nil {
            return ""
        }
        return UserDefaults.standard.string(forKey: key)!
    }
    
    class func setBoolForKey(_ value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func fetchBool(forKey key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
}


