![][ios] ![][swift] ![][uikit]  ![][MVP] ![][urlSession]  ![][snapKit]  ![][filemanager] ![][photos] ![][WaterfallLayout] ![][Gifu] ![][spm] ![][cocoapods]
# Giphy "clone".

### Описание:
#### *Приложение для просмотра гифок с возможностью делиться ими, копировать ссылку или сохранять в галлерею.*

----

### Цель:

- Реализовать мозаичный вид коллекции с динамичной высотой гифок.
- Избежать подлагиваний коллекции при скролле.
- Реализовать детальный просмотр выбранной гифки с возможность поделиться ей, сохранить в галерею или скопировать ссылку на сайт.
- Реализовать возможость делиться гифкой сразу в несколько популярных сервисов (iMessage, Facebook, SnapChat, WhatsApp, Instagram, Twitter).
- Пагинация.

----

### Трудности:

- Долго пытался разобраться как сверстать мозаичный лэйаут, в итоге после нескольких часов попыток, решил найти подходящую библиотеку, выбрал WaterfallLayout. 
- Возникла сложность с показом гифки, искал информацию о том как это реализовать и понял что тема требует довольно глубокого изучения для создания оптимизированного решения, времени не было, поэтому тоже прибег к поиску библиотеки.
- Попробовав одно решение для показа гиф, моя коллекция начинала тормозить при скролле, хотя настройка коллекции, обновление данных, переиспользование и кеширование данных были реализованы достаточно хорошо. Начал разбираться в коде используемой библиотеки и смог обнаружить, что в ней парсят сразу все фреймы гифки, и держат их весь жизненный цикл гифки, при этом нет возможности прервать или остановить анимацию для оптимизации, из-за чего в свою очередь приложение начинало довольно много весить, лишь стоило немного проскроллить. В итоге с новым знанием нашел библиотеку с достаточно оптимизированным решением и умело внедрил ее в проект.
- Из-за небольшого кол-ва времени для написания задачи (2 дня), не успел разобраться с предоставляемыми API популярных сервисов, чтобы интегрировать возможность поделитья гифкой сразу в них, успел реализовать только iMessage.

---

### Итог:

- Коллецкия с красивым мозаичным видом.
- Реализован сервис для кеширования гиф.
- Добился плавного скролла.
- Кеширование и использование подгуженного контента между переключениями категорий.
- Можно отправить гиф сразу по iMessage, или поделиться через дефолтный выбор доступных приложений.
- Есть возможность скопировать ссылку на гиффку одник кликом.
- Есть возможность сохранить гифку в галлерею.
- Подгрузка контента по необходимости при скролле. 

----
### Приложение в движении с отображением затрат на память


||||
|:-:|:-:|:-:|
||||
|Главный экран|Анимация при <br> плохом интернете|Переключение категорий|
|![][01]|![][load]|![][change]|
|Открытие детального экрана|Копирование ссылки|Поделиться/Сохранить в галлерею|
|![][detail]|![][copy]|![][save]|

|Пагинация <br> (гифка весит больше остальных, может чуть дольше грузить)|
|:-:|
|![][pagination]|

# Как попробовать?
- Заведит учетную запись для разработчика на giphy.
- Получите API KEY.
- В файле `GiphyApi.swift`, на `12` строчке, присвойте ваш ключ приватному полю `apiKey`.

> Путь до файла `GlamTestTaskGIPHY/Sources/Core/Api/GiphyApi.swift`

[01]: https://github.com/Dmmolod/GiphyTestTask/blob/master/Gifs/01.gif
[02]: https://github.com/Dmmolod/GiphyTestTask/blob/master/Gifs/02.gif
[03]: https://github.com/Dmmolod/GiphyTestTask/blob/master/Gifs/03.gif
[load]: https://github.com/Dmmolod/GiphyTestTask/blob/master/Gifs/loadShimmer.gif
[change]: https://github.com/Dmmolod/GiphyTestTask/blob/master/Gifs/ChangeCategory.gif
[detail]: https://github.com/Dmmolod/GiphyTestTask/blob/master/Gifs/openDetail.gif
[copy]: https://github.com/Dmmolod/GiphyTestTask/blob/master/Gifs/copyLink.gif
[save]: https://github.com/Dmmolod/GiphyTestTask/blob/master/Gifs/saveAndShare.gif
[pagination]: https://github.com/Dmmolod/GiphyTestTask/blob/master/Gifs/pagination.gif

[ios]: https://img.shields.io/badge/iOS-13.0-critical
[swift]: https://img.shields.io/badge/-Swift-9cf
[uikit]: https://img.shields.io/badge/-UIKit-blue
[snapkit]: https://img.shields.io/badge/-SnapKit-9cf
[urlSession]: https://img.shields.io/badge/-URLSession-blue
[MVP]: https://img.shields.io/badge/-MVP-9cf
[filemanager]: https://img.shields.io/badge/-FileManager-blue
[photos]: https://img.shields.io/badge/-Photos-9cf
[WaterfallLayout]: https://img.shields.io/badge/-WaterfallLayout-blue
[Gifu]: https://img.shields.io/badge/-Gifu-9cf
[spm]: https://img.shields.io/badge/-SPM-ff69b4
[cocoapods]: https://img.shields.io/badge/-CocoaPods-ff69b4
