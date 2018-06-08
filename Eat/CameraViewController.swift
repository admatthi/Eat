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
var newimage = UIImage()
var groups = [String]()
var foods = [String]()
var nutrients = [String:Double]()
var servingsizes = [String:Double]()

var servingoptions = [String]()
var newcalories = String()
var newprotein = String()
var newcarbs = String()
var newfats = String()
var newpotassium = String()
var newsodium = String()
var newcholesterol = String()
var newzinc = String()
var newfiber = String()
var newvitaminD = String()
var newseleneium = String()
var newiron = String()
var newvitamina = String()

var groupressed = Bool()
var foodpressed = Bool()
var servingspressed = Bool()

var selectedgroup = String()
var selectedfood = String()
var selectedservings = String()

var logoimagedata = Data()

var results : All?

var logodownloadURL = String()

class CameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, AVCapturePhotoCaptureDelegate {

var croppedimage = UIImage()
    


    @IBOutlet weak var overlayCamera: UIView!
    @IBOutlet weak var capturedImage: UIImageView!

    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    



    
    @IBAction func tapPhoto(_ sender: Any) {
        
        groups.removeAll()
        foods.removeAll()
        captureScreenshot()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.global(qos: .background).async {
            if !(self.captureSession?.isRunning)! {
                self.captureSession?.startRunning()
            }
        }
        
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
    
    @IBOutlet weak var outline: UIImageView!
    
    @IBOutlet weak var tapback: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        if newuser == true {
            
            tapback.alpha = 0
            uid = "4GE57CaA21R6EOSRGKeCkRd9DXq1"
            
        } else {
            
            tapback.alpha = 1
        }
        defaultnutrientvalues()
        ref = Database.database().reference()

        captureSession = AVCaptureSession()
        

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        previewLayer?.frame = view.layer.bounds;
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        //
        overlayCamera.layer.addSublayer(previewLayer!)
        
        captureSession?.startRunning()
        setupScreenshot()
        let videoCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        // Create input object.
        let videoInput: AVCaptureDeviceInput?
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice!)
        } catch {
            return
        }
        
        // Add input to the session.
        if (captureSession?.canAddInput(videoInput!))! {
            captureSession?.addInput(videoInput!)
        } else {
            
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        // Add output to the session.
        if (captureSession?.canAddOutput(metadataOutput))! {
            captureSession?.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: .global(qos: .background))
            
            if Set([.qr, .ean13]).isSubset(of: metadataOutput.availableMetadataObjectTypes) {
                metadataOutput.metadataObjectTypes = [.qr, .ean13]
                
            } else {
                
            }
            
            
        }
    }
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var taptake: UIButton!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        DispatchQueue.global(qos: .background).async {
            if (self.captureSession?.isRunning)! {
                self.captureSession?.stopRunning()
            }
        }
    }
    
    func captureScreenshot() {
        
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [
            kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
            kCVPixelBufferWidthKey as String: 160,
            kCVPixelBufferHeightKey as String: 160
        ]
        settings.previewPhotoFormat = previewFormat
        cameraOutput.capturePhoto(with: settings, delegate: self as! AVCapturePhotoCaptureDelegate)
        
        
    }
    var cameraOutput : AVCapturePhotoOutput!

    func setupScreenshot() {
        
        cameraOutput = AVCapturePhotoOutput()
        
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        
        if let input = try? AVCaptureDeviceInput(device: device!) {
            if (captureSession?.canAddInput(input))! {
                captureSession?.addInput(input)
                if (captureSession?.canAddOutput(cameraOutput))! {
                    captureSession?.addOutput(cameraOutput)
                }
            } else {
                print("issue here : captureSesssion.canAddInput")
            }
        } else {
            print("some problem here")
        }
    }
    
    func photoOutput(_ captureOutput: AVCapturePhotoOutput,  didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,  previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings:  AVCaptureResolvedPhotoSettings, bracketSettings:   AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            print("error occure : \(error.localizedDescription)")
        }
        
        if  let sampleBuffer = photoSampleBuffer,
            let previewBuffer = previewPhotoSampleBuffer,
            let dataImage =  AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer:  sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            print(UIImage(data: dataImage)?.size as Any)
            
            let dataProvider = CGDataProvider(data: dataImage as CFData)
            let cgImageRef: CGImage! = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
            let image = UIImage(cgImage: cgImageRef, scale: 1.0, orientation: UIImageOrientation.right)
            
            self.capturedImage.image = image
            self.capturedImage.alpha = 1
            
            newimage = image
            
            self.captureSession?.stopRunning()
            
            croppedimage = cropToBounds(image: capturedImage.image!, width: 544, height: 544)
            
            croppedimage = resizeImage(image: croppedimage, targetSize: CGSize(width:544.0, height:544.0))
            
            if self.capturedImage.image != nil {
                
                logoimagedata = UIImageJPEGRepresentation(croppedimage, 0.2)!
                
                self.sendPhoto() { () -> () in
                    
                    DispatchQueue.main.async {

                        self.performSegue(withIdentifier: "PreToPost", sender: self)

                        }
                        
                    }
 

                
                //            self.performSegue(withIdentifier: "PhotoToSwiping", sender: self)
                
            }
        } else {
            print("some error here")
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
    
    
    func sendPhoto (completed: @escaping (() -> ()) )  {
    
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
                
                do {
                    var counter = 0

                    var functioncounter = 0
                    
                    var thirdcounter = 0
                    
                    results = try JSONDecoder().decode(All.self, from: data!)
                    
                    for group in (results?.results)! {
                        
                        if thirdcounter < 10 {
                            

                        groups.append(group.group!)

                        print(groups)
                            
                        thirdcounter += 1
                        
                        for item in group.items {

                            foods.append(item.name!)
                            
                            var thisfood = foods[0]
                            
                                for serving in item.servingSizes {
                                    if counter == 0 {

                                    unitofmeasure = serving.unit!
                                    
                                        unitofmeasure = unitofmeasure.components(separatedBy: " ").dropFirst().joined(separator: " ")
                                        
                                    var thisisit = serving.servingWeight
                                        
                                        if thisisit != nil {
                                            nutrients = item.nutrition
                                        
                                        if nutrients["totalCarbs"] != nil {
                                            
                                        var intcarbs = nutrients["totalCarbs"]! * thisisit!
                                            newcarbs = String(format: "%.1f", intcarbs * 1000)

                                        }
                                        if nutrients["protein"] != nil {

                                            var intprotein = nutrients["protein"]! * thisisit!
                                            newprotein = String(format: "%.1f", intprotein * 1000)

                                        }
                                        
                                        if nutrients["calories"] != nil {
                                         
                                            var intcalories = nutrients["calories"]! * thisisit!
                                            newcalories = String(format: "%.1f", intcalories)

                                        }
                                            
                                            if nutrients["totalFat"] != nil {
                                                
                                                var intfat = nutrients["totalFat"]! * thisisit!
                                                newfats = String(format: "%.1f", intfat)
                                                
                                            }

                                        } else {
                                            
                                            nutrients = item.nutrition
                                            
                                            if nutrients["totalCarbs"] != nil {
                                                
                                                var intcarbs = nutrients["totalCarbs"]!
                                                newcarbs = String(format: "%.1f", intcarbs * 1000)
                                                
                                            }
                                            if nutrients["protein"] != nil {
                                                
                                                var intprotein = nutrients["protein"]!
                                                newprotein = String(format: "%.1f", intprotein * 1000)
                                                
                                            }
                                            
                                            if nutrients["calories"] != nil {
                                                
                                                var intcalories = nutrients["calories"]!
                                                newcalories = String(format: "%.1f", intcalories)
                                                
                                            }
                                            
                                            if nutrients["totalFat"] != nil {
                                                
                                                var intfat = nutrients["totalFat"]!
                                                newfats = String(format: "%.1f", intfat)
                                                
                                            }
                                            
                                        }
                                    
                                    completed()


                                        
                                    counter += 1
                                        
                                    }
  

                            }
                            
                            
                            
                            
                        }
                            
                        }
                    }
                    
                    
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//
//                    print(json)
                    
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
 
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection)
    {
        // This is the delegate'smethod that is called when a code is readed
        for metadata in metadataObjects {
            let readableObject = metadata as! AVMetadataMachineReadableCodeObject
            let code = readableObject.stringValue
            
            
//            self.delegate?.barcodeReaded(barcode: code!)
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            captureScreenshot()
            
            
            print(code!)
            
            
        }
    }
//    var delegate: BarcodeDelegate?

    func barcodeDetected(code: String) {
        
        // Let the user know we've found something.
        let alert = UIAlertController(title: "Found a Barcode!", message: code, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Search", style: UIAlertActionStyle.destructive, handler: { action in
            
            // Remove the spaces.
            let trimmedCode = code.trimmingCharacters(in: NSCharacterSet.whitespaces)
            
            // EAN or UPC?
            // Check for added "0" at beginning of code.
            
            let trimmedCodeString = "\(trimmedCode)"
            var trimmedCodeNoZero: String
            
            if trimmedCodeString.hasPrefix("0") && trimmedCodeString.characters.count > 1 {
                trimmedCodeNoZero = String(trimmedCodeString.characters.dropFirst())
                
                // Send the doctored UPC to DataService.searchAPI()
                DataService.searchAPI(codeNumber: trimmedCodeNoZero)
                
            } else {
                
                // Send the doctored EAN to DataService.searchAPI()
                DataService.searchAPI(codeNumber: trimmedCodeString)
            }
            
        }))
        
    }
    
    func defaultnutrientvalues() {
        
        newcalories = "0"
        newprotein = "0"
        newcarbs = "0"
        newfats = "0"
        newpotassium = "0"
        newsodium = "0"
        newcholesterol = "0"
        newzinc = "0"
        newfiber = "0"
        newvitaminD = "0"
        newseleneium = "0"
        newiron = "0"
        newvitamina = "0"
    }
    
}


struct All: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let packagedgoods: Bool?
    let group: String?
    let items: [Item]
    

}

struct Item: Decodable {
    let nutrition: [String: Double]
    var name: String?
    let score: Int?
    let brand: String?
    let servingSizes: [ServingSize]
    let generic: Bool?
}

struct ServingSize: Decodable {
    let unit: String?
    let servingWeight: Double?
    

}


extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}



