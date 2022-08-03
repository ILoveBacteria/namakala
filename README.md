# Namakala

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Issues](https://img.shields.io/github/issues/ILoveBacteria/namakala)](https://github.com/ILoveBacteria/namakala/issues)
[![Forks](https://img.shields.io/github/forks/ILoveBacteria/namakala)](https://github.com/ILoveBacteria/namakala/network/members)
[![Stars](https://img.shields.io/github/stars/ILoveBacteria/namakala)]()
[![Latest release](https://img.shields.io/github/release/ILoveBacteria/namakala)](https://github.com/ILoveBacteria/namakala/releases)
[![Watchers](https://img.shields.io/github/watchers/ILoveBacteria/namakala)]()
[![Last commit](https://img.shields.io/github/last-commit/ILoveBacteria/namakala)](https://github.com/ILoveBacteria/namakala/commits/master)

## Description

![thumbnail](https://github.com/ILoveBacteria/namakala/blob/master/assets/github/namakala-thumbnail.png)

This is my project for the Advanced Programming course associated with Shahid Beheshti University.
This application was created with the Flutter framework and in connection with the Java server.

Namakala is a place for buying and selling your products. Create your profile and set up your market.

## Dependencies

### Java Server

* [**JSON.simple**](https://mvnrepository.com/artifact/com.googlecode.json-simple/json-simple) A simple Java toolkit for JSON

### Flutter

* [**google_fonts**](https://pub.dev/packages/google_fonts) A Flutter package to use fonts from [fonts.google.com](fonts.google.com)
* [**image_picker**](https://pub.dev/packages/image_picker) A Flutter plugin for iOS and Android for picking images from the image library, and taking new pictures with the camera
* [**flutter_launcher_icons**](https://pub.dev/packages/flutter_launcher_icons) A command-line tool which simplifies the task of updating your Flutter app's launcher icon

## Run The Project

### Server

#### First Way

1. Download the last release of the server from [here](https://github.com/ILoveBacteria/namakala/releases)
2. To run the `jar` file, use this command:
```shell
java -jar namakala-x.x.x-jar-with-dependencies.jar
```

#### Second Way

1. clone this repository:
```shell
git clone https://github.com/ILoveBacteria/namakala.git
```

2. Open the server source codes in your IDE
3. Reload maven to download all dependencies
4. Run `server.Server`

### Flutter Application

1. clone this repository:
```shell
git clone https://github.com/ILoveBacteria/namakala.git
```

2. In the IDE, click **Create New Project** from the Welcome window or **File > New > Project** from the main IDE window.

   **Important:** Do _not_ use the **New > Project from existing sources** option for Flutter projects.
3.   Select **Flutter** in the menu, and click **Next**.
4.   Under **Project location** enter, or browse to, the directory holding existing Flutter source code files.
5.   Click Finish.
6.   The project will be loaded in Android Studio, you will see some alert messages.
7.   From the **terminal**: Run `flutter pub get`. to load all dependencies in project.
8.   Your code now is loaded into Android Studio, you can Edit, Browse, Change, and Use any source code file in the project.

**Important:** You need to build and run **both** the server and flutter app. 

### Sample Data

If you run the app, you will see the product lists are empty. To have better experience with this app you should build
and run `database.SampleData` from java source codes. This will create a prepared data for the app.

## License

This project is using **GNU General Public License v3.0**

Read full LICENSE [here](https://github.com/ILoveBacteria/namakala/blob/master/LICENSE)

## Last Release

Find the last version of the application for your Android device [here](https://github.com/ILoveBacteria/namakala/releases)
