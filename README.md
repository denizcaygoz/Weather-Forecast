# Weather-Forecast
A Weather Forecast App made with Flutter.

<p align="center">
  <img src="https://github.com/user-attachments/assets/eea349b8-e7c1-419a-aa36-66727acaeebf" width="30%" height="30%">
  <img src="https://github.com/user-attachments/assets/7fba50f0-de60-47bc-af4f-ce1505e93b6a" width="30%" height="30%">
  <img src="https://github.com/user-attachments/assets/cf47a268-117f-43e6-a96a-1d13bf8f1675" width="30%" height="30%">
</p>

The design belongs to the following Figma project:  
🔗 **[Weather App Figma Project](https://www.figma.com/design/y0kC8X38VyibS5TsVdX0A7/Weather-app-(Community)?node-id=0-1&p=f&t=R8fJvqdm0IVq0pLg-0)**  

---

## **How to Setup**
1️⃣ **Clone the project** to your local computer.  
2️⃣ **Navigate to the `lib` folder** and **create a new folder** called `.env`.  
3️⃣ Inside `.env`, **create a file** named `keys.dart`.  
4️⃣ **Paste the following code** inside `keys.dart`:

```dart
class EnvKeys {
  static const String apiKey = 'YOUR_API_KEY';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
}


