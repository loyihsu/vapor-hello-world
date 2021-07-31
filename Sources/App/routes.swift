import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("this", "is", "hello") { req in
        req.redirect(to: "/hello")
    }

    let hello = app.grouped("hello")

    // http://localhost:8080/hello/
    hello.get { req -> String in
        return "Hello, World!"
    }

    // http://localhost:8080/hello/:name
    hello.get(":name") { req -> String in
        if let name = req.parameters.get("name") {
            return "Hi, \(name)"
        }
        return "No name found!"
    }

    app.get("tw", "hello") { req -> String in
        return "嗨，世界"
    }.description("Says Hello World in Traditional Chinese")



    // http://localhost:8080/hi/john/smith -> Hello, john smith
    app.get("hi", "**") { req -> String in
        let name = req.parameters.getCatchall().joined(separator: " ")
        return "Hello, \(name)!"
    }

    app.get("odd", ":number") { req -> String in
        if let number = req.parameters.get("number"), let x = Int(number) {
            return "\(number) is \(x % 2 == 0 ? "even" : "odd")"
        }
        return "No number found. Gimme a number!"
    }

    app.get("abort") { req -> String in
        throw Abort(.badRequest)
    }

    app.get("google") { req in
        req.redirect(to: "https://google.com")
    }



}
