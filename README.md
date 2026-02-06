# Сканнер штрих-кодов

IOS/Android клиент на Flutter для тестового приложения-сканнера штрих-кодов

## Запуск

1. Скачать Backend часть приложения: 

https://github.com/antonzyryanov/Barcode-Scanner-Backend.git

2. Установить NodeJS при необходимости
3. Открыть проект Backend части в VSCode , запустить NodeJS сервер одной из двух команд:

"npm start"

либо

"node server.js"

4. Скачать данный Flutter проект, открыть в VSCode
5. В app_settings.dart поменять SERVER_IP на IP адрес локальной машины, на которой запущен бэкенд сервер
6. Ввести "flutter pub get" для загрузки зависимостей
7. Ввести "flutter run" для сборки и запуска

## Скриншоты приложения

### App Screenshot 1
![App Screenshot 1](app%20screenshots/screen_1.jpg)

### App Screenshot 2
![App Screenshot 2](app%20screenshots/screen_2.jpg)

### App Screenshot 3
![App Screenshot 3](app%20screenshots/screen_3.jpg)

### App Screenshot 4
![App Screenshot 4](app%20screenshots/screen_4.jpg)

### App Screenshot 5
![App Screenshot 5](app%20screenshots/screen_5.jpg)

### App Screenshot 6
![App Screenshot 6](app%20screenshots/screen_6.jpg)

### App Screenshot 7
![App Screenshot 7](app%20screenshots/screen_7.jpg)

### App Screenshot 8
![App Screenshot 8](app%20screenshots/screen_8.jpg)

### App Screenshot 9
![App Screenshot 9](app%20screenshots/screen_9.jpg)

### App Screenshot 10
![App Screenshot 10](app%20screenshots/screen_10.jpg)

## Штрих-коды для Manual тестов

### Barcode 1
![Barcode 1](manual%20tests/barcodes/barcode_1.jpg)

### Barcode 2
![Barcode 2](manual%20tests/barcodes/barcode_2.jpg)

### Barcode 3
![Barcode 3](manual%20tests/barcodes/barcode_3.jpg)

### Barcode 4
![Barcode 4](manual%20tests/barcodes/barcode_4.jpg)

### Barcode 5
![Barcode 5](manual%20tests/barcodes/barcode_5.jpg)

### Barcode 6
![Barcode 6](manual%20tests/barcodes/barcode_6.jpg)

### Barcode 7
![Barcode 7](manual%20tests/barcodes/barcode_7.jpg)

### Barcode 8
![Barcode 8](manual%20tests/barcodes/barcode_8.jpg)

### Barcode 9
![Barcode 9](manual%20tests/barcodes/barcode_9.jpg)

### Barcode 10
![Barcode 10](manual%20tests/barcodes/barcode_10.jpg)

### Unknown Barcode
![Unknown Barcode](manual%20tests/barcodes/barcode_unknown.jpg)

## Видео выполненных мануальных тестов на обеих платформах:



## Описание создания проекта и пояснения по поводу выбранных в процессе решений

1. Архитектура

Выбрана характерная для Flutter проектов архитектура BLoC, нативная библиотека для которой поставляет все необходимые, в том числе и для удобного обновления UI, компоненты

2. DRY принцип

В проекте все используемые несколько раз компоненты (Например AnimatedButton) выделены в отдельные сущности.
В проекте используется одна единственная сущность для состояния приложения (Аналог DRY принципа для данных - Single Source of Truth)

3. YAGNI принцип

В проекте нет никаких ненужных неиспользуемых сущностей, "прозапас, на будущее"

4. Применение принципа Single Responsibility Principle при выделении виджетов и классов и делении их на файлы.

5. Применение принципа Single Responsibility Principle в тестах (shop_item_test.dart) в одной из его формулировок (Только один актор
 может работать с сущностью). В будущем другой актор (в данном случае другой программист), не сможет случайно поменять ожидаемое поведение сущностей, поменяв внутри поведение конструкторов. Для окончательной практической реализации нужен CI на пуш в ветку с обязательным автоматическим прохождением тестов

6. Частичное применение принципа Open Closed в объявлении классов покрытых протоколами, но в то же время без модификатора final

7. Применение принципа Barbara Liskov Substitution Principle в тестах. (data_layer_state_test.dart, main_state_test.dart)
Проверка в тестах того, что потомок протокола/класса все еще является потомком - гарантия того, что в будущем случайно не попытаются снять протокол с данных протоколов/классов.

8. Применение принципа Interface Segregation Principle:

В классе GoodsInStockMockRepository нет полей serverIP и serverPort потому что они там не нужны. Соответсвенно и в общем протоколе GoodsInStockRepositoryProtocol их нет, а есть только метод необходимый обеим имплементациям.

9. Применение принципа Dependency Inversion Principle:

Применение принципа Dependency Inversion Principle в классе DIContainer. DataLayerWorker не зависит от сущностей более низкого по абстракции уровня, а наоборот имплементации закрыты протоколом

10. Инъекция зависимостей в классе DIContainer

11. Паттерны: использован шаблон "Строитель" для отображения нужных виджетов на главной странице в зависимости от состояния приложения

12. Переиспользуемость: потенциально переиспользуемые в других проектах виджеты вынесены в папку components

13. Тесты 

Использован принцип тестирования Роберта Мартина "Red Green Refactor"
"Не верь тестам, которые никогда не проваливались"

Тесты сгенерированы ИИ агентом
После проведен аудит всех тестов, вручную проверено, фейлятся ли они при неподходящих вводных

## Скриншоты проверки адекватности unit тестов

### Manual Test Screen 1
![Manual Test 1](manual%20tests/made%20manual%20tests%20screens/manual_test_1.jpg)

### Manual Test Screen 2
![Manual Test 2](manual%20tests/made%20manual%20tests%20screens/manual_test_2.jpg)

### Manual Test Screen 3
![Manual Test 3](manual%20tests/made%20manual%20tests%20screens/manual_test_3.jpg)

### Manual Test Screen 4
![Manual Test 4](manual%20tests/made%20manual%20tests%20screens/manual_test_4.jpg)

### Manual Test Screen 5
![Manual Test 5](manual%20tests/made%20manual%20tests%20screens/manual_test_5.jpg)

### Manual Test Screen 6
![Manual Test 6](manual%20tests/made%20manual%20tests%20screens/manual_test_6.jpg)

### Manual Test Screen 7
![Manual Test 7](manual%20tests/made%20manual%20tests%20screens/manual_test_7.jpg)

### Manual Test Screen 8
![Manual Test 8](manual%20tests/made%20manual%20tests%20screens/manual_test_8.jpg)


14. UI/UX принципы 

Иерархия: Визуальное выделение самого важного - картинки, названия товара и кнопки (размером, цветом, шрифтом)

Простота и минимализм: есть только нужные элементы

Доступность: интерфейс понятен и удобен для всех

Последовательность (Консистентность): использование единых стилей, кнопок и логики во всем приложении

Наглядность и обратная связь (Feedback): клиент немедленно реагирует на действия пользователя (анимация нажатия кнопки, лоадеры, алерты об ошибках)

Контроль со стороны пользователя: Возможность вернуться назад из сканнера кодов на главный экран

Пространство: правильное использование "воздуха" между элементами, чтобы избежать перегрузки

15. Чистый код

Максимально удалены все комментариии.

Деление виджета с главной страницы на компоненты.

Понятные самопоясняющие имена переменных, функций и параметров

Нет закоментированного мертвого кода

Решение по размеру некоторых файлов на примере shop_item_widget.dart:

Получился относительно большой виджет, но он отвечает за один логически выделяемый UI элемент - виджет информации по запрошенному товару. Он почти не содержит логики, одна верстка, поэтому чтобы избежать непонятного спагетти-кода не стал дробить на виджеты дальше и оставил все в одном компоненте.

Использование try-catch блока в Нетворк репозитории, а не реализация всех проверок ошибок через if else, чтобы непрерывно можно было читать код логики в случае выполнения программы по желательному сценарию, и чтобы проработка исключений была в своем отдельном непрерывном блоке

16. Кодогенерация

Кодогонерация тестовых сущностей с помощью Mockery









