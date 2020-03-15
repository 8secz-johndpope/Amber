import UIKit

class SwipeCardView : UIView {
   
    //MARK: - Properties
    var swipeView : UIView!
    var shadowView : UIView!
    var imageView: UIImageView!
    var customClass: CardsDataModel!
    var label = UILabel()
    var moreButton = UIButton()
    var labelBrand = UILabel()
    var labelPrice = UILabel()
    var delegate : SwipeCardsDelegate?

    var divisor : CGFloat = 0
    let baseView = UIView()

    
    
    var dataSource : CardsDataModel? {
        didSet {
            swipeView.backgroundColor = .white
            label.text = dataSource?.goodsName
            labelBrand.text = dataSource?.brandName
            labelPrice.text = dataSource!.price + "‎₽"
            guard let image = dataSource?.image else { return }
            imageView.setCustomImage(image)
            customClass = dataSource
        }
    }
    
    
    //MARK: - Init
     override init(frame: CGRect) {
        super.init(frame: .zero)
        configureShadowView()
        configureSwipeView()
        configureImageView()
        configureLabelView()
        configurePriceView()
        configureButton()
        configureBrandView()
        addPanGestureOnCards()
        configureTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    
    func configureShadowView() {
        shadowView = UIView()
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowRadius = 4.0
        addSubview(shadowView)
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        shadowView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        shadowView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    func configureSwipeView() {
        swipeView = UIView()
        swipeView.layer.cornerRadius = 15
        swipeView.clipsToBounds = true
        shadowView.addSubview(swipeView)
        
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        swipeView.leftAnchor.constraint(equalTo: shadowView.leftAnchor).isActive = true
        swipeView.rightAnchor.constraint(equalTo: shadowView.rightAnchor).isActive = true
        swipeView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor).isActive = true
        swipeView.topAnchor.constraint(equalTo: shadowView.topAnchor).isActive = true
    }
    
    func configureLabelView() {
        swipeView.addSubview(label)
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: swipeView.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: swipeView.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: swipeView.bottomAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 85).isActive = true
        
    }
    func configurePriceView() {
          swipeView.addSubview(labelPrice)
           labelPrice.backgroundColor = .white
           labelPrice.textColor = .black
           labelPrice.textAlignment = .center
           labelPrice.numberOfLines = 0
           labelPrice.font = UIFont.systemFont(ofSize: 18)
           labelPrice.translatesAutoresizingMaskIntoConstraints = false
            labelPrice.leftAnchor.constraint(equalTo: swipeView.leftAnchor, constant: 25).isActive = true
           labelPrice.topAnchor.constraint(equalTo: label.topAnchor, constant: -10).isActive = true
           labelPrice.heightAnchor.constraint(equalToConstant: 25).isActive = true
           labelPrice.widthAnchor.constraint(equalToConstant: 400).isActive = true
           
           
       }
    func configureBrandView() {
           swipeView.addSubview(labelBrand)
           labelBrand.backgroundColor = .white
           labelBrand.textColor = .black
           labelBrand.textAlignment = .center
           labelBrand.numberOfLines = 0
           labelBrand.font = UIFont.systemFont(ofSize: 18)
           labelBrand.translatesAutoresizingMaskIntoConstraints = false
            labelBrand.leftAnchor.constraint(equalTo: swipeView.leftAnchor, constant: 25).isActive = true
           labelBrand.topAnchor.constraint(equalTo: label.topAnchor, constant: -10).isActive = true
           labelBrand.heightAnchor.constraint(equalToConstant: 25).isActive = true
           labelBrand.widthAnchor.constraint(equalToConstant: 125).isActive = true
           
       }
    
    func configureImageView() {
        imageView = UIImageView()
        swipeView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: swipeView.centerYAnchor, constant: -30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 600).isActive = true
    }
    
    func configureButton() {
        label.addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "plus-tab")?.withRenderingMode(.alwaysTemplate)
        moreButton.setImage(image, for: .normal)
        moreButton.tintColor = UIColor.red
        
        moreButton.rightAnchor.constraint(equalTo: label.rightAnchor, constant: -15).isActive = true
        moreButton.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
        moreButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    }

    func configureTapGesture() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }
    
    
    func addPanGestureOnCards() {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    
    
    //MARK: - Handlers
    @objc func handlePanGesture(sender: UIPanGestureRecognizer){
        let card = sender.view as! SwipeCardView
        let point = sender.translation(in: self)
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        card.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y)
        
        let distanceFromCenter = ((UIScreen.main.bounds.width / 2) - card.center.x)
        divisor = ((UIScreen.main.bounds.width / 2) / 0.61)
       
        switch sender.state {
        case .ended:
            if card.center.x > 300 {
                delegate?.swipeDidEnd(on: card , liked: true)
                
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x + 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            } else if card.center.x < 10 {
                delegate?.swipeDidEnd(on: card, liked: false)
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x - 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            }
            UIView.animate(withDuration: 0.2) {
                card.transform = .identity
                card.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                self.layoutIfNeeded()
            }
        case .changed:
            let rotation = tan(point.x / (self.frame.width * 2.0))
            card.transform = CGAffineTransform(rotationAngle: rotation)
            
        default:
            break
        }
    }
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer){
    }
    
  
}
extension UIImageView {

    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "default.png")
            return
        }
        DispatchQueue.global().async { [weak self] in
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage(named: "default.png")
            }
        }
    }
}

