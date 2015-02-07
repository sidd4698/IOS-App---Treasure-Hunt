
import UIKit
import MobileCoreServices

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate {
    
//    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
//        println("i've got an image");
//    }
//    
//    @IBAction func capture(sender : UIButton) {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
//            println("Button capture")
//            
//            var imag = UIImagePickerController()
//            imag.delegate = self
//            imag.sourceType = UIImagePickerControllerSourceType.Camera;
//            imag.mediaTypes = [kUTTypeImage]
//            imag.allowsEditing = false
//            
//            self.presentViewController(imag, animated: true, completion: nil)
//        }
//    }
//    
    @IBOutlet var backgroundImage:UIImageView?
    
    var cameraUI:UIImagePickerController = UIImagePickerController()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }

    //pragma mark - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentCamera()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraShow()
    {
        self.presentCamera()
    }
    
    //pragma mark - Camera
    
    func presentCamera()
    {
        cameraUI = UIImagePickerController()
        cameraUI.delegate = self
        cameraUI.sourceType = UIImagePickerControllerSourceType.PhotoLibrary //camera
        cameraUI.mediaTypes = [kUTTypeImage]
        cameraUI.allowsEditing = false
        
        self.presentViewController(cameraUI, animated: true, completion: nil)
    }
    
    //pragma mark- Image
    
    func imagePickerControllerDidCancel(picker:UIImagePickerController)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker:UIImagePickerController!, didFinishPickingMediaWithInfo info:NSDictionary)
    {
//        var mediaType:NSString = info.objectForKey(UIImagePickerControllerEditedImage) as NSString
        var imageToSave:UIImage
        
        imageToSave = info.objectForKey(UIImagePickerControllerOriginalImage) as UIImage
        
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
        self.savedImage()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func savedImage()
    {
        var alert:UIAlertView = UIAlertView()
        alert.title = "Saved!"
        alert.message = "Your picture was saved to Camera Roll"
        alert.delegate = self
        alert.addButtonWithTitle("Awesome")
        alert.show()
    }
    
    func alertView(alertView: UIAlertView!, didDismissWithButtonIndex buttonIndex: Int)
    {
        NSLog("Did dismiss button: %d", buttonIndex)
        self.presentCamera()
    }
}
