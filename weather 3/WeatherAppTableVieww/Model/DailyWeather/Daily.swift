import Foundation
struct Daily:Codable {
    var dt:Int?
    var temp:Temp?
    var weather:[Weather]?
}
