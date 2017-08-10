//======================================================
import UIKit
import WatchConnectivity
//======================================================
class ViewController: UIViewController, WCSessionDelegate {
    //--------------------------------------------------
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var replyLabel: UITextView!
    //-----------
    var session: WCSession!
    //-----------
    var conversation: String = ""
    //--------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        //-----------
        if WCSession.isSupported() {
            session = WCSession.default()
            session.delegate = self
            session.activate()
        }
        //-----------
    }
    //--------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //--------------------------------------------------
    @available(iOS 9.3, *)
    public func sessionDidDeactivate(_ session: WCSession) {
        //..
    }
    //--------------------------------------------------
    @available(iOS 9.3, *)
    public func sessionDidBecomeInactive(_ session: WCSession) {
        //..
    }
    //--------------------------------------------------
    @available(iOS 9.3, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //..
    }
    //--------------------------------------------------
    @IBAction func sendToWatch(_ sender: AnyObject) {
        sendMessage()
    }
    //--------------------------------------------------
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        //-----------
        // Message envoyé par la montre
        let value = message["Message"] as? String
        //-----------
        DispatchQueue.main.async { () -> Void in
            // Affichage sur téléphone
            self.replyLabel.text = value
        }
        //-----------
        // Message automatique envoyé à la montre
        // replyHandler(["Message" : "Un message"])
        //-----------
    }
    //--------------------------------------------------
    func sendMessage(){
        //-----------
        // Message envoyé par le téléphone
        let messageToSend = ["Message" : "Phone : \(messageField.text!)\n\n"]
        //-----------
        session.sendMessage(messageToSend, replyHandler: { (replyMessage) in
            //-----------
            // Message automatique de la montre
            let value = replyMessage["Message"] as? String
            //-----------
            DispatchQueue.main.async(execute: { () -> Void in
                // Affichage sur téléphone
                self.replyLabel.text = value
                self.messageField.text = ""
            })
            //-----------
        }) { (error) in
            print("error: \(error.localizedDescription)")
        }
        //-----------
    }
    //--------------------------------------------------
}
//======================================================














