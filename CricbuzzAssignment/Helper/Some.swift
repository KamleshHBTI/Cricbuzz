//
//  Some.swift
//  Some
//
//  Created by Kamlesh on 29/09/21.
//

import Foundation
import UIKit
class Some: UIViewController{
  
}
extension UIViewController
{
  class func instantiateFromStoryboard(_ name: String = "Main") -> Self
  {
    return instantiateFromStoryboardHelper(name)
  }
  
  fileprivate class func instantiateFromStoryboardHelper<T>(_ name: String) -> T
  {
    let storyboard = UIStoryboard(name: name, bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
    return controller
  }
  
}
