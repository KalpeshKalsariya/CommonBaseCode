//
//  SocketManager.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation

class SocketManager {

    static let shared = SocketManager()
//    var socket: SocketIOClient!

//    let manager = SocketManager(socketURL: URL(string: AppConstant.SocketKeys.socketURL)!, config: [.log(true), .compress, /*.connectParams(["transport":"polling"])*/ .forcePolling(true), .secure(true), .forceWebsockets(true)])

    private init() {
//        socket = manager.defaultSocket
    }

    func connectSocket(completion: @escaping(Bool, String) -> () ) {
    
        /*socket.on(clientEvent: .connect) {[weak self] (data, ack) in
            self?.socket.removeAllHandlers()
            let socketID = "\((data[1] as! [String: Any])["sid"]!)"
            print("Socket URL: \(Constant.SocketKeys.socketURL)")
            print("socket connected")
            print("Socket ID : \(socketID)")
            completion(true, socketID)
        }
        
        socket.on(clientEvent: .error) { (data, ack) in
            print("%%%%%%%%%%%%%%%%%%%%")
            print("Socket URL: \(Constant.SocketKeys.socketURL)")
            print("Socket Error : \(data)")
            print("%%%%%%%%%%%%%%%%%%%%")
            completion(false, "")
        }
        
        socket.connect()*/
        
        completion(false, "")
    }

    func disconnectSocket() {
//        socket.removeAllHandlers()
//        socket.disconnect()
        print("socket Disconnected")
    }

    func checkConnection() -> Bool {
        /*if socket.manager?.status == .connected {
            return true
        }*/
        return false

    }

    func emit(emitterName: String,params: [String : Any]) {
//        SocketHelper.shared.socket.emit(emitterName, params)
    }
    
    func emit(emitterName: String,params: String) {
//        SocketHelper.shared.socket.emit(emitterName, params)
    }
    
    func off(listnerName: String) {
//        SocketHelper.shared.socket.off(listnerName)
    }
    
    func listen(listnerName: String,completion: @escaping (Any) -> Void) {
//        SocketHelper.shared.socket.on(listnerName) { (response, emitter) in
//            
//            completion(response)
//        }
        completion("")
    }
}
