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

import Contacts.CNContact

///
/// #Usage
/// ```
///
///   |{ (contact: CNContact) in
///
///   }
///
///   CNContact.predicateForContacts(matchingName: "John Appleseed") | .every { (contact: CNContact) in
///
///   }
///
/// ```
///
extension CNContact: Asking {

    public static func ask<T>(_ ask: Ask<T>, from pipe: Pipe) {

        guard pipe.ask(for: ask) else {
            return
        }

        let source: CNContactStore  = pipe.get()
        let keys: [CNKeyDescriptor] = pipe.get() ?? []

        source.requestAccess(for: .contacts) { granted, error in
            guard granted else {
                return
            }
            
            let request = CNContactFetchRequest(keysToFetch: keys)
            request.predicate = pipe.get()
            do {
                try source.enumerateContacts(with: request) { contact, stop in
                    pipe.put(contact)
                }
            } catch {
                print(error)
            }
        }

    }
    
}
