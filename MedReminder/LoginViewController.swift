//
//  LoginViewController.swift
//  MedReminder
//
//  Created by Tanya Zhdanova on 04/02/2017.
//  Copyright © 2017 Tanya Zhdanova. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (FBSDKAccessToken.current() != nil){
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                if let error = error {
                    return
                }
            }
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "TabbarController"), animated: true)
        }
        else{
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email"]
            loginView.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {

        if ((error) != nil){
        }
        else if result.isCancelled {
        }
        else {
            if result.grantedPermissions.contains("email"){
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    
                    if error != nil {
                        
                        return
                    }
                    self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "TabbarController"), animated: true)
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    }
    
    func returnUserData(){
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil){
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let res = result as! Dictionary <String, Any>
                let userName : NSString = res["name"] as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = res["email"] as! NSString
                print("User Email is: \(userEmail)")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

