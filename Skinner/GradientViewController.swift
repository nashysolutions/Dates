import UIKit
import Gradient

class GradientViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var gradientView: GradientView!
        var colors: [CGColor]!
        var coordinates: Coordinates
        
        colors = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor]
        coordinates = GradientPoint.leftRight.coordinates
        gradientView = GradientView(colors, coordinates)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gradientView)
        gradientView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        gradientView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        gradientView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        colors = [UIColor.purple.cgColor, UIColor.clear.cgColor]
        coordinates = Coordinates(x: CGPoint(x: 0.2, y: 1), y: CGPoint(x: 0.7, y: 0))
        gradientView = GradientView(colors, coordinates)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gradientView)
        gradientView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        gradientView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        gradientView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
