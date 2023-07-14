# YanDo

| <img src=github_images/yando_icon.png width="70" /> | YanDo - инновационное приложение, которое станет вашим незаменимым помощником в организации и повышении производительности вашей жизни! |
| --- | --- |

С YanDo вы можете превратить хаос в порядок, легко управлять своими задачами и достигать новых вершин в достижении своих целей. Это мощный инструмент, разработанный с учетом всех ваших потребностей, чтобы вы могли сосредоточиться на самом важном.

| <img src=github_images/home_page.png width="300" /> | <img src=github_images/edit_task.png width="300" /> | <img src=github_images/time_data_picker.png width="300" /> |
| --- | --- | --- |
| <img src=github_images/home_page_dark.png width="300" /> | <img src=github_images/edit_task_dark.png width="300" /> | <img src=github_images/time_data_picker_dark.png width="300" /> |

## Возможности


✅ Возможность добавить задачу используя ElevatedButton или просто написав её название

✅ Возможность закрыть задачу нажав на ComboBox или смахнув задачу

✅ Возможность изменять параметры задачи в окне редактирования задач

✅ Возможность устанавливать дедлайны используя DatePicker

✅ Синхронизация всех данных с локальной базой данных

✅ Синхронизация всех данных с сервером


## Реализовано / отклоненно

✅ Навигация инкапсулирована в отдельной сущности, отсутствуют явные переходы

✅ Текст длинных заметок обрезается по макету

✅ Поддержка ночной темы

✅ Реализована поддержка лендскейп-ориентации

✅ Реализована работа с Remote Configs, работает рантайм-переключение цвета важности (дефолтный красный по Фигме vs     #793cd8) 

✅ К проекту подключён и настроен Firebase Crashlytics, репортинг ошибок работает (+1 балл)

✅ Поддержаны 2 флейвора

❌ Реализованы анимации

❌ Настроен CI на GitHub

❌ Добавлен инструмент для аналитики

❌ Для дата-моделей используется пакет freezed 

## Библиотеки

В создании YanDo использовались такие библиотеки как:
* Provider
* intl
* device_info_plus
* Logger
* flutter_launcher_icons
* hive_flutter
* dio
* flutter_dotenv
* firebase_core
* firebase_crashlytics
* flutter_flavor
* firebase_remote_config
* firebase_analytics

## Info

Для успешной компиляции и работы проекта потребуется файл .env с данными API_URL и TOKEN

## Скачать последний релиз (V4)

https://github.com/MixKage/YanDo/releases/tag/yando4version
https://github.com/MixKage/YanDo/releases/download/yando4version/app-release.apk
