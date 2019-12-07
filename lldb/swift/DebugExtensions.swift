extension UIViewController {
    func overlayClassNames() {
        var overlayHandler: ((UIView) -> Void)?
        overlayHandler = { view in
            let color = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
            view.layer.borderWidth = 2
            view.layer.borderColor = color.cgColor
            
            let label = UILabel(frame: .zero)
            label.text = String(describing: type(of: view))
            label.textColor = color
            label.sizeToFit()
            
            view.subviews.forEach { overlayHandler?($0) }
            
            view.addSubview(label)
        }
        
        overlayHandler?(view)
    }
}