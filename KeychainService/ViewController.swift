//
//  ViewController.swift
//  KeychainService
//
//  Created by Thaliees on 1/20/20.
//  Copyright © 2020 Thaliees. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var textFieldValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    /*
    /// Option 1
    @IBAction func addAction(_ sender: UIButton) {
        let value = textFieldValue.text!
        if value != "" { setValue(value: value) }
    }
    
    @IBAction func getAction(_ sender: UIButton) {
        labelValue.text = "Value: \(getValue())"
    }
    
    @IBAction func removeAction(_ sender: UIButton) {
        removeValue()
    }
    
    // MARK: - Keychain
    func setValue(value: String) {
        let generic = GenericQueryable()
        let secureStore = SecureStore(secureStoreQueryable: generic)
        
        do {
            try secureStore.setValue(value, for: "Example")
            textFieldValue.text = ""
        } catch (let e){
            print(e.localizedDescription)
        }
    }
    
    func getValue() -> String {
        let generic = GenericQueryable()
        let secureStore = SecureStore(secureStoreQueryable: generic)
        
        do {
            let token = try secureStore.getValue(for: "Example")
            if token == nil { return "" }
            return token!
        } catch (let e) {
            print(e.localizedDescription)
            return ""
        }
    }
    
    func removeValue() {
        let generic = GenericQueryable()
        let secureStore = SecureStore(secureStoreQueryable: generic)
        
        do {
            try secureStore.removeAllValues()
            labelValue.text = "Value: "
        } catch (let e){
            print(e.localizedDescription)
        }
    }
    */
    
    /// Option 2
    @IBAction func addAction(_ sender: UIButton) {
        let value = textFieldValue.text!
        if value != "" {
            //Indicates the name key
            let key = "KEYCHAIN_SERVICE_EXAMPLE"
            setValue(service: "MyService", key: key, value: value)
        }
    }
    
    @IBAction func getAction(_ sender: UIButton) {
        //Indicates the name key
        let key = "KEYCHAIN_SERVICE_EXAMPLE"
        labelValue.text = "Value: \(getValue(service: "MyService", key: key))"
    }
    
    @IBAction func removeAction(_ sender: UIButton) {
        //Indicates the name key
        let key = "KEYCHAIN_SERVICE_EXAMPLE"
        removeValue(service: "MyService", key: key)
    }
    
    @IBAction func removeAllAction(_ sender: UIButton) {
        removeAllValues(service: "MyService")
    }
    
    // MARK: - Keychain
    func setValue(service: String, key: String, value: String) {
        let generic = GenericQueryable(service: service)
        let secureStore = SecureStore(secureStoreQueryable: generic)
        
        do {
            try secureStore.setValue(value, for: key)
            textFieldValue.text = ""
        } catch (let e){
            print(e.localizedDescription)
        }
    }
    
    func getValue(service: String, key: String) -> String {
        let generic = GenericQueryable(service: service)
        let secureStore = SecureStore(secureStoreQueryable: generic)
        
        do {
            let result = try secureStore.getValue(for: key)
            let text = result == nil ? "" : result!
            return text
        } catch (let e) {
            print(e.localizedDescription)
            return ""
        }
    }
    
    func removeAllValues(service: String) {
        let generic = GenericQueryable(service: service)
        let secureStore = SecureStore(secureStoreQueryable: generic)
        
        do {
            try secureStore.removeAllValues()
            labelValue.text = "Value: "
        } catch (let e){
            print(e.localizedDescription)
        }
    }
    
    func removeValue(service: String, key: String) {
        let generic = GenericQueryable(service: service)
        let secureStore = SecureStore(secureStoreQueryable: generic)
        
        do {
            try secureStore.removeValue(for: key)
            labelValue.text = "Value: "
        } catch (let e){
            print(e.localizedDescription)
        }
    }
}

