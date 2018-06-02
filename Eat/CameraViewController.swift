//
//  CameraViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 6/1/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseStorage

var counter = Int()

class CameraViewController: UIViewController {

var croppedimage = UIImage()
    
    @IBOutlet weak var overlayCamera: UIView!
    @IBOutlet weak var capturedImage: UIImageView!
    @IBOutlet weak var tapsubmit: UIButton!
    @IBOutlet weak var tapx: UIButton!
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    
    @IBAction func tapX(_ sender: Any) {
        
        prephoto()
        
        capturedImage.alpha = 0
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSession.Preset.photo
        
        captureSession?.startRunning()
        
    }
    var logoimagedata = Data()

    @IBAction func tapSubmit(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let currentUser = Auth.auth().currentUser
        
        croppedimage = cropToBounds(image: capturedImage.image!, width: 544, height: 544)

        croppedimage = resizeImage(image: croppedimage, targetSize: CGSize(width:544.0, height:544.0))
        
        if self.capturedImage.image != nil {

            logoimagedata = UIImageJPEGRepresentation(croppedimage, 0.2)!
            
            self.sendPhoto()

//            self.performSegue(withIdentifier: "PhotoToSwiping", sender: self)

        } else {

            print("No fucking photo")
        }

        let metaData = StorageMetadata()

        metaData.contentType = "image/jpg"

        counter += 1

        let filePath = "\(uid)\(counter)"

//        let filePath = "\(counter)"

        storageRef.child(filePath).putData(logoimagedata, metadata: metaData){(metaData,error) in

            if let error = error {

                print(error.localizedDescription)

                return

            } else {

                // store download url
                self.logodownloadURL = metaData!.downloadURL()!.absoluteString


                let currentUser = Auth.auth().currentUser

                var uid = String()

                uid = currentUser!.uid

                ref = Database.database().reference()

                ref?.child("Users").child(uid).updateChildValues(["Image": "\(self.logodownloadURL)"])

            }

        }

        
    }
    var logodownloadURL = String()
    
    @IBAction func tapPhoto(_ sender: Any) {
        
        cameraDidTaped()
        
        postphoto()
        
    
    }
    
    @IBAction func tapTurn(_ sender: Any) {
        
//        if let session = captureSession {
//            //Indicate that some changes will be made to the session
//            session.beginConfiguration()
//
//            //Remove existing input
//            guard let currentCameraInput: AVCaptureInput = session.inputs.first as? AVCaptureInput else {
//                return
//            }
//
//            session.removeInput(currentCameraInput)
//
//            //Get new input
//            var newCamera: AVCaptureDevice! = nil
//            if let input = currentCameraInput as? AVCaptureDeviceInput {
//                if (input.device.position == .front) {
//                    newCamera = cameraWithPosition(position: .back)
//                } else {
//                    newCamera = cameraWithPosition(position: .front)
//                }
//            }
//
//            //Add input to session
//            var err: NSError?
//            var newVideoInput: AVCaptureDeviceInput!
//            do {
//                newVideoInput = try AVCaptureDeviceInput(device: newCamera)
//            } catch let err1 as NSError {
//                err = err1
//                newVideoInput = nil
//            }
//
//            if newVideoInput == nil || err != nil {
//                print("Error creating capture device input: \(err?.localizedDescription)")
//            } else {
//                session.addInput(newVideoInput)
//            }
//
//            //Commit all the configuration changes at once
//            session.commitConfiguration()
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = overlayCamera.bounds
    }
    
    func postphoto() {
        
        tapx.alpha = 1
        tapsubmit.alpha = 1

    }
    
    func prephoto() {

        tapx.alpha = 0
        tapsubmit.alpha = 0

        
    }
    
    func cameraDidTaped() {
        
        let videoConnection = stillImageOutput?.connection(with: AVMediaType.video)
        
        videoConnection?.videoOrientation = AVCaptureVideoOrientation.portrait
        
        stillImageOutput?.captureStillImageAsynchronously(from: videoConnection!, completionHandler:
            
            {(sampleBuffer, error) in
                
                if (sampleBuffer != nil) {
                    
                    self.postphoto()
                    
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer!)
                    let dataProvider = CGDataProvider(data: imageData as! CFData)
                    let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
                    
                    
                    
                    let image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)
                    
                    
                    self.capturedImage.image = image
                    self.capturedImage.alpha = 1
                    
                    
                    
                }
        })
        
    }
    func turnforward() {
        
//        if let session = captureSession {
//            //Indicate that some changes will be made to the session
//            session.beginConfiguration()
//
//            //Remove existing input
//            guard let currentCameraInput: AVCaptureInput = session.inputs.first as? AVCaptureInput else {
//                return
//            }
//
//            session.removeInput(currentCameraInput)
//
//            //Get new input
//            var newCamera: AVCaptureDevice! = nil
//
//            newCamera = cameraWithPosition(position: .front)
//
//            //Add input to session
//            var err: NSError?
//            var newVideoInput: AVCaptureDeviceInput!
//            do {
//                newVideoInput = try AVCaptureDeviceInput(device: newCamera)
//            } catch let err1 as NSError {
//                err = err1
//                newVideoInput = nil
//            }
//
//            if newVideoInput == nil || err != nil {
//                print("Error creating capture device input: \(err?.localizedDescription)")
//            } else {
//                session.addInput(newVideoInput)
//            }
//
//            //Commit all the configuration changes at once
//            session.commitConfiguration()
//        }
        
    }
    
    func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        
//        if let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified) {
//            for device in discoverySession.devices {
//                if device.position == position {
//                    return device
//                }
//            }
//        }
//
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSession.Preset.photo
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera!)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if error == nil && (captureSession?.canAddInput(input))! {
            captureSession?.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            if (captureSession?.canAddOutput(stillImageOutput!))! {
                captureSession?.addOutput(stillImageOutput!)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                
                turnforward()
                
            overlayCamera.layer.addSublayer(previewLayer!)
                
                captureSession?.startRunning()
                
                
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: 0.17, orientation: image.imageOrientation)
        
        return image
    }
    
    func sendPhoto() {
    
    var myURL = NSURL(string: "https://api-2445582032290.production.gw.apicast.io/v1/foodrecognition?user_key=ffd81b65582979b97f4579046882c46c")
        let request = NSMutableURLRequest(url: myURL as! URL)
    
        request.httpMethod = "POST"
    
        var imageData = logoimagedata
        
        let boundary = generateBoundaryString()
        
        let param = [
        
            "firstName" : "Alek"
            
        ]
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData as NSData, boundary: boundary) as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            
            
            if error != nil {
                
            print("error=\(error)")
                
            } else {
                
                print("response=\(response)")
                
//                let dataAsString = String(data: data!, encoding: .utf8)
//
//                print(dataAsString)
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    
                    print(json)
                    
                } catch let jsonErr {
                    
                    print("Error", jsonErr)
                }
            }
            
        }
        
        task.resume()
            
 
 
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    

    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
}



struct Struct {
    
    var errorDetail: String
    var code: Int
    
    
}

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

