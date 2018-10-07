extern crate aws_lambda as lambda;

fn main() {
    lambda::start(|()| Ok("Hello World!"))
}
