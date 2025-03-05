///
/// Copyright 2020 Alexander Kozin
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Alex Kozin
/// El Machine 🤖


#if canImport(UIKit)
import UIKit.UIImage

extension Expect where T == UIImage {

    static func round(_ condition: Condition = .every,
                      to radius: CGFloat,
                      contentMode: UIView.ContentMode = .scaleAspectFill,
                      handler: ((T)->() )? = nil) -> Self {
        Self(condition: condition) { image in

            let size = image.size
            let rounded = UIGraphicsImageRenderer(size: size).image { c in
                let rect: CGRect = size|
                UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
                image.draw(in: rect)
            }

            //Change pointer
            handler?(rounded)

            return true
        }
    }

    static func resize(_ condition: Condition = .every,
                       to size: CGSize,
                       contentMode: UIView.ContentMode = .scaleAspectFill,
                       handler: ((T)->() )? = nil) -> Self {
        Self(condition: condition) { image in


            let resized: UIImage

            let resizer = { (updated: CGSize) in
                UIGraphicsImageRenderer(size: updated).image { c in
                    image.draw(in: updated|)
                }
            }

            let aspectWidth = size.width / image.size.width
            let aspectHeight = size.height / image.size.height

            switch contentMode {
                case .scaleToFill:
                    resized = resizer(size)
                case .scaleAspectFit:
                    let aspectRatio = min(aspectWidth, aspectHeight)
                    resized = resizer((width: image.size.width * aspectRatio,
                                       height: image.size.height * aspectRatio)|)
                case .scaleAspectFill:
                    let aspectRatio = max(aspectWidth, aspectHeight)
                    resized = resizer((width: image.size.width * aspectRatio,
                                       height: image.size.height * aspectRatio)|)
                default:
                    fatalError()
            }

            //Change pointer
            handler?(resized)

            return true
        }
    }


//    static func round(to radius: CGFloat,
//                      inner: Bool = false) -> Self {
//        Self(key: nil, condition: .every, inner: inner) { image in
//
//            let rounded = UIGraphicsImageRenderer(size: image.size).image { c in
//                let rect: CGRect = image.size|
//                UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
//                image.draw(in: rect)
//            }
//
//            image.isPiped
//
//            return true
//        }
//    }
//
//    .rounded(let radius):
//    return UIGraphicsImageRenderer(size: image.size).image { c in
//        let rect: CGRect = image.size|
//        UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
//        image.draw(in: rect)
//    }

}

extension UIImage: AskingWithout {

    public static func ask<T>(_ ask: Ask<T>, from pipe: Pipe) where T : Asking {

        guard pipe.ask(for: ask) else {
            return
        }

        let picker: UIImagePickerController = pipe.get()

        let sheet: UIAlertController = UIAlertController.Style.actionSheet|

        func show(source: UIImagePickerController.SourceType) {
            picker.sourceType = source
            picker.presentOnVisible()
        }

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            sheet | ("UIImagePickerController.TakePhoto", { _ in
                show(source: .camera)
            })
        }
        sheet | ("UIImagePickerController.ChoosePhoto", { _ in
            show(source: .photoLibrary)
        })
        sheet | ("UIImagePickerController.Cancel", .cancel)

        sheet.presentOnVisible()
    }
    
}

extension UIImage: Pipable {
    
    static func | (image: UIImage, renderingMode: RenderingMode) -> UIImage {
        image.withRenderingMode(renderingMode)
    }
    
    static public postfix func | (image: UIImage) -> UIImageView {
        UIImageView(image: image)
    }
    
    static func | (image: UIImage, renderingMode: RenderingMode) -> UIImageView {
        (image | renderingMode)|
    }
    
    
    enum Operations {
        case rounded(CGFloat)
    }
    
    static func | (image: UIImage, operation: Operations) -> UIImage {
        switch operation {
            case .rounded(let radius):
                return UIGraphicsImageRenderer(size: image.size).image { c in
                    let rect: CGRect = image.size|
                    UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
                    image.draw(in: rect)
                }
        }
    }
    
    func resize(withSize size: CGSize, contentMode: UIView.ContentMode = .scaleAspectFill) -> UIImage {
            let aspectWidth = size.width / self.size.width
            let aspectHeight = size.height / self.size.height
            
            switch contentMode {
            case .scaleToFill:
                return resize(withSize: size)
            case .scaleAspectFit:
                let aspectRatio = min(aspectWidth, aspectHeight)
                return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
            case .scaleAspectFill:
                let aspectRatio = max(aspectWidth, aspectHeight)
                return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
                default:
                    fatalError()
            }
        }

        private func resize(withSize size: CGSize) -> UIImage {
            UIGraphicsImageRenderer(size: size).image { c in
                draw(in: size|)
            }
        }
    
}

#endif
