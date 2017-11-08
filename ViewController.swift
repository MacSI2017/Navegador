//
//  ViewController.swift
//  Navegador
//
//  Created by Sero de RAM on 27/10/17.
//  Copyright © 2017 Sero de RAM. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class ViewController: UIViewController , UIWebViewDelegate{
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var ir: UIButton!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var atras: UIButton!
    @IBOutlet weak var palante: UIButton!
    
    
    var ref:DatabaseReference?
    
    var handle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        ref=Database.database().reference()
        tf.text="http://www.google.es"
        buscar2()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buscar(_ sender: Any) {
        buscar2()
    }
    
    func buscar2(){
        if tf.text != "" {
            if (tf.text?.characters.count)! > 7 {
                let index1 = tf.text?.index((tf.text?.startIndex)!, offsetBy: 7)
                
                let substring1 = tf.text?.substring(to: index1!)
                if substring1?.uppercased() != "HTTP://" {
                    tf.text="http://"+tf.text!
                }
            }
            else {
                tf.text="http://"+tf.text!
            }
        }
        webView.loadRequest(URLRequest(url: URL(string: tf.text!)!))
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if let text = webView.request?.url?.absoluteString{
            tf.text=text
            ref?.child("url").childByAutoId().setValue(text)
        }
    }
    
    @IBAction func actiontfEnter(_ sender: UITextField) {
        buscar2()
    }
    @IBAction func actionAtras(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func actionPalante(_ sender: Any) {
        webView.goForward()
    }
    
    
    
    
}
