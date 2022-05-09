//
//  AuthManager.swift
//  Valentino
//
//  Created by Liu John on 2022-03-14.
//
import FirebaseAuth

public class AuthManager{
    static let shared = AuthManager()
    // MARK: - Public
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        DatabaseManager.shared.canCreateNewUser(with:email, username: username) { canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else{
                        // Firebase auth could not create account
                        completion(false)
                        return
                    }
                    
                    // Insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            Auth.auth().currentUser?.sendEmailVerification { error in
                              // ...
                                if (error == nil) {
                                    completion(true)
                                }
                            }
                            
                            
                            return
                        } else {
                            // Failed to insert into database
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                completion(false)
            }
            
            
        }
    }
    
    public func loginUser(email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email{
            //email log in
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                guard result != nil, error == nil else{
                    completion(false)
                    return
                }
                completion(true)
                
            }
        }
        
    }
    
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            print(error)
            completion(false)
            return
        }
        
    }
    
    
}
