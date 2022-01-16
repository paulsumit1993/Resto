
import Foundation

extension URLSession {
    /// Loads an endpoint by creating (and directly resuming) a data task.
    ///
    /// - Parameters:
    ///   - endpoint: The endpoint.
    ///   - onComplete: The completion handler.
    /// - Returns: The data task.
    @discardableResult
    func load<A>(_ endpoint: Endpoint<A>, onComplete: @escaping (Result<A, Error>) -> ()) -> URLSessionDataTask {
        let request = endpoint.request
        let task = dataTask(with: request, completionHandler: { data, resp, err in
            if let err = err {
                onComplete(.failure(err))
                return
            }
            
            guard let response = resp as? HTTPURLResponse else {
                onComplete(.failure(UnknownError()))
                return
            }
            
            guard endpoint.expectedStatusCode(response.statusCode) else {
                onComplete(.failure(WrongStatusCodeError(statusCode: response.statusCode, response: response, responseBody: data)))
                return
            }
            
            onComplete(endpoint.parse(data, resp))
        })
        task.resume()
        return task
    }
}

