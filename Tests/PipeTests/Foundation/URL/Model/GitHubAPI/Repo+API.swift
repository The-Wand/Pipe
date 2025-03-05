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

import Pipe

extension GitHubAPI.Repo: GitHubAPI.Model {

    public static var path: String {
        base! + "repositories"
    }

}

//https://api.github.com/repositories/42
@discardableResult
func |(id: Int,
       get: Ask<GitHubAPI.Repo>.Get) -> Pipe {

    let pipe = Pipe()

    let path = GitHubAPI.Repo.path + "/\(id)"
    pipe.store(path)
    pipe.store(Rest.Method.GET)

    return pipe | get
}

//https://api.github.com/repositories
@discardableResult
prefix func |(get: Ask<[GitHubAPI.Repo]>.Get) -> Pipe {

    let pipe = Pipe()

    let path = GitHubAPI.Repo.path
    pipe.store(path)

    pipe.store(Rest.Method.GET)

    return pipe | get
}

//https://api.github.com/repositories?q=ios
@discardableResult
func |(query: String,
       get: Ask<[GitHubAPI.Repo]>.Get) -> Pipe {

    let pipe = Pipe()

    let path = GitHubAPI.Repo.path + "?q=\(query)"
    pipe.store(path)

    pipe.store(Rest.Method.GET)

    return pipe | get
}
