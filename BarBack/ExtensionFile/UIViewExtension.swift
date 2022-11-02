import Foundation
import UIKit


//private var __maxLengths = [UITextField: Int]()
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
}

@IBDesignable
extension UIView {
    // Shadow
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    fileprivate func addShadow(shadowColor: CGColor =
                               UIColor.black.cgColor,shadowOffset: CGSize = CGSize(width: 3.0, height: 3.0),
                               shadowOpacity: Float = 0.2,
                               shadowRadius: CGFloat = 5.0) {
        let layer = self.layer
        layer.masksToBounds = false
        
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
        
        let backgroundColor = self.backgroundColor?.cgColor
        self.backgroundColor = nil
        layer.backgroundColor =  backgroundColor
    }
    
    // Corner radius
    @IBInspectable var circle: Bool {
        get {
            return layer.cornerRadius == self.bounds.width*0.5
        }
        set {
            if newValue == true {
                self.cornerRadius = self.bounds.width*0.5
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
    @IBInspectable
    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    // Border color
    @IBInspectable
    public var borderColor: UIColor? {
        get {
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func gradiantView(headerView:UIView) -> Void {
        
    }
}
class ShadowView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // corner radius
        self.layer.cornerRadius = 10
        
        // border
        self.layer.borderWidth = 1.0
        self.layer.borderColor = #colorLiteral(red: 0.7743244767, green: 0.7743428349, blue: 0.7743329406, alpha: 1)
        
        // shadow
        self.layer.shadowColor = #colorLiteral(red: 0.7743244767, green: 0.7743428349, blue: 0.7743329406, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
    }
    
}

@IBDesignable
class DesignableUITextField: UITextField {
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x += rightPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateViewLeft()
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateViewRight()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateViewLeft()
        }
    }
    
    @IBInspectable var color2: UIColor = UIColor.lightGray {
        didSet {
            updateViewRight()
        }
    }
    
    func updateViewLeft() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    func updateViewRight() {
        if let image = leftImage {
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color2
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
}

@IBDesignable
class CustomPageControl: UIPageControl {

@IBInspectable var currentPageImage: UIImage?

@IBInspectable var otherPagesImage: UIImage?

override var numberOfPages: Int {
    didSet {
        updateDots()
    }
}

override var currentPage: Int {
    didSet {
        updateDots()
    }
}

override func awakeFromNib() {
    super.awakeFromNib()
    if #available(iOS 14.0, *) {
        defaultConfigurationForiOS14AndAbove()
    } else {
        pageIndicatorTintColor = .clear
        currentPageIndicatorTintColor = .clear
        clipsToBounds = false
    }
}

private func defaultConfigurationForiOS14AndAbove() {
    if #available(iOS 14.0, *) {
        for index in 0..<numberOfPages {
            let image = index == currentPage ? currentPageImage : otherPagesImage
            setIndicatorImage(image, forPage: index)
        }

        // give the same color as "otherPagesImage" color.
        pageIndicatorTintColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        
        // give the same color as "currentPageImage" color.
        currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.642288506, blue: 0.7297670245, alpha: 1)
        /*
         Note: If Tint color set to default, Indicator image is not showing. So, give the same tint color based on your Custome Image.
        */
    }
}

private func updateDots() {
    if #available(iOS 14.0, *) {
        defaultConfigurationForiOS14AndAbove()
    } else {
        for (index, subview) in subviews.enumerated() {
            let imageView: UIImageView
            if let existingImageview = getImageView(forSubview: subview) {
                imageView = existingImageview
            } else {
                imageView = UIImageView(image: otherPagesImage)
                
                imageView.center = subview.center
                subview.addSubview(imageView)
                subview.clipsToBounds = false
            }
            imageView.image = currentPage == index ? currentPageImage : otherPagesImage
        }
    }
}

private func getImageView(forSubview view: UIView) -> UIImageView? {
    if let imageView = view as? UIImageView {
        return imageView
    } else {
        let view = view.subviews.first { (view) -> Bool in
            return view is UIImageView
        } as? UIImageView

        return view
    }
}
}

@IBDesignable
open class SPTextField: UITextField {
    
    private let borderThickness: (active: CGFloat, inactive: CGFloat) = (active: 1, inactive: 1)
    private let inactiveBorderLayer = CALayer()
    private let activeBorderLayer = CALayer()
    
    @IBInspectable
    var leftImage : UIImage? {
        didSet {
            updateView()
        }
    }
    @IBInspectable
    var rigthPadding : CGFloat = 0 {
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var borderInactiveColor : UIColor = .clear{
        didSet{
            updateBorder()
        }
    }
    @IBInspectable
    var borderActiveColor : UIColor = .clear{
        didSet{
            updateBorder()
        }
    }
    
    @IBInspectable
    var alertImage : UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var ImageSize : CGFloat = 30 {
        didSet{
            updateView()
        }
    }
    override open func willMove(toSuperview newSuperview: UIView!) {
        if newSuperview != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidBeginEditing), name: UITextField.textDidBeginEditingNotification, object: self)
            
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidEndEditing), name: UITextField.textDidEndEditingNotification, object: self)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }

    
    @objc open func textFieldDidBeginEditing() {
        activeBorderLayer.frame = actionForBorder(borderThickness.active, isFilled: true)
        rightViewMode = .never
    }
    @objc open func textFieldDidEndEditing() {
        activeBorderLayer.frame = actionForBorder(borderThickness.active, isFilled: false)
        rightViewMode = .never
    }

    private func actionForBorder(_ thickness: CGFloat, isFilled: Bool) -> CGRect {
        if isFilled {
            return CGRect(origin: CGPoint(x: ImageSize, y: frame.height-thickness), size: CGSize(width: frame.width, height: thickness))
        } else {
            return CGRect(origin: CGPoint(x: ImageSize, y: frame.height-thickness), size: CGSize(width: 0, height: thickness))
        }
    }

    private func updateBorder() {
        inactiveBorderLayer.frame = actionForBorder(borderThickness.inactive, isFilled: true)
        inactiveBorderLayer.backgroundColor = borderInactiveColor.cgColor
        
        activeBorderLayer.frame = actionForBorder(borderThickness.active, isFilled: false)
        activeBorderLayer.backgroundColor = borderActiveColor.cgColor
        
        layer.addSublayer(inactiveBorderLayer)
        layer.addSublayer(activeBorderLayer)
    }
    
    private func updateView() {
        if let icon = leftImage{
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ImageSize, height: ImageSize))
            
            var width = ImageSize + rigthPadding
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                    width = width + 5
            }
            imageView.image = icon
            imageView.tintColor = tintColor
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
            view.addSubview(imageView)
            leftView = view
        }else{

            leftViewMode = .never
        }

        if let alertIcon = alertImage {
            rightViewMode = .never
            let alertImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ImageSize, height: ImageSize))
            let alertView = UIView(frame:  CGRect(x: 0, y: 0, width: ImageSize+5, height: ImageSize))
            alertImageView.image = alertIcon
            alertImageView.tintColor = tintColor
            alertView.addSubview(alertImageView)
            rightView = alertView
        }else{
            rightViewMode = .never
        }
    }
    
    public func invalidFieldAlert() {
        rightViewMode = .unlessEditing
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint : CGPoint.init(x: self.center.x - 5.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint : CGPoint.init(x: self.center.x + 5.0, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
}

//public extension UIApplication {
//    func currentUIWindow() -> UIWindow? {
//        let connectedScenes = UIApplication.shared.connectedScenes
//            .filter { $0.activationState == .foregroundActive }
//            .compactMap { $0 as? UIWindowScene }
//        
//        let window = connectedScenes.first?
//            .windows
//            .first { $0.isKeyWindow }
//
//        return window
//        
//    }
//}

protocol ScrollViewKeyboardDelegate: AnyObject {
    var scrollView: UIScrollView? { get set }

    func registerKeyboardNotifications()
    func unregisterKeyboardNotifications()
}

extension ScrollViewKeyboardDelegate where Self: UIViewController {
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil,
            queue: nil) { [weak self] notification in
                self?.keyboardWillBeShown(notification)
        }

        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil) { [weak self] notification in
                self?.keyboardWillBeHidden(notification)
        }
    }

    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    func keyboardWillBeShown(_ notification: Notification) {
        let info = notification.userInfo
        let key = (info?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)
        let aKeyboardSize = key?.cgRectValue

        guard let keyboardSize = aKeyboardSize,
            let scrollView = self.scrollView else {
                return
        }

        let bottomInset = keyboardSize.height
        scrollView.contentInset.bottom = bottomInset
        scrollView.horizontalScrollIndicatorInsets.bottom = bottomInset
        if let activeField = self.view.firstResponder {
            let yPosition = activeField.frame.origin.y - bottomInset
            if yPosition > 0 {
                let scrollPoint = CGPoint(x: 0, y: yPosition)
                scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }

    func keyboardWillBeHidden(_ notification: Notification) {
        self.scrollView?.contentInset = .zero
        self.scrollView?.horizontalScrollIndicatorInsets = .zero
    }
}

extension UIView {
    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }
        return subviews.first(where: {$0.firstResponder != nil })
    }
}
