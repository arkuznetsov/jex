[![GitHub release](https://img.shields.io/github/release/ArKuznetsov/jex.svg?style=flat-square)](https://github.com/ArKuznetsov/jex/releases)
[![GitHub license](https://img.shields.io/github/license/ArKuznetsov/jex.svg?style=flat-square)](https://github.com/ArKuznetsov/jex/blob/develop/LICENSE)
[![GitHub Releases](https://img.shields.io/github/downloads/ArKuznetsov/jex/latest/total?style=flat-square)](https://github.com/ArKuznetsov/jex/releases)
[![GitHub All Releases](https://img.shields.io/github/downloads/ArKuznetsov/jex/total?style=flat-square)](https://github.com/ArKuznetsov/jex/releases)

[![Build Status](https://img.shields.io/github/workflow/status/ArKuznetsov/jex/%D0%9A%D0%BE%D0%BD%D1%82%D1%80%D0%BE%D0%BB%D1%8C%20%D0%BA%D0%B0%D1%87%D0%B5%D1%81%D1%82%D0%B2%D0%B0)](https://github.com/arkuznetsov/jex/actions/)
[![Quality Gate](https://open.checkbsl.org/api/project_badges/measure?project=jex&metric=alert_status)](https://open.checkbsl.org/dashboard/index/jex)
[![Coverage](https://open.checkbsl.org/api/project_badges/measure?project=jex&metric=coverage)](https://open.checkbsl.org/dashboard/index/jex)
[![Tech debt](https://open.checkbsl.org/api/project_badges/measure?project=jex&metric=sqale_index)](https://open.checkbsl.org/dashboard/index/jex)

<a href="https://checkbsl.org"><img alt="Checked by Silver Bulleters SonarQube BSL plugin" src="https://web-files.do.bit-erp.ru/sonar/b_t.png" align="right" style="width:400px"/></a>

# JSON data extraction application (jex)

Приложение для извлечения данных из строк и файлов JSON с помощью запросов JSON-path

* [Зависимости](#Зависимости)
* [Команды приложения](#Приложение)
* [Библиотека](#Библиотека)

## <a id="Зависимости"></a> Требуются следующие библиотеки и инструменты

* [jexlib](https://github.com/ArKuznetsov/jexlib)
* [logos](https://github.com/oscript-library/logos)
* [cli](https://github.com/Stepa86/cli)

## <a id="Приложение"></a> Команды приложения

---

## select - Извлечь данные из строки, файла или входящего потока JSON

| Параметры: ||
|-|-|
| **--data** | - Строка JSON или путь к файлу JSON для извлечения данных |
| **--path** | - Запрос в формате JSON-path |
| **--encoding** | - Кодировка входящих данных (не используется при извлечении данных из строк) (по умолчанию: UTF-8) |

#### Пример

```bat
rem Извлечение данных из строки JSON
jex select --data "{'Ключ':'Значение'}" --path "$.Ключ"
```

```bat
rem Извлечение данных из файла JSON
jex select --data "d:\tmp\MyDataFile.json" --path "$.Ключ" --encoding UTF-8
```

```bat
rem Извлечение данных из потока ввода
echo {"Ключ":"Значение"} | jex select --path "$.Ключ"
```

## <a id="Библиотека"></a> Прграммный интерфейс библиотеки (API)

---

### Модуль ИзвлечениеДанных

#### **Функция Выбрать()** - извлекает данные из JSON-строки, файла или потока по указанному выражению JSON-path

| Параметры: |||
|-|-|-|
| ДанныеJSON | Строка, Поток | JSON-строка, путь к JSON-файлу или поток |
| Путь | Строка | выражение JSON-path для извлечения данных |
| Кодировка | Строка | используемая кодировка данных (не используется при извлечении данных из строк) |
| ИзвлекатьЕдинственноеЗначение | Булево | Если результирующий массив содержит единственное значение, то: Истина -  будет возвращено значение; Ложь - будет возвращен массив. |
| JSONКакТекст | Булево | Истина - если результатом извлечения данных является JSON объект, результат будет возвращен в виде строки JSON;Ложь - результат будет возвращен в виде массива или соответствия |

```bsl
#Использовать jex

СтрокаJSON = "[{""Имя"":""Вася"",""Пол"":""Мужской"",""Возраст"":29},
             |{""Имя"":""Люба"",""Пол"":""Женский"",""Возраст"":30}]";

Результат = ИзвлечениеДанныхJSON.Выбрать(СтрокаJSON, "$..[?(@.Возраст >= 30)].Имя");

```
