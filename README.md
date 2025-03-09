# Weather-Forecast
A Weather Forecast App made with Flutter.

![1-firstpage](https://github.com/user-attachments/assets/eea349b8-e7c1-419a-aa36-66727acaeebf)
![2-mainpage](https://github.com/user-attachments/assets/7fba50f0-de60-47bc-af4f-ce1505e93b6a)
![3-sidepage](https://github.com/user-attachments/assets/cf47a268-117f-43e6-a96a-1d13bf8f1675)

The design belongs to the following Figma project: https://www.figma.com/design/y0kC8X38VyibS5TsVdX0A7/Weather-app-(Community)?node-id=0-1&p=f&t=R8fJvqdm0IVq0pLg-0

# How to Setup
-After cloning the project to your computer. Open up the project and create a folder called .env inside lib folder. 

-Inside .env folder create a file called keys.dart

-Paste the following code inside keys.dart:
class EnvKeys {
  static const String apiKey = 'YOUR_API_KEY';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
}

-From https://openweathermap.org/api you need to first sign-up and get a free api key and paste it to String apiKey.

-If you don't have any android emulator in your computer, download Android Studio and there install an emulator.


