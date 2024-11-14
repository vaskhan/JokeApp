import Foundation

class JokeService {
    func fetchJoke(completion: @escaping (Result<JokeModel, Error>) -> Void) {
        guard let url = URL(string: "https://official-joke-api.appspot.com/jokes/random") else { return }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let joke = try JSONDecoder().decode(JokeModel.self, from: data)
                completion(.success(joke))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }.resume()
    }
}
