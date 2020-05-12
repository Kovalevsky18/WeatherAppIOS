import Foundation
struct List: Codable {
    var dt : Int?
    var dt_txt : String?
    var main : MainDay?
    var weather : [WeatherDay]?
}
