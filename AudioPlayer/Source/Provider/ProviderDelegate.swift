import Foundation

@objc protocol ProviderDelegate:AnyObject {
    func positionCallback(time:Float)
    func durationCallback(time:Float)
    func endOfStream()
    func foundError(message:String, code:Int)
}
