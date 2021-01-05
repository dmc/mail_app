# mail app

mail sample application.

## mailer libs
- [mailer 3.2.1](https://pub.dev/packages/mailer)

## Dev env

- Mac MBA 2017
- MacOS Mojave 10.14.6
- Xcode 11.3.1(11C505) 
- flutter 1.26.0-2.0.pre.86 • channel master

## Test env

- [SMTP Sever(smtp4dev)](https://github.com/rnwood/smtp4dev)
- to run smtp4dev ```docker-compose up```

- smtp4dev web interface:[http://localhost:5000](http://localhost:5000) 

- iOS Sumilator (iOS 13.2) 

## Usage

- ```docker-compose up``` to start smtp server at localhost
- ```flutter clean``` to clean workspace of Xcode
- ```flutter build ios``` to run Xcode build
- Open ./ios from Xcode. and Press Build button

## Note

- you might change bundle Identifier in Xcode


## TODO

- attach file




