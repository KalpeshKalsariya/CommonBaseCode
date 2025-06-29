//
//  Extensions.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation

typealias JSONType = [String: Any]
typealias typeAliasDictionary               = [String: AnyObject]

//MARK: String Extension
extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func isValidUrlValidate() -> Bool {
        let urlRegEx = "^(https?://)?(www\\.)?([-a-zA-Z0-9]{1,63}\\.)*?[a-zA-Z0-9][-a-zA-Z0-9]{0,61}[a-zA-Z0-9]\\.[a-zA-Z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegEx)
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        return urlTest.evaluate(with: trimmedString)
    }
    
    func isEmailValidate() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    func validateMobileNo() -> Bool {
        do {
            let pattern: String = "^[6789]\\d{9}$"
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsString = self as NSString
            let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
            return results.count > 0 ? true : false
            
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    func validateEmail() -> Bool {
        do {
            //          let pattern: String = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
            let pattern: String = "[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?"
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsString = self as NSString
            let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
            return results.count > 0 ? true : false
            
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    func validateIFSCCode() -> Bool {
        do {
            //          let pattern: String = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
            let pattern: String = "^[A-Za-z]{4}0{1}[a-zA-Z0-9]{6}$"
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsString = self as NSString
            let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
            return results.count > 0 ? true : false
            
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    var isValidContact: Bool {
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func textWidth(font: UIFont?) -> CGFloat {
        let attributes = font != nil ? [NSAttributedString.Key.font: font] : [:]
        return self.size(withAttributes: attributes as [NSAttributedString.Key : Any]).width
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    // formatting text for currency textField
    func currencyInputFormattingAmount() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    
    mutating func getStringBeforeSpace() -> String {
        if self.contains(" ") {
            let check = self
            return check.components(separatedBy: " ").first ?? ""
        } else {
            return self
        }
    }
    
    mutating func getStringAfterSpace() -> String {
        if self.contains(" ") {
            let check = self
            return check.components(separatedBy: " ").last ?? ""
        } else {
            return self
        }
    }
    
    mutating func getStringAfterCharecter(ch : String) -> String {
        if self.contains(ch) {
            let check = self
            return check.components(separatedBy: ch).last ?? ""
        } else {
            return self
        }
    }
    
    mutating func getStringBeforeCharecter(ch : String) -> String {
        if self.contains(ch) {
            let check = self
            return check.components(separatedBy: ch).first ?? ""
        } else {
            return self
        }
    }
    
    mutating func encode() -> String {
        let customAllowedSet =  CharacterSet(charactersIn:" !+=\"#%/<>?@\\^`{|}$&()*-").inverted
        self = self.addingPercentEncoding(withAllowedCharacters: customAllowedSet)!
        return self
    }
    mutating func encodebase64() -> String {
        let customAllowedSet =  CharacterSet(charactersIn:" !+=\"#%/<>?@\\^`{|}$&()*-").inverted
        self = self.addingPercentEncoding(withAllowedCharacters: customAllowedSet)!
        return self
    }
    
    mutating func replace(_ string: String, withString: String) -> String {
        return self.replacingOccurrences(of: string, with: withString)
    }
    
    mutating func replaceWhiteSpace(_ withString: String) -> String {
        let components = self.components(separatedBy: CharacterSet.whitespaces)
        let filtered = components.filter({!$0.isEmpty})
        return filtered.joined(separator: "")
    }
    
    func isContainString(_ subString: String) -> Bool {
        let range = self.range(of: subString, options: NSString.CompareOptions.caseInsensitive, range: self.range(of: self))
        return range == nil ? false : true
    }
    
    func convertToUrl() -> URL {
        let data:Data = self.data(using: String.Encoding.utf8)!
        var resultStr: String = String(data: data, encoding: String.Encoding.nonLossyASCII)!
        
        if !(resultStr.hasPrefix("itms://")) && !(resultStr.hasPrefix("file://")) && !(resultStr.hasPrefix("http://")) && !(resultStr.hasPrefix("https://")) { resultStr = "http://" + resultStr }
        
        resultStr = resultStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        return URL(string: resultStr)!
    }
    
    func containsEmoji() -> Bool {
        for scalar in unicodeScalars {
            if !scalar.properties.isEmoji { continue }
            return true
        }
        
        return false
    }
    
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    func appendS3BaseURL() -> String {
        return "https://amazonaws.com\(self)"
    }
    
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
    
    func containsEmojiNew() -> Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
                0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                0x1F680...0x1F6FF, // Transport and Map
                0x2600...0x26FF,   // Misc symbols
                0x2700...0x27BF,   // Dingbats
                0xFE00...0xFE0F:   // Variation Selectors
                return true
            default:
                continue
            }
        }
        return false
    }
    
    func removeThousandSeperator() -> String {
        let decimal = self.components(separatedBy: ".")
        let intString = decimal[0].components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        let Price = intString + "." + decimal[1]
        return Price
    }
    
    func setThousandSeperator() ->String {
        return self.setThousandSeperator(self, decimal: 2)
    }
    
    func setThousandSeperator(_ string:String , decimal:Int)->String {
        let numberFormatter = NumberFormatter.init()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        //        numberFormatter.locale = Locale.init(identifier: "en_IN")
        //        numberFormatter.currencyCode = "INR"
        numberFormatter.currencySymbol = ""
        numberFormatter.decimalSeparator = "."
        numberFormatter.maximumFractionDigits = decimal
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.usesGroupingSeparator = true
        return numberFormatter.string(from: NSNumber.init(value: Double(string)! as Double))!
    }
    
    func setDecimalPoint() -> String {
        let numberFormatter:NumberFormatter = NumberFormatter.init()
        numberFormatter.decimalSeparator = "."
        numberFormatter.maximumFractionDigits = 2
        return  numberFormatter.string(from: NSNumber.init(value: Double(self)! as Double))!
    }
    
    func base64Encoded() -> String {
        if let data = self.data(using: .utf8) { return data.base64EncodedString() }
        return ""
    }
    
    func base64Decoded() -> String {
        if let data = Data(base64Encoded: self) { return String(data: data, encoding: .utf8)! }
        return ""
    }
    
    func hexToUIColor () -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.remove(at: cString.startIndex) }
        
        if ((cString.count) != 6) { return UIColor.gray }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func extractString(_ checkingType: NSTextCheckingResult.CheckingType) -> [String] {
        var arrText = [String]()
        let detector = try! NSDataDetector(types: checkingType.rawValue)
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
        
        for match in matches {
            let url = (self as NSString).substring(with: match.range)
            arrText.append(url)
        }
        return arrText
    }
    
    func getPhoneNumber() -> [String] { return self.extractString(.phoneNumber) }
    
    func getUrl() -> [String]  { return self.extractString(.link) }
    
    func getAddress() -> [String]  { return self.extractString(.address) }
    
    func getEmail() -> [String]  {
        var arrEmail = [String]()
        let arrText = self.components(separatedBy: ["\n"," ","."])
        for st in arrText {
            let isEmail: Bool = st.validateEmail()
            if isEmail { arrEmail.append(st) }
        }
        return arrEmail
    }
    
    var getIntergerFromString: String {
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars
            .flatMap { pattern ~= $0 ? Character($0) : nil })
    }
    
    public func addingPercentEncodingForQueryParameter() -> String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed)
    }
    
    func htmlAttributedString(string: String) -> NSAttributedString? {
        do {
            let modifiedFont = NSString(format:"<span style=\"font-family: Montserrat-Medium; font-size: 14 \">%@</span>" as NSString, string) as String
            let data = modifiedFont.data(using: String.Encoding.utf8, allowLossyConversion: true)
            if let d = data {
                let str = try NSAttributedString(data: d, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                return str
            }
        } catch {
        }
        return nil
    }
    
    func getHtmlString(fontSize:Int , font:UIFont , colorCode:String) -> NSAttributedString? {
        
        let modifiedFont = NSString(format:"<span style=\"font-family: 'Montserrat-Medium', '\(font.fontName)'; font-size: \(fontSize) ; color:\(colorCode) \">%@</span>" as NSString, self) as String
        do {
            return try NSAttributedString(data: modifiedFont.data(using: .utf8)!, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func capitalizeFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    func HexToColor(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersIn: "#") as CharacterSet
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
    func ToDate(dateFormate : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        dateFormatter.dateFormat = dateFormate
        let dateimagename = dateFormatter.date(from: self) ?? Date()
        return dateimagename
    }
}

//MARK: Int Extension
extension Int {
    
    var isEven: Bool {
        return self % 2 == 0
    }
}

extension UIView {
    // Example: Add a shadow to a UIView
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 5
    }
}

extension Date {
    // Example: Format a date to a string
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func formatDate(dateFormate : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        dateFormatter.dateFormat = dateFormate
        let dateimagename = dateFormatter.string(from: self)
        return dateimagename
    }
    
    func getDayFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
    
    func getMonthFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: self)
    }
    
    func getYearFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: self)
    }
}

extension UIColor {
    // Example: Create a UIColor from a hex string
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: 1.0)
    }
}

//MARK: UIVIew Property
@IBDesignable extension UIView {
    @IBInspectable
    var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
    @IBInspectable
    var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable
    var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGPoint {
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        
    }
    
    @IBInspectable
    var shadowBlur: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue / 2.0
        }
    }
    
    @IBInspectable
    var shadowRadiusView: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOffsetView: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    class func loadFromNibNamed(_ nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
        ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    func round(corners: UIRectCorner, radius: CGFloat) -> Void {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func addDashedBorder(color:UIColor, sizeview: CGSize) {
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2 + 3, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 3).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func setHighlight() {
        self.setViewBorder(UIColor.black, borderWidth: 2, isShadow: false, cornerRadius: 0, backColor: UIColor.clear)
    }
    
    func unSetHighlight() {
        self.setViewBorder(UIColor.black, borderWidth: 1, isShadow: false, cornerRadius: 0, backColor: UIColor.clear)
    }
    
    func setBottomBorder(_ borderColor: UIColor, borderWidth: CGFloat) {
        let tagLayer: String = "100000"
        if self.layer.sublayers!.count > 1 && self.layer.sublayers?.last?.accessibilityLabel == tagLayer {
            self.layer.sublayers?.last?.removeFromSuperlayer()
        }
        let border: CALayer = CALayer()
        border.backgroundColor = borderColor.cgColor;
        border.accessibilityLabel = tagLayer;
        border.frame = CGRect(x: 0, y: self.frame.height - borderWidth, width: self.frame.width, height: borderWidth);
        self.layer.addSublayer(border)
    }
    
    func setViewBorder(_ borderColor: UIColor, borderWidth: CGFloat, isShadow: Bool, cornerRadius: CGFloat, backColor: UIColor) {
        self.backgroundColor = backColor;
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = borderColor.cgColor;
        self.layer.cornerRadius = cornerRadius;
        //if isShadow { self.dropShadow() }
    }
    
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func dropShadow(_ shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
    
    func LableWithTag(_ tag:Int) -> UILabel {
        if let lable = self.viewWithTag(tag){
            return lable as! UILabel
        }
        return  UILabel()
    }
}

//MARK: Dissmiss Keyboard On Tap
class DissmissKeyboard {
    static func addTapGestureToDismissKeyboard(to view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapToDismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private static func handleTapToDismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//MARK: KeyboardAdonsbehaviours
class KeyboardAdonsbehaviours {
    static func adjustForKeyboard(notification: Notification, view: UIView) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { notification in
            keyboardWillShow(notification: notification, view: view)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { notification in
            keyboardWillHide(notification: notification, view: view)
        }
    }
    
    private static func keyboardWillShow(notification: Notification, view: UIView) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            view.frame.origin.y -= keyboardSize.height/2
        }
    }
    
    private static func keyboardWillHide(notification: Notification, view: UIView) {
        view.frame.origin.y = 0
    }
}

//MARK: UiView Extension
extension UIView {
    func findFirstResponder() -> UIView? {
        if isFirstResponder {
            return self
        }
        for subview in subviews {
            if let firstResponder = subview.findFirstResponder() {
                return firstResponder
            }
        }
        return nil
    }
    
    func blinkView() {
        self.alpha = 0.0
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
    }
}

//MARK: Currency and Percentage
class InputValidator {
    static func isValidCurrencyInput(_ input: String) -> Bool {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        let allowedCharacters = CharacterSet(charactersIn: "$ 0123456789\(decimalSeparator)")
        let characterSet = CharacterSet(charactersIn: input)
        return allowedCharacters.isSuperset(of: characterSet) && isValidDecimalFormat(input)
    }
    
    static func isValidPercentageInput(_ input: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.%")
        let characterSet = CharacterSet(charactersIn: input)
        return allowedCharacters.isSuperset(of: characterSet) && isValidPercentageFormat(input)
    }
    
    private static func isValidDecimalFormat(_ input: String) -> Bool {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        let components = input.components(separatedBy: decimalSeparator)
        if components.count > 2 {
            return false
        }
        if components.count == 2 && components[1].count > 2 {
            return false
        }
        return true
    }
    
    private static func isValidPercentageFormat(_ input: String) -> Bool {
        let numericText = input.replacingOccurrences(of: "%", with: "")
        if let percentageValue = Double(numericText), (0.00...100.00).contains(percentageValue) {
            return true
        }
        return false
    }
}

//MARK: Textfiled Percentage Validation
class TextFieldPercentageValidation {
    static func validateText(_ text: String, maxDecimalDigits: Int) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789.%")
        
        let characterSet = CharacterSet(charactersIn: text)
        if !characterSet.isSubset(of: allowedCharacterSet) {
            return false
        }
        
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        var textWithoutPercent = text
        if textWithoutPercent.hasSuffix("%") {
            textWithoutPercent.removeLast()
        }
        
        let components = textWithoutPercent.components(separatedBy: decimalSeparator)
        if components.count > 2 {
            return false
        }
        
        if let decimalIndex = textWithoutPercent.firstIndex(of: Character(decimalSeparator)) {
            let digitsAfterDecimal = textWithoutPercent[decimalIndex...].dropFirst()
            
            // Count the digits after the decimal, excluding the percent sign
            let digitCount = digitsAfterDecimal.filter { $0 != "%" }.count
            
            if digitCount > maxDecimalDigits {
                return false
            }
        }
        return true
    }
}

//MARK: NSAttributedString
extension NSAttributedString {
    func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }
}

//MARK: UIViewController Extension
extension UIViewController {
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func showToast(message: String?, isSuccess: Bool, withDuration:TimeInterval = 2) {
        if let msg = message {
            
            let topView = AppManager.shared.topViewController()
            
            topView.view.hideAllToasts()
            var duration = withDuration
            if (message?.count ?? 0) > 60 {
                duration = 3
            }
            topView.view?.makeToast(msg,isSuccess: isSuccess,duration: duration, completion: { (success) in
            })
        }
    }
    
    func getTopViewController() -> UIViewController {
        
        if let tabbarVC = self as? UITabBarController, let selectedVC = tabbarVC.selectedViewController {
            return selectedVC.getTopViewController()
        }
        
        if let navVC = self as? UINavigationController, let visibleVC = navVC.visibleViewController {
            return visibleVC.getTopViewController()
        }
        
        if let presentedViewController = presentedViewController {
            return presentedViewController.getTopViewController()
        }
        
        return self
        
    }
    
    func show() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}

@IBDesignable
extension UITextField {
    
    @IBInspectable
    var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable
    var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    
    @IBInspectable
    var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension Dictionary {
    
    /// convert dictionary to json string
    ///
    /// - Returns: <#return value description#>
    func convertToJSonString() -> String {
        do {
            let dataJSon = try JSONSerialization.data(withJSONObject: self as AnyObject, options: JSONSerialization.WritingOptions.prettyPrinted)
            let st: NSString = NSString.init(data: dataJSon, encoding: String.Encoding.utf8.rawValue)!
            return st as String
        } catch let error as NSError { print(error) }
        return ""
    }
    
    
    /// check given key have value or not
    ///
    /// - Parameter stKey: pass key what you want check
    /// - Returns: true if exist
    func isKeyNull(_ stKey: String) -> Bool {
        let dict: JSONType = (self as AnyObject) as! JSONType
        if let val = dict[stKey] { return val is NSNull ? true : false }
        return true
    }
    
    /// handal carsh when null valu or key not found
    ///
    /// - Parameter stKey: pass the key of object
    /// - Returns: blank string or value if exist
    func valuForKeyString(_ stKey: String) -> String {
        let dict: JSONType = (self as AnyObject) as! JSONType
        if let val = dict[stKey] {
            if val is NSNull{
                return ""
            }else if (val as? NSNumber) != nil {
                return  (val as AnyObject).stringValue
                
            }else if (val as? Float) != nil {
                return  (val as AnyObject).stringValue
            }
            else if (val as? String) != nil {
                return val as! String
            }else{
                return "\(val)"
            }
        }
        return ""
    }
    
    ///expaned function of null value
    func valuForKeyString(_ stKey: String,nullvalue:String) -> String {
        return  self.valuForKeyWithNullString(Key: stKey, NullReplaceValue: nullvalue)
    }
    
    /// Update dic with other Dictionary
    ///
    /// - Parameter other: add second Dictionary which one you want to add
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
    
    /// USE TO GET VALUE FOR KEY if key not found or null then replace with the string
    ///
    /// - Parameters:
    ///   - stKey: pass key of dic
    ///   - NullReplaceValue: set value what you want retun if that key is nill
    /// - Returns: retun key value if exist or return null replace value
    func valuForKeyWithNullString(Key stKey: String,NullReplaceValue:String) -> String {
        let dict: JSONType = (self as AnyObject) as! JSONType
        if let val = dict[stKey] {
            if val is NSNull{
                //                dLog(message: val)
                return NullReplaceValue
            } else{
                if (val as? NSNumber) != nil {
                    return  (val as AnyObject).stringValue
                }else{
                    return val as! String == "" ? NullReplaceValue : val as! String
                }
            }
        }
        return NullReplaceValue
    }
    
    func valuForKeyWithNullWithPlaseString(Key stKey: String,NullReplaceValue:String) -> String {
        let dict: JSONType = (self as AnyObject) as! JSONType
        if let val = dict[stKey] {
            if val is NSNull{
                //                dLog(message: val)
                return NullReplaceValue
            } else{
                if (val as? NSNumber) != nil {
                    if Int(truncating: val as! NSNumber) > 0{
                        return  "+" + (val as AnyObject).stringValue
                    }
                }else{
                    if Int(val as! String)! > 0{
                        return val as! String == "" ? NullReplaceValue : "+" + (val as! String)
                    }else{
                        return val as! String == "" ? NullReplaceValue : val as! String
                    }
                    
                }
            }
        }
        return NullReplaceValue
    }
    
    func valuForKeyArray(_ stKey: String) -> Array<Any> {
        let dict: JSONType = (self as AnyObject) as! JSONType
        if let val = dict[stKey] {
            if val is NSNull{
                return []
            } else{
                return val as! Array<Any>
            }
        }
        return []
    }
    
    func valuForKeyDouble(_ stKey: String) -> Double {
        var dValue: Double = 0.0
        let dict: JSONType = self as! JSONType
        if let val = dict[stKey] {
            if val is NSNull {
                return 0.0
            }
            else {
                if val is Double {
                    dValue = val as! Double
                }
                else if val is Int {
                    dValue = Double(val as! Double)
                }
                else if val is String {
                    let stValue: String = val as! String
                    dValue = (stValue as NSString).doubleValue
                }
                else if val is Float {
                    dValue = Double(val as! Double)
                }else {
                    let error = NSError(domain:stKey,
                                        code: 100,
                                        userInfo:dict)
                }
            }
        }
        return dValue
    }
    
    func valuForKeyInt( _ any:String) -> Int {
        var iValue: Int = 0
        let dict: JSONType = self as! JSONType
        if let val = dict[any] {
            if val is NSNull {
                return 0
            }
            else {
                if val is Int {
                    iValue = val as! Int
                }
                else if val is Double {
                    iValue = Int(val as! Double)
                }
                else if val is String {
                    let stValue: String = val as! String
                    iValue = (stValue as NSString).integerValue
                }
                else if val is Float {
                    iValue = Int(val as! Float)
                }else{
                    let error = NSError(domain:any,
                                        code: 100,
                                        userInfo:dict)
                }
            }
        }
        return iValue
    }
    
    func valuForKeyFloat( _ any:String) -> Float {
        var fValue: Float = 0.0
        let dict: JSONType = self as! JSONType
        if let val = dict[any] {
            if val is NSNull {
                return fValue
            }
            else {
                if val is Int {
                    fValue = val as! Float
                }
                else if val is Double {
                    fValue = Float(val as! Double)
                }
                else if val is String {
                    let stValue: String = val as! String
                    fValue = (stValue as NSString).floatValue
                }
                else if val is Float {
                    fValue = Float(val as! Float)
                }else{
                    let error = NSError(domain:any,
                                        code: 100,
                                        userInfo:dict)
                }
            }
        }
        return fValue
    }
    
    
    /// This is function for convert dicticonery to xml string also check log for other type of string i only handal 2 or 3 type of stct
    ///
    /// - Returns: return xml string
    func createXML()-> String{
        
        var xml = ""
        for k in self.keys {
            
            if let str = self[k] as? String{
                xml.append("<\(k as! String)>")
                xml.append(str)
                xml.append("</\(k as! String)>")
                
            }else if let dic =  self[k] as? Dictionary{
                xml.append("<\(k as! String)>")
                xml.append(dic.createXML())
                xml.append("</\(k as! String)>")
                
            }else if let array : NSArray =  self[k] as? NSArray{
                for i in 0..<array.count {
                    xml.append("<\(k as! String)>")
                    if let dic =  array[i] as? Dictionary{
                        xml.append(dic.createXML())
                    }else if let str = array[i]  as? String{
                        xml.append(str)
                    }else{
                        //                        dLog(message: array[i])
                        fatalError("[XML]  associated with \(self[k] as Any) not any type!")
                    }
                    xml.append("</\(k as! String)>")
                    
                }
            }else if let dic =  self[k] as? NSDictionary{
                xml.append("<\(k as! String)>")
                
                let newdic = dic as! Dictionary<String,Any>
                xml.append(newdic.createXML())
                xml.append("</\(k as! String)>")
                
            }
            else{
                //                dLog(message: self[k] as Any)
                fatalError("[XML]  associated with \(self[k] as Any) not any type!")
            }
        }
        
        return xml
    }
    
    func nullKeyRemoval() -> [AnyHashable: Any] {
        var dict: [AnyHashable: Any] = self
        
        let keysToRemove = dict.keys.filter { dict[$0] is NSNull }
        let keysToCheck = dict.keys.filter({ dict[$0] is Dictionary })
        let keysToArrayCheck = dict.keys.filter({ dict[$0] is [Any] })
        for key in keysToRemove {
            dict[key] = ""
        }
        for key in keysToCheck {
            if let valueDict = dict[key] as? [AnyHashable: Any] {
                dict.updateValue(valueDict.nullKeyRemoval(), forKey: key)
            }
        }
        for key in keysToArrayCheck {
            if var arrayDict = dict[key] as? [Any] {
                for i in  0..<arrayDict.count {
                    if let dictObj = arrayDict[i] as? [String: Any] {
                        arrayDict[i] = dictObj.nullKeyRemoval()
                    }
                }
                dict.updateValue(arrayDict, forKey: key)
            }
        }
        return dict
    }
    
    
}

extension UITableView {
    func contains(indexPath: IndexPath) -> Bool {
        // Check if the section index is valid
        guard indexPath.section < numberOfSections else {
            return false
        }
        
        // Check if the row index is valid for the given section
        return indexPath.row < numberOfRows(inSection: indexPath.section)
    }
    
    func reloadTableViewDataSmoothly() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
            self.reloadData()
            self.layoutIfNeeded()
            self.layer.removeAllAnimations()
            self.setContentOffset(self.contentOffset, animated: false)
        })
        
    }
}

class AlertController {
    static func showAlert(title: String, message : String, controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        controller.present(alert, animated: true)
    }
}

@IBDesignable
class PaddingLabel: UILabel {
    var textEdgeInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textEdgeInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textEdgeInsets.top, left: -textEdgeInsets.left, bottom: -textEdgeInsets.bottom, right: -textEdgeInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textEdgeInsets))
    }
    
    @IBInspectable
    var paddingLeft: CGFloat {
        set { textEdgeInsets.left = newValue }
        get { return textEdgeInsets.left }
    }
    
    @IBInspectable
    var paddingRight: CGFloat {
        set { textEdgeInsets.right = newValue }
        get { return textEdgeInsets.right }
    }
    
    @IBInspectable
    var paddingTop: CGFloat {
        set { textEdgeInsets.top = newValue }
        get { return textEdgeInsets.top }
    }
    
    @IBInspectable
    var paddingBottom: CGFloat {
        set { textEdgeInsets.bottom = newValue }
        get { return textEdgeInsets.bottom }
    }
    
    /*@IBInspectable
     override var cornerRadius : CGFloat {
     get { layer.cornerRadius }
     set { layer.cornerRadius = newValue }
     }
     
     @IBInspectable
     override var borderWidth : CGFloat {
     get { layer.borderWidth }
     set {
     layer.masksToBounds = true
     layer.borderWidth = newValue
     layer.cornerRadius = frame.size.width / 2
     }
     }
     
     @IBInspectable
     override var borderColor: UIColor? {
     set {
     guard let uiColor = newValue else { return }
     layer.borderColor = uiColor.cgColor
     }
     get {
     guard let color = layer.borderColor else { return nil }
     return UIColor(cgColor: color)
     }
     }*/
    
    @IBInspectable
    var background : UIColor {
        get { backgroundColor ?? .white }
        set { backgroundColor = newValue }
    }
}

extension UIImage {
    
    func crop(to:CGSize) -> UIImage {
        guard let cgimage = self.cgImage else { return self }
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        guard let newCgImage = contextImage.cgImage else { return self }
        let contextSize: CGSize = contextImage.size
        
        //Set to square
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        let cropAspect: CGFloat = to.width / to.height
        
        var cropWidth: CGFloat = to.width
        var cropHeight: CGFloat = to.height
        
        if to.width > to.height { //Landscape
            cropWidth = contextSize.width
            cropHeight = contextSize.width / cropAspect
            posY = (contextSize.height - cropHeight) / 2
        } else if to.width < to.height { //Portrait
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        } else { //Square
            if contextSize.width >= contextSize.height { //Square on landscape (or square)
                cropHeight = contextSize.height
                cropWidth = contextSize.height * cropAspect
                posX = (contextSize.width - cropWidth) / 2
            }else{ //Square on portrait
                cropWidth = contextSize.width
                cropHeight = contextSize.width / cropAspect
                posY = (contextSize.height - cropHeight) / 2
            }
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cropWidth, height: cropHeight)
        
        // Create bitmap image from context using the rect
        guard let imageRef: CGImage = newCgImage.cropping(to: rect) else { return self}
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        UIGraphicsBeginImageContextWithOptions(to, false, self.scale)
        cropped.draw(in: CGRect(x: 0, y: 0, width: to.width, height: to.height))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resized ?? self
    }
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        let rect = CGRect(origin: CGPoint.zero, size: size)
        
        color.setFill()
        self.draw(in: rect)
        
        context.setBlendMode(.sourceIn)
        context.fill(rect)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    func getPixelColor(atLocation location: CGPoint, withFrameSize size: CGSize) -> UIColor {
        let x: CGFloat = (self.size.width) * location.x / size.width
        let y: CGFloat = (self.size.height) * location.y / size.height
        
        let pixelPoint: CGPoint = CGPoint(x: x, y: y)
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelIndex: Int = ((Int(self.size.width) * Int(pixelPoint.y)) + Int(pixelPoint.x)) * 4
        
        let r = CGFloat(data[pixelIndex]) / CGFloat(255.0)
        let g = CGFloat(data[pixelIndex+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelIndex+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelIndex+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

extension URL {
    func getDataFromQueryString() -> [String: String] {
        let urlComponents: URLComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        let arrQueryItems: Array<URLQueryItem> = urlComponents.queryItems!
        var dictParams = [String: String]()
        for item:URLQueryItem in arrQueryItems { dictParams[item.name] = item.value }
        return dictParams
    }
}

extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}

extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
}

extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
        let startIndex = string.index(string.startIndex, offsetBy: location)
        let endIndex = string.index(startIndex, offsetBy: length)
        return startIndex..<endIndex
    }
}

extension Array {
    func indexExists(_ index: Int) -> Bool {
        return self.indices.contains(index)
    }
    func convertToJSonString() -> String {
        do {
            let dataJSon = try JSONSerialization.data(withJSONObject: self as AnyObject, options:[] /*JSONSerialization.WritingOptions.prettyPrinted*/)
            //let st: NSString = NSString.init(data: dataJSon, encoding: String.Encoding.utf8.rawValue)!
            let st: String = String(data: dataJSon, encoding: .utf8)!
            return st
        } catch let error as NSError {
            print(error)
            
        }
        return ""
    }
    
    func getArrayFromArrayOfDictionary(key: String, valueString: String, valueInt: String) -> [typeAliasDictionary] {
        if !valueString.isEmpty {
            let predicate = NSPredicate(format: "%K LIKE[cd] %@", key, valueString)
            print(predicate)
            return (self as NSArray).filtered(using: predicate) as! [typeAliasDictionary]
        }
        else if !valueInt.isEmpty {
            let predicate = NSPredicate(format: "%K = %d", key, Int(valueInt)!)
            return (self as NSArray).filtered(using: predicate) as! [typeAliasDictionary]
        }
        return [typeAliasDictionary]()
    }
    
    func getArrayFromArrayOfDictionary(key: String, notValueString: [String], notValueInt: [String]) -> [typeAliasDictionary] {
        if !notValueString.isEmpty {
            var arrCondition = [String]()
            for value in notValueString { arrCondition.append("(NOT \(key) LIKE[cd] \"\(value)\")") }
            let stCondition: String = arrCondition.joined(separator: " AND ")
            
            let predicate = NSPredicate(format: stCondition)
            return (self as NSArray).filtered(using: predicate) as! [typeAliasDictionary]
        }
        else if !notValueInt.isEmpty {
            //            let predicate = NSPredicate(format: "%K != %d", key, Int(notValueInt)!)
            //            return (self as NSArray).filtered(using: predicate) as! [typeAliasDictionary]
        }
        
        return [typeAliasDictionary]()
    }
    
    func getArrayFromArrayOfString(valueString: String, valueInt: String) -> [String] {
        
        if !valueString.isEmpty {
            let predicate = NSPredicate(format: "SELF LIKE[cd] %@", valueString)
            return (self as NSArray).filtered(using: predicate) as! [String]
        }
        else if !valueInt.isEmpty {
            let predicate = NSPredicate(format: "SELF = %d", Int(valueInt)!)
            return (self as NSArray).filtered(using: predicate) as! [String]
        }
        
        return [String]()
    }
    
    func getArrayFromArrayOfDictionaryKeys(key: String, valueArray: NSArray) -> [typeAliasDictionary] {
        if valueArray.count > 0 {
            let pridictarray = NSMutableArray()
            for value in valueArray{
                let predicate = NSPredicate(format: "%K LIKE[cd] %@", key, value as! CVarArg)
                pridictarray.add(predicate)
                
            }
            let andPredicate = NSCompoundPredicate(type: .or, subpredicates: pridictarray as! [NSPredicate] )
            
            return (self as NSArray).filtered(using: andPredicate) as! [typeAliasDictionary]
        }
        
        return [typeAliasDictionary]()
    }
    
}

extension UILabel {
    
    func estimatedHeightOfLabel() -> CGFloat {
        
        let size = CGSize(width: self.frame.width - 16, height: CGFloat.greatestFiniteMagnitude)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        
        let rectangleHeight = String(self.text!).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        
        return rectangleHeight+5
    }
    
    func textHeight(_ textWidth: CGFloat, textFont: UIFont) -> CGFloat {
        let textRect: CGRect = String(self.text!).boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil)
        let textSize: CGSize = textRect.size;
        
        return self.text! == "" ? 0.0 : textSize.height
    }
    
    func estimatedTextWidth() -> CGFloat {
        
        let font = UIFont.systemFont(ofSize: 17)
        let fontAttributes = [NSAttributedString.Key.font: font] // it says name, but a UIFont works
        let size = (self.text)?.size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
        return size?.width ?? 0 > 325 ? 325 : size?.width ?? 0 < 75 ? 95
        : (size!.width + 30)
    }
    
    
}

extension Double{
    func roundValue() -> Double {
        let divisor = pow(10.0, Double(2))
        return (self * divisor).rounded() / divisor
    }
}

@IBDesignable
class SpinnerView : UIView {
    
    override var layer: CAShapeLayer {
        get { return super.layer as! CAShapeLayer }
    }
    
    override class var layerClass: AnyClass { return CAShapeLayer.self }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.fillColor = nil
        layer.strokeColor = UIColor.black.cgColor//RGBCOLOR(0, g: 80, b: 39).cgColor
        layer.lineWidth = 3
        setPath()
    }
    
    override func didMoveToWindow() { animate() }
    
    private func setPath() {
        layer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: layer.lineWidth / 2, dy: layer.lineWidth / 2)).cgPath
    }
    
    struct Pose {
        let secondsSincePriorPose: CFTimeInterval
        let start: CGFloat
        let length: CGFloat
        init(_ secondsSincePriorPose: CFTimeInterval, _ start: CGFloat, _ length: CGFloat) {
            self.secondsSincePriorPose = secondsSincePriorPose
            self.start = start
            self.length = length
        }
    }
    
    class var poses: [Pose] {
        get {
            return [
                Pose(0.0, 0.000, 0.7),
                Pose(0.6, 0.500, 0.5),
                Pose(0.6, 1.000, 0.3),
                Pose(0.6, 1.500, 0.1),
                Pose(0.2, 1.875, 0.1),
                Pose(0.2, 2.250, 0.3),
                Pose(0.2, 2.625, 0.5),
                Pose(0.2, 3.000, 0.7),
            ]
        }
    }
    
    func animate() {
        var time: CFTimeInterval = 0
        var times = [CFTimeInterval]()
        var start: CGFloat = 0
        var rotations = [CGFloat]()
        var strokeEnds = [CGFloat]()
        
        let poses = type(of: self).poses
        let totalSeconds = poses.reduce(0) { $0 + $1.secondsSincePriorPose }
        
        for pose in poses {
            time += pose.secondsSincePriorPose
            times.append(time / totalSeconds)
            start = pose.start
            rotations.append(start * 2 * CGFloat(Double.pi))
            strokeEnds.append(pose.length)
        }
        
        times.append(times.last!)
        rotations.append(rotations[0])
        strokeEnds.append(strokeEnds[0])
        
        animateKeyPath(keyPath: "strokeEnd", duration: totalSeconds, times: times, values: strokeEnds)
        animateKeyPath(keyPath: "transform.rotation", duration: totalSeconds, times: times, values: rotations)
        
        animateStrokeHueWithDuration(duration: totalSeconds * 5)
    }
    
    func animateKeyPath(keyPath: String, duration: CFTimeInterval, times: [CFTimeInterval], values: [CGFloat]) {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.keyTimes = times as [NSNumber]?
        animation.values = values
        animation.calculationMode = CAAnimationCalculationMode.linear
        animation.duration = duration
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: animation.keyPath)
    }
    
    func animateStrokeHueWithDuration(duration: CFTimeInterval) {
        let count = 36
        let animation = CAKeyframeAnimation(keyPath: "strokeColor")
        animation.keyTimes = (0 ... count).map { NSNumber(value: CFTimeInterval($0) / CFTimeInterval(count)) }
        animation.values = (0 ... count).map {_ in
            //UIColor(hue: CGFloat($0) / CGFloat(count), saturation: 1, brightness: 1, alpha: 1).cgColor
            UIColor.black.cgColor//RGBCOLOR(36, g: 57, b: 54).cgColor
        }
        animation.duration = duration
        animation.calculationMode = CAAnimationCalculationMode.linear
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: animation.keyPath)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)
        
        return allowed
    }()
}
