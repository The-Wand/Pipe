///
/// Copyright © 2020-2024 El Machine 🤖
/// https://el-machine.com/
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
/// 1) .LICENSE
/// 2) https://apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Alex Kozin
/// 2020 El Machine

#if canImport(UIKit)
import CoreServices.UTCoreTypes
import UIKit.UIImagePickerController
import UniformTypeIdentifiers

extension UIImagePickerController: Constructable {

    public static func construct(in pipe: Pipe) -> Self {

        let delegate = pipe.put(Delegate())
        
        let picker = pipe.put(Self())
        picker.allowsEditing = false
        picker.delegate = delegate

        let type: String
        if #available(iOS 14.0, *) {
            type = pipe.get() ?? UTType.image.identifier
        } else {
            type = pipe.get() ?? "kUTTypeImage"//kUTTypeImage as String
        }
        picker.mediaTypes = [type]

        return pipe.put(picker)
    }
    
}

extension UIImagePickerController {
    
    class Delegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, Pipable {
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            picker.dismiss(animated: true)
            
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            isPiped?.put(image)
        }
        
    }
    
}
#endif
