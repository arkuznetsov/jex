# JSON data extraction application (jex)

[![GitHub release](https://img.shields.io/github/release/ArKuznetsov/jex.svg?style=flat-square)](https://github.com/ArKuznetsov/jex/releases)
[![GitHub license](https://img.shields.io/github/license/ArKuznetsov/jex.svg?style=flat-square)](https://github.com/ArKuznetsov/jex/blob/develop/LICENSE)
[![GitHub Releases](https://img.shields.io/github/downloads/ArKuznetsov/jex/latest/total?style=flat-square)](https://github.com/ArKuznetsov/jex/releases)
[![GitHub All Releases](https://img.shields.io/github/downloads/ArKuznetsov/jex/total?style=flat-square)](https://github.com/ArKuznetsov/jex/releases)

[![Build Status](https://img.shields.io/github/workflow/status/ArKuznetsov/jex/%D0%9A%D0%BE%D0%BD%D1%82%D1%80%D0%BE%D0%BB%D1%8C%20%D0%BA%D0%B0%D1%87%D0%B5%D1%81%D1%82%D0%B2%D0%B0)](https://github.com/arkuznetsov/jex/actions/)
[![Quality Gate](https://open.checkbsl.org/api/project_badges/measure?project=jex&metric=alert_status)](https://open.checkbsl.org/dashboard/index/jex)
[![Coverage](https://open.checkbsl.org/api/project_badges/measure?project=jex&metric=coverage)](https://open.checkbsl.org/dashboard/index/jex)
[![Tech debt](https://open.checkbsl.org/api/project_badges/measure?project=jex&metric=sqale_index)](https://open.checkbsl.org/dashboard/index/jex)

Приложение для извлечения данных из строк и файлов JSON с помощью запросов JSON-path

* [Зависимости](#Зависимости)
* [Команды приложения](#Приложение)

## <a id="Зависимости"></a> Требуются следующие библиотеки и инструменты:
- [jexlib](https://github.com/ArKuznetsov/jexlib)
- [logos](https://github.com/oscript-library/logos)
- [cli](https://github.com/Stepa86/cli)

## <a id="Приложение"></a> Команды приложения
---

## select - Извлечь данные из строки или файла JSON

| Параметры: ||
|-|-|
| **--data** | - Строка JSON или путь к файлу JSON для извлечения данных |
| **--path** | - Запрос в формате JSON-path |

#### Пример:

```bat
jex select --data "{""Ключ"":""Значение""}" --path "$.Ключ"
```

```bat
jex select --data "d:\tmp\MyDataFile.json" --path "$.Ключ"
```
