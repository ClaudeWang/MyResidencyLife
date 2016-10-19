//
//  LoginViewController.swift
//  SurveyApp
//
//  Created by Ziyun Wang on 8/29/16.
//  Copyright © 2016 Ziyun Wang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBAction func loginCheck(sender: AnyObject) {
        if (hashCheck(emailTextField.text!)){
            //perform segue and store the hash to local.
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(md5(string: emailTextField.text!), forKey: "ID")
            defaults.synchronize()
            self.performSegueWithIdentifier("loginToInfo", sender: self)
        }
        else {
            //alert to ask for re-input.
            let alert = UIAlertController(title: "Authentification Failed", message: "Please enter an valid Baylor email address.", preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "Go back and change it", style: .Default, handler: nil)
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    let hashValues: Set<String> = [
        "792800e9302abcac6c973191b5b26491",
        "41d72f22bda9a637cec863ef26d576c3",
        "5ece0f2b58c8f7c5b4c7b3cdef8734c7",
        "2907e62b44be2fbd5484c7bfb048ab54",
        "51db3da34c7f9b0a16a0a0d66d0c0831",
        "bce1763588ac56f4773bef5cc2f9e967",
        "39eb08345ecb7721cbe67e43201bccf2",
        "a8c8b9f59917e550ffa0480e99774d45",
        "89caaf905928c598331cfa710b7ebc9c",
        "3ecb7ebe02c3466a1700c33c80c3417b",
        "1594999d2d12f00516ea293d3484a975",
        "7a0428f026a794adda0853b7802c5ddc",
        "27b770c0af607ee961a30863887903a3",
        "733ad73486d441b137ad8c638f983bf8",
        "2a5362cd6576de02a069cacf719e4e68",
        "40c1b2edc72395650047c583570f93ad",
        "ee3fcd19d15738eaccb5b9d9f3bcb7e3",
        "9a4fd3b7ccf7c83a405ecd54c855b73e",
        "ca8f6d257a8555700c77b52cacd8c7c1",
        "82d03505df872db086865d429f4b5cd2",
        "579ea59a5e151a72a83960795deecf12",
        "c7b40d2139c990847557ab94a416dfd8",
        "38865a00ca10d58a85fb0d770c2fb769",
        "5741dae7829f636fef07291d277197a6",
        "3eb5e99f998b807ad6904f9ddf9445c7",
        "9debee731ccfd995a8690088eabd1087",
        "faf5806b8052ecfca72d2468de6d8267",
        "4451cf24f90933e3d6127909727d5b60",
        "5c13ffc80278c750e82cceabd2612882",
        "1d2d98224d0ebf436150178ac3b9b3bd",
        "a21945e30fa3cfb5b0d96f7c8f6912e4",
        "8ab1f587478bb0a5f7a7422af9d3c566",
        "3c9edb6dd152ee3da76103d13b9d9064",
        "e5652c093bc85845ad63798e7c2aef24",
        "f011f295ba6698fead40bc0ae89b96ec",
        "7e8d0d9e7d70d7a4fb27eb5bd4db2c54",
        "0c2eb81d738c54d38754daf7afe04e18",
        "8158c8b0d3d7f97b329bb4e31fd80035",
        "5347fb704a67e1841640f00b4a8dba08",
        "9e1b7b2147b1766d14c7b3d1e2966c50",
        "837d1e5fbf075ed64191fff09545ccb1",
        "03d29d592505089b5ecb2285efa7448c",
        "2bad91abb75efcb6bc18c3462b2083fd",
        "e812b05f8c4486b0302ae7bb8c4654f1",
        "34e3051f884b062363264a904c72c846",
        "32ee0c1ba025b64adf23a28a5fe05432",
        "080e00ff6c09775f7fc2e4fac916b49a",
        "ec2210531e734ad5a1b004aeb05acaee",
        "c2e53a0134b591d3e5f569fe03cc71b2",
        "266641b23ed662c5e8fe1aede7d88f4f",
        "3308519a88c1d41d7b4fbb9a3df82df9",
        "83edb0e3b86287a6a0722cd8d3386a97",
        "cb3d745acc3a6ffe05354a0d26219411",
        "f65ff77cf16432a4d7d58950bbcc9f80",
        "22e2a0c41846b0f259f51dfd9f0e0966",
        "7e075100f1aad86b4f363d03e7e9bbb2",
        "266275a73be971879e356e991a306fb3",
        "56dcd2fbe3c73b0c662371982ba8e7a4",
        "e0c59edf11bf186176d0d4647ced4e15",
        "85befd9c4ec32fcc1b9fb0984bd9c274",
        "f70181bcaabadf2c23cbaf0ec185afef",
        "ba970cb15e0d71854f907b37f324a386",
        "150aeea909fb258d72bb9283955995db",
        "a4f50b931f10f79bec56c82ea4274e1a",
        "307c6536981f4ac978788447ea58499a",
        "5199aa24cfa04cb5a0cbc9b8516f7f39",
        "62acd1320da5e42dd054e0849e48b8ad",
        "d4e780504b8eeb2a6af822a7cd818d26",
        "702e70cd9414674b1c4ef5778bc058a4",
        "3a178d48f67e889b17b7f388b0be4edf",
        "e77a2b47176344cd24267cabd64097ae",
        "d8440c43b77d6fbcc306db0d5e223186",
        "5ff60c560e92255d8969a0f6b69612f5",
        "b1392bce7836cc4a130599ad1ef637e5",
        "55449acbd850ac174aa5e80cbd64c30b",
        "556932d75a4d049b8823b34bdf55c69a",
        "bbda11319c65458c2aed03557f0048cc",
        "8ef86b3f4a19df8f1011e7c6298a83ea",
        "67d825d2090cdd3a2c84048b2f6d65c9",
        "38d8540a5acde3690d650ce61ee250bf",
        "d70ac9831d11db06f2cb8f82026a825b",
        "96ed05755908664c6ac4cbe580793683",
        "7d10a037100f03a7beb6a1c9a53d7dae",
        "6f978bd90181ba7a41b01141c68699c2",
        "eef01b821e1156e38d8500c8bf1376f4",
        "32aef690b737a07a7617452b99c53a39",
        "38fdbf3d184ebd65eb63ff45c6446e3a",
        "9a19b81bd7527f80aada1d45f6fe226c",
        "f7450c08a305408652aea7c29e4cacc3",
        "f00c4673b20fa6c3210909fb3c93e6f0",
        "ee64144ffa686fe06fbfc7b1a8107e70",
        "d37697431cbb409a4e43cd7e876cd5f0",
        "f8fecf59ebb777b626836314c6ad4fa6",
        "46f0ae0bbc0c58894506c2190b931688",
        "9c2f5ab916ee3f6094b144b6fa695942",
        "2444174a9ebffb1e6b6dbcfaee508448",
        "25b9cbdc70a8ecea033b57dbbd34f6b6"
    ]
    
    override func viewDidAppear(animated: Bool) {
        //add keyboard dismiss
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        //check if already logged in.
        let defaults = NSUserDefaults.standardUserDefaults()
        let id = defaults.stringForKey("ID")
        if (id != nil) {
            //self.performSegueWithIdentifier("loginToInfo", sender: self)
            self.performSegueWithIdentifier("loginToStart", sender: self)
        }
    }
    func hashCheck(text:String)->Bool {
        let emailHashed = md5(string: emailTextField.text!)
        if (hashValues.contains(emailHashed)){
            return true
        }
        return false
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func md5(string string: String) -> String {
        var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
            CC_MD5(data.bytes, CC_LONG(data.length), &digest)
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }
}
