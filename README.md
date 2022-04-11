# LoodosMovie

### Loodos - Challange 

- Mimari olarak Clean Architecture ve MVVM-C kullanılmıştır.
- Splash Sayfası, Film Arama ve Listeleme Sayfası, Film Detay sayfaları eklenmiştir.
- Firebase Remote Config, Analytics, In-App Messaging kullanılmıştır.
- Dökümanda Push Notification istenmiş ancak developer sertifikası olmadığı için In-App messaging kullanılmıştır. Detay sayfasına gidildiğinde atılan MovieDetail log event atıldığında in-App tetiklenir.

<br />

### SS

![](https://github.com/namikkaya/LoodosMovie/blob/main/logEvent.png)

> Analytics Log.

<br />
<br />

![](https://github.com/namikkaya/LoodosMovie/blob/main/inAppMessaging.png)

> In-App Messaging.

<br />
<br />

## NOT:

Cihaz testi yapılmamıştır. Geliştirme süresince simulator (iPhone 11- iOS 15.4) kullanılmıştır. -FIRDebugEnabled Scheme -> Arguments Passed On Launch için eklidir.
