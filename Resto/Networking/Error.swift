
import Foundation

protocol Describable {
    var description: String { get }
}

/// Signals that an image couldn't be constructed from nil or bad data
struct ImageError: Error, Describable {
    init() { }
    
    var description: String {
        return "Image couldn't be constructed"
    }
}

/// Signals that a response's data was unexpectedly nil.
struct NoDataError: Error, Describable {
    init() { }
    
    var description: String {
        return "Couldn't get response data"
    }
}

/// An unknown error
struct UnknownError: Error, Describable {
    init() { }
    
    var description: String {
        return "An unknown error occured"
    }
}

/// Signals that a response's status code was wrong.
struct WrongStatusCodeError: Error, Describable {
    let statusCode: Int
    let response: HTTPURLResponse?
    let responseBody: Data?
    init(statusCode: Int, response: HTTPURLResponse?, responseBody: Data?) {
        self.statusCode = statusCode
        self.response = response
        self.responseBody = responseBody
    }
    
    var description: String {
        return "Couldn't get status OK"
    }
}

