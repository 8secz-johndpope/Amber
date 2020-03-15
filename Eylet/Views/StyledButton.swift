
import UIKit

class StyledButton: UIButton {
    static let fontSize: CGFloat = 15
    static let font: UIFont = UIFont.systemFont(ofSize: StyledButton.fontSize, weight: .semibold)
    
    struct Metrics {
        let height: CGFloat
        let padding: CGFloat
    }
    
    enum Size {
        case normal
        case medium
        case small
        
        var metrics: Metrics {
            switch self {
            case .normal:
                return Metrics(height: 48, padding: 30)
            case .medium:
                return Metrics(height: 40, padding: 30)
            case .small:
                return Metrics(height: 40, padding: 15)
            }
        }
    }
    
    enum Style {
        case gradient(startColor: UIColor, endColor: UIColor)
        case border(color: UIColor)
        case solid(color: UIColor, textColor: UIColor)
        
        static var defaultGradient: Style {
            return .gradient(startColor: .mango, endColor: .highlightCoral)
        }
        
        static var defaultBorder: Style {
            return .border(color: .lightGray)
        }
    }
    
    //MARK: - Views
    private weak var iconView: UIImageView!
    
    var style = Style.defaultBorder {
        didSet {
            applyStyle()
        }
    }
    
    var size: Size = .normal {
        didSet {
            applySize()
        }
    }
    
    var metrics: Metrics? = nil {
        didSet {
            applySize()
        }
    }
    
    private var activeMetrics: Metrics {
        return metrics ?? size.metrics
    }
    
    var iconImage: UIImage? {
        set {
            iconView.image = newValue?.withRenderingMode(.alwaysTemplate)
            updateInsets()
        }
        get {
            return iconView.image
        }
    }
    
    override func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {
        super.setAttributedTitle(title, for: state)
        invalidateIntrinsicContentSize()
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        invalidateIntrinsicContentSize()
    }
    
    var highlightedGradient: [UIColor] = [.mango, .highlightCoral]
    var borderImageColor = UIColor.coral
    
    private weak var gradientLayer: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.masksToBounds = true
        adjustsImageWhenHighlighted = false
        setTitleColor(.white, for: .highlighted)
        
        addIconImageView()
        applyStyle()
        applySize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer?.frame = layer.bounds
    }
    
    override var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else {
                return
            }
            
            if isHighlighted {
                let gradientLayer = currentGradient()
                gradientLayer.colors = highlightedGradient.map { $0.cgColor }
                gradientLayer.locations = [0, 0.3, 1]
                gradientLayer.isHidden = false
                
                layer.borderWidth = 0
                
                iconView.tintColor = .white
            } else {
                gradientLayer?.isHidden = true
                applyStyle()
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            guard isEnabled != oldValue else {
                return
            }
            
            if !isEnabled {
                let gradientLayer = currentGradient()
                gradientLayer.colors = [UIColor.separatorColor.cgColor, UIColor.separatorColor.cgColor]
                gradientLayer.locations = [0, 0.3, 1]
                gradientLayer.isHidden = false
                
                layer.borderWidth = 0
                
                iconView.tintColor = .white
            } else {
                applyStyle()
            }
            
        }
    }
    
    private func addIconImageView() {
        let imageView = UIImageView(image: nil)
        self.iconView = imageView
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 25),
            imageView.heightAnchor.constraint(equalToConstant: 25),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25)
        ])
    }
    
    private func applyStyle() {
        titleLabel?.font = StyledButton.font
        
        switch style {
        case .gradient(let startColor, let endColor):
            setTitleColor(.white, for: .normal)
            
            layer.borderWidth = 0
            self.backgroundColor = nil
            
            let gradientLayer = currentGradient()
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            gradientLayer.locations = [0, 0.5, 1]
            gradientLayer.isHidden = false
            
            iconView.tintColor = .white
            break
        case .border(let color):
            setTitleColor(color, for: .normal)
            
            gradientLayer?.isHidden = true
            self.backgroundColor = nil
            
            layer.borderWidth = 1
            layer.borderColor = color.cgColor
            
            iconView.tintColor = borderImageColor
            break
        case .solid(let color, let textColor):
            setTitleColor(textColor, for: .normal)
            
            layer.borderWidth = 0
            gradientLayer?.isHidden = true
            
            self.backgroundColor = color
            
            iconView.tintColor = textColor
            break
        }
    }
    
    private func currentGradient() -> CAGradientLayer {
        if let gradientLayer = self.gradientLayer {
            return gradientLayer
        }
        
        let gradientLayer = CAGradientLayer()
        self.gradientLayer = gradientLayer
        gradientLayer.isHidden = true
        gradientLayer.frame = layer.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        layer.insertSublayer(gradientLayer, at: 0)
        
        return gradientLayer
    }
    
    private func applySize() {
        layer.cornerRadius = activeMetrics.height / 2
        updateInsets()
    }
    
    private func updateInsets() {
        let padding = activeMetrics.padding
        if iconView?.image != nil {
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 27 + padding, bottom: 0, right: padding)
        } else {
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        }
        invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            let textWidth = titleLabel?
                .sizeThatFits(CGSize(
                    width: CGFloat.greatestFiniteMagnitude,
                    height: CGFloat.greatestFiniteMagnitude))
                .width ?? 100
            let width: CGFloat = textWidth + self.contentEdgeInsets.left + self.contentEdgeInsets.right
            return CGSize(width: width, height: activeMetrics.height)
        }
    }
}

extension UIColor {
static let coral = #colorLiteral(red: 0.9960784314, green: 0.368627451, blue: 0.2549019608, alpha: 1)              // FE5E41
static let mango = #colorLiteral(red: 0.9960784314, green: 0.5529411765, blue: 0.1921568627, alpha: 1)              // FE8D31
static let highlightCoral = #colorLiteral(red: 0.8862745098, green: 0.1960784314, blue: 0.07450980392, alpha: 1)     // E23213
static let highlightMango = #colorLiteral(red: 0.9294117647, green: 0.5764705882, blue: 0, alpha: 1)     // ED9300
static let separatorColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)    // EEEEEE
}
