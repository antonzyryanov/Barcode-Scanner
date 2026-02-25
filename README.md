# Сканнер штрихкодов

IOS/Android клиент на Flutter для тестового приложения-сканнера штрихкодов

Комментарии для MSTech добавлены в конец документации

## Запуск

Запуск возможен либо с бэкенд сервером, написанным для данного приложения, либо с включенным мок нетворк репозиторием внутри клиента.

1. Скачать Backend часть приложения: 

https://github.com/antonzyryanov/Barcode-Scanner-Backend.git

Либо сразу скачать этот проект, открыть в IDE и в файле app_settings.dart поле isMockOn поменять на true, ввести 'flutter build apk' и перейти сразу к пункту 6 (Вариант без бэкенда)

2. Установить NodeJS при необходимости
3. Открыть проект Backend части в VSCode , запустить NodeJS сервер одной из двух команд:

"npm start"

либо

"node server.js"

4. Скачать данный Flutter проект, открыть в VSCode
5. В app_settings.dart поменять SERVER_IP на IP адрес локальной машины, на которой запущен бэкенд сервер
6. Ввести "flutter pub get" для загрузки зависимостей
7. Ввести "flutter run" для сборки и запуска

Если физический девайс слабый, запускать через "flutter run --release" для более лучшей производительности

## Скриншоты приложения

<table>
	<tr>
		<td><img src="app_screenshots/screenshot_1.jpg" alt="Screenshot 1"></td>
		<td><img src="app_screenshots/screenshot_2.jpg" alt="Screenshot 2"></td>
		<td><img src="app_screenshots/screenshot_3.jpg" alt="Screenshot 3"></td>
        <td><img src="app_screenshots/screenshot_4.jpg" alt="Screenshot 3"></td>
	</tr>
	<tr>
		<td><img src="app_screenshots/screenshot_5.jpg" alt="Screenshot 1"></td>
		<td><img src="app_screenshots/screenshot_6.jpg" alt="Screenshot 2"></td>
		<td><img src="app_screenshots/screenshot_7.jpg" alt="Screenshot 3"></td>
        <td><img src="app_screenshots/screenshot_8.jpg" alt="Screenshot 3"></td>
	</tr>
    <tr>
		<td><img src="app_screenshots/screenshot_9.jpg" alt="Screenshot 1"></td>
		<td><img src="app_screenshots/screenshot_10.jpg" alt="Screenshot 2"></td>
		<td><img src="app_screenshots/screenshot_11.jpg" alt="Screenshot 3"></td>
        <td><img src="app_screenshots/screenshot_12.jpg" alt="Screenshot 3"></td>
	</tr>
	<tr>
		<td><img src="app_screenshots/screenshot_13.jpg" alt="Screenshot 1"></td>
		<td><img src="app_screenshots/screenshot_14.jpg" alt="Screenshot 2"></td>
		<td><img src="app_screenshots/screenshot_15.jpg" alt="Screenshot 3"></td>
        <td><img src="app_screenshots/screenshot_16.jpg" alt="Screenshot 3"></td>
	</tr>
    <tr>
		<td><img src="app_screenshots/screenshot_17.jpg" alt="Screenshot 1"></td>
		<td><img src="app_screenshots/screenshot_18.jpg" alt="Screenshot 2"></td>
		<td><img src="app_screenshots/screenshot_19.jpg" alt="Screenshot 3"></td>
        <td><img src="app_screenshots/screenshot_20.jpg" alt="Screenshot 3"></td>
	</tr>
</table>

## Штрихкоды для Manual тестов

### Barcode 1
![Barcode 1](manual_tests/barcodes/barcode_1.jpg)

### Barcode 2
![Barcode 2](manual_tests/barcodes/barcode_2.jpg)

### Barcode 3
![Barcode 3](manual_tests/barcodes/barcode_3.jpg)

### Barcode 4
![Barcode 4](manual_tests/barcodes/barcode_4.jpg)

### Barcode 5
![Barcode 5](manual_tests/barcodes/barcode_5.jpg)

### Barcode 6
![Barcode 6](manual_tests/barcodes/barcode_6.jpg)

### Barcode 7
![Barcode 7](manual_tests/barcodes/barcode_7.jpg)

### Barcode 8
![Barcode 8](manual_tests/barcodes/barcode_8.jpg)

### Barcode 9
![Barcode 9](manual_tests/barcodes/barcode_9.jpg)

### Barcode 10
![Barcode 10](manual_tests/barcodes/barcode_10.jpg)

### Unknown Barcode
![Unknown Barcode](manual_tests/barcodes/barcode_unknown.jpg)

## Видео выполненных мануальных тестов на обеих платформах:

https://drive.google.com/drive/folders/1pdoobQEN1ZoZ0jdwCH0acMS6egbV-kFs?usp=sharing

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

6. Частичная реализация принципа Open Closed в объявлении классов покрытых протоколами, но в то же время без модификатора final

7. Применение принципа Barbara Liskov Substitution Principle в тестах. (data_layer_state_test.dart, main_state_test.dart)
Проверка в тестах того, что потомок протокола/класса все еще является потомком - гарантия того, что в будущем случайно не попытаются снять протокол с данных протоколов/классов.

8. Применение принципа Interface Segregation Principle:

В классе GoodsInStockMockRepository нет полей serverIP и serverPort потому что они там не нужны. Соответсвенно и в общем протоколе GoodsInStockRepositoryProtocol их нет, а есть только метод необходимый обеим имплементациям.

9. Применение принципа Dependency Inversion Principle:

Применение принципа Dependency Inversion Principle в классе DIContainer. MainBloc не зависит от какой-либо фиксированной ипмплемантации более низкого по абстракции уровня, а наоборот имплементации закрыты протоколом DataLayerWorker

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
![Manual Test 1](manual_tests/unit_tests/manual_test_1.jpg)

### Manual Test Screen 2
![Manual Test 2](manual_tests/unit_tests/manual_test_2.jpg)

### Manual Test Screen 3
![Manual Test 3](manual_tests/unit_tests/manual_test_3.jpg)

### Manual Test Screen 4
![Manual Test 4](manual_tests/unit_tests/manual_test_4.jpg)

### Manual Test Screen 5
![Manual Test 5](manual_tests/unit_tests/manual_test_5.jpg)

### Manual Test Screen 6
![Manual Test 6](manual_tests/unit_tests/manual_test_6.jpg)

### Manual Test Screen 7
![Manual Test 7](manual_tests/unit_tests/manual_test_7.jpg)

### Manual Test Screen 8
![Manual Test 8](manual_tests/unit_tests/manual_test_8.jpg)


14. UI/UX принципы 

Иерархия: Визуальное выделение самого важного - картинки, названия товара и кнопки (размером, цветом, шрифтом)

Простота и минимализм: есть только нужные элементы

Доступность: интерфейс понятен и удобен для всех

Последовательность (Консистентность): использование единых стилей, кнопок и логики во всем приложении

Наглядность и обратная связь (Feedback): клиент немедленно реагирует на действия пользователя (анимация нажатия кнопки, лоадеры, алерты об ошибках)

Контроль со стороны пользователя: Возможность вернуться назад из сканнера кодов на главный экран

Пространство: правильное использование "воздуха" между элементами, чтобы избежать перегрузки

15. Чистый код

Полностью удалены все комментарии. Код поясняет сам себя. При этом написана подробная документация в отдельном файле

Деление виджета с главной страницы на компоненты.

Понятные самопоясняющие имена переменных, функций и параметров

Нет закоментированного мертвого кода

Все используемые в приложении цвета вынесены в один файл-палитру app_theme.dart

Соблюдены Dart конвенции именования файлов и папок через snake_case

Решение по размеру некоторых файлов на примере shop_item_widget.dart:

Получился относительно большой виджет, но он отвечает за один логически выделяемый UI элемент - виджет информации по запрошенному товару. Он получился достаточно простым, почти не содержит логики, одна верстка, поэтому чтобы избежать непонятного спагетти-кода не стал дробить на виджеты дальше и оставил все в одном компоненте. Серединный путь, чтобы не борщить с принципами SOLID

Отступы, шрифты и размеры иконок стандартизированы. Их значения вынесены в отдельные файлы: spacing_config.dart, typography_config.dart, icon_sizing_config.dart

Использование try-catch блока в Нетворк репозитории, а не реализация всех проверок ошибок через if else, чтобы непрерывно можно было читать код логики в случае выполнения программы по желательному сценарию, и чтобы проработка исключений была в своем отдельном непрерывном блоке

16. Кодогенерация

Кодогонерация тестовых сущностей с помощью Mockery

## Continuous Integration (CI)

### Автоматизированное тестирование и Push в Git

Этот проект включает автоматизацию CI для обеспечения качества кода путём выполнения тестов перед отправкой в git.

#### Вариант 1: Local CI Script (Windows - PowerShell)

Запустите локальный CI-процесс, используя предоставленный скрипт PowerShell:

```powershell
.\ci.ps1
```

Или с пользовательским сообщением коммита:

```powershell
.\ci.ps1 -CommitMessage "Your custom message"
```

Скрипт выполнит:

Запуск всех модульных и виджетных тестов командой flutter test
Прервет выполнение, если какие-либо тесты не пройдут, с выводом сообщения об ошибке
Проверит наличие несохранённых изменений
Зафиксирует все изменения с указанным сообщением
Выполнит пуш в удалённый репозиторий git

То же самое, но с проверкой перед пушом, что проект билдится:

```powershell
.\ci-build.ps1
```

Или с пользовательским сообщением коммита:

```powershell
.\ci-build.ps1 -CommitMessage "Your custom message"
```

#### Вариант 2: GitHub Actions (Automated CI/CD)

GitHub Actions автоматически запускает тесты при каждом пуше в ветки main или develop, а также при создании pull-запросов.

Файл рабочего процесса (.github/workflows/ci.yml) выполняет:

Проверку кода
Настройку окружения Flutter
Установку зависимостей с помощью flutter pub get
Запуск тестов командой flutter test
Выполнение анализа кода командой flutter analyze
Если какой-либо шаг завершится с ошибкой, пуш или PR будет отмечен как неуспешный, и вы получите уведомление.

Команда для локального запуска CI из проекта:

.\ci.ps1

Если консоль выдает ошибку безопасности, то нужно обойти ограничение политики выполнения. Выполните эту команду:

powershell -ExecutionPolicy Bypass -File .\ci.ps1

Или чтобы установить политику перманентно:

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

## Что сделано 7-8 февраля:

1. Добавлен CI на Github Actions (тесты гитхаба перед пушем) + локальная CI команда для запуска тестов и последующего пуша прямо из проектного терминала. Вручную проверена их работоспособность.

2. Приняты дополнительные меры по чистоте кода: переименование папок в snake_case стилистике согласно стандартам Dart, все значения цветов встречающиеся в виджетах проекта вынесены в один отдельный файл-палитру app_theme.dart. Потенциально непонятные числовые константы вынесены в переменные константы соответсвующих классов с поясняющим названием. (Пример - AnimatedButton). Force Unwrap (!) заменены на (?) в shop_item_widget.dart.Ко всем кастомным виджетам добавлен суффикс Widget, чтобы можно было легче ориентироваться, не заходя в сами модули.

3. Апгрейд UX/UI

Добавлены плавные анимации появления/исчезновения всех элементов с нелинейной скоростью (Делается для того, чтобы интерфейс воспринимался пользователем как более естественный. В реальном мире большинство объектов двигаются с нелинейной скоростью)

Добавлен кастомный виджет алерта ошибки вместо дефолтного

Добавлен кастомный AppBar

Добавлена адаптивность экрана под разные устройства

Отступы, шрифты и размеры иконок стандартизированы. Их значения вынесены в отдельные файлы: spacing_config.dart, typography_config.dart, icon_sizing_config.dart

4. Обработаны исключительные кейсы:

I. Ввод заказчиком длинных полей на сервере

II. Разработчик забыл указать на клиенте IP адрес либо порт Бэкенд сервера

Скриншоты ниже

5. Добавлены русская и английская локализации. Выбор происходит автоматически исходя из языка устройства

## Скриншоты мануальных тестов CI
![CI Manual Test 1](manual_tests/ci/ci_test_1.jpg)
![CI Manual Test 2](manual_tests/ci/ci_test_2.jpg)
![CI Manual Test 3](manual_tests/ci/ci_test_3.jpg)
![CI Manual Test 2](manual_tests/ci/ci_test_4.jpg)
![CI Manual Test 3](manual_tests/ci/ci_test_5.jpg)

## Скриншоты мануального теста кейса ввода заказчиком длинных полей на сервере
![Long Input Test 1](manual_tests/long_input/long_input_test1.jpg)
![Long Input Test 2](manual_tests/long_input/long_input_test2.jpg)

## Скриншоты мануального теста локализации
![Тест локализации 1](manual_tests/localization/localization_1.jpg)
![Тест локализации 2](manual_tests/localization/localization_2.jpg)
![Тест локализации 3](manual_tests/localization/localization_3.jpg)

## Скриншоты мануального теста кейса, когда разработчик забыл указать на клиенте IP адрес либо порт Бэкенд сервера
![На клиенте не указан IP адрес либо порт бэкенд сервера](manual_tests/client_no_server_data/client_no_server_data.jpg)

## Документация к анимациям проекта:

1. Файл конфигурации анимаций - animation_config.dart
Создан централизованный файл с best practices:

⏱️ Durations - разные длительности для разных типов анимаций (400ms для переходов страниц, 300ms для fade)
🎯 Curves - нелинейные кривые для реалистичности:
Curves.easeInOutCubic - плавные переходы страниц
Curves.easeOutBack - реалистичное нажатие кнопки
Curves.elasticOut - эффект упругости при отпускании кнопки
Curves.easeOutCubic - slide анимация
2. AnimatedFadeSlideWidget - универсальный виджет анимации
✨ Комбинация Fade (постепенное появление) + Slide (движение снизу вверх)
⏰ Поддержка delay для поэтапного появления элементов
🎭 Используется во всех виджетах для плавности
3. Улучшенный AnimatedButtonWidget
Было: Простая анимация scale с увеличением до 1.10
Стало:

👆 Реагирует на onTapDown/onTapUp для более отзывчивого поведения
📉 Уменьшается до 0.92 при нажатии (более реалистично)
🎪 Использует Curves.easeOutBack при нажатии и Curves.elasticOut при отпускании
⚡ Немедленная реакция без искусственных задержек

4. HomePageWidget с AnimatedSwitcher
🔄 Плавные переходы между всеми состояниями (loader, content, data loaded)
🎬 Комбинация Fade + Slide для каждого перехода (400ms)
🔑 Уникальные ключи для каждого состояния чтобы AnimatedSwitcher корректно работал
5. ShopItemWidget с каскадным появлением
Элементы появляются поэтапно с задержками:

100ms - Изображение товара
200ms - Название товара
300ms - Заголовок "Sizes in stock"
400ms+ - Каждый размер с интервалом 80ms
Финал - Кнопка сканирования
6. Error screen с анимациями
Элементы ошибки появляются последовательно:

Иконка ошибки (100ms delay)
Текст "Error loading item" (200ms delay)
Сообщение об ошибке (300ms delay)
Кнопка повтора (400ms delay)

🎯 Использованные Best Practices :
✅ Centralized configuration - все константы анимаций в одном месте
✅ Nелинейные кривые - Curves.easeInOutCubic, elasticOut, easeOutBack
✅ Каскадное появление - с продуманными задержками
✅ Отзывчивость - кнопка реагирует на touch events, не на delayed callbacks
✅ Transitions - комбинация Fade + Slide для плавности
✅ Reusability - AnimatedFadeSlideWidget переиспользуется везде

## Комментарии для MSTech

## Работа с ИИ-Агентом

Для ТЗ использовал тестовый проект, написанный на прошлой неделе

Работу с ИИ-Агентом осуществляю следующим образом:

1. Самостоятельно погружаюсь в контекст проекта, его архитектуру, дизайн-код.
2. В своей голове перевожу запросы бизнеса в необходимые модели, логические сущности и
элементы UI
3. В обычном блокноте записываю промпт, формулируя требования и уточняя критичные детали.
При этом указываю нужные уже существующие в проекте элементы архитектуры, классы отвечающие за дизайн, унифицированные UI компоненты и места в коде, чтобы ИИ
принимал изначально более правильные решения.
Сохраняю этот файл на диске
4. Ввожу промпт в ИИ агент, смотрю на его промежуточные ответы, в желаемом ли направлении он двигается. При необходимости останавливаю и делаю дополнительный запрос-комментарий
5. Просматриваю сделанные изменения, делаю необходимые мини-промпты правки при необходимости. Проверяю результаты правок
6. Провожу мануальные тесты на реальном устройстве, при необходимости запрашивая промпты-правки
7. Делаю заключительный осмотр всех модифицированных файлов и финальный мануальный тест
8. Пушу в гит с CI тестами либо отправляю на код-ревью 

Для проекта взяты ссылки на картинки кроссовок из интернета с сайтов третьих лиц. Так что 1-2 могут не загрузиться, если их удалили с оригинального ресурса

## Видео мануальных тестов и разработки для MSTech:

Ссылка: https://drive.google.com/drive/folders/14ofK5jC97dvqTKeoFf93A5tYLtDh_YWT?usp=sharing