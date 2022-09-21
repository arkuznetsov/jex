#Использовать jexlib

// Функция - извлекает данные из JSON-строки или файла по указанному выражению JSON-path
//
// Параметры:
//  ДанныеJSON      - Строка    - JSON-строка, путь к JSON-файлу или Поток
//                    Поток
//  Путь            - Строка    - выражение JSON-path для извлечения данных
//  Кодировка       - Строка    - используемая кодировка данных
//  JSONКакТекст    - Булево    - Истина - если результатом извлечения данных является JSON объект,
//                                результат будет возвращен в виде строки JSON;
//                                Ложь - результат будет возвращен в виде массива или соответствия
//
// Возвращаемое значение:
//  Строка, Число, Массив, Соответствие    - результат извлечения данных из JSON
//
Функция Выбрать(Знач ДанныеJSON, Знач Путь, Кодировка = "UTF-8", JSONКакТекст = Истина) Экспорт

	ИзвлечениеДанных = Неопределено;

	ТипВходящихДанных = ТипДанных(ДанныеJSON);

	Если ТипВходящихДанных = ТипыВходящихДанных().Строка Тогда
		ИзвлечениеДанных = ИнициализироватьИзвлечениеДанныхИзСтроки(ДанныеJSON);
	ИначеЕсли ТипВходящихДанных = ТипыВходящихДанных().Файл Тогда
		ИзвлечениеДанных = ИнициализироватьИзвлечениеДанныхИзФайла(ДанныеJSON, Кодировка);
	ИначеЕсли ТипВходящихДанных = ТипыВходящихДанных().Поток Тогда
		ИзвлечениеДанных = ИнициализироватьИзвлечениеДанныхИзПотока(ДанныеJSON, Кодировка);
	Иначе
		ТекстОшибки = СтрШаблон("Указанная строка ""%1"", не является строкой JSON, файлом или потоком.", ДанныеJSON);
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;

	Возврат ИзвлечениеДанных.Выбрать(Путь, JSONКакТекст);

КонецФункции // Выбрать()

// Функция - создает объект извлечения данных из JSON и инициализирует его строкой JSON
//
// Параметры:
//  СтрокаJSON      - Строка    - JSON-строка
//
// Возвращаемое значение:
//  ИзвлечениеДанныхJSON    - объект извлечения данных из JSON
//
Функция ИнициализироватьИзвлечениеДанныхИзСтроки(Знач СтрокаJSON)

	СтрокаJSON = СокрЛП(СтрокаJSON);

	ИзвлечениеДанных = Новый ИзвлечениеДанныхJSON();

	Попытка
		ИзвлечениеДанных.УстановитьСтроку(СтрокаJSON);
	Исключение
		ТекстОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ТекстОшибки = СтрШаблон("Ошибка чтения JSON из строки ""%1"":%2%3", СтрокаJSON, Символы.ПС, ТекстОшибки);
		ВызватьИсключение ТекстОшибки;
	КонецПопытки;

	Возврат ИзвлечениеДанных;

КонецФункции // ИнициализироватьИзвлечениеДанныхИзСтроки()

// Функция - создает объект извлечения данных из JSON и инициализирует его данными из файла JSON
//
// Параметры:
//  ПутьКФайлуJSON    - Строка    - путь к файлу JSON
//  Кодировка         - Строка    - используемая кодировка данных
//
// Возвращаемое значение:
//  ИзвлечениеДанныхJSON    - объект извлечения данных из JSON
//
Функция ИнициализироватьИзвлечениеДанныхИзФайла(Знач ПутьКФайлуJSON, Кодировка = "UTF-8")

	ПутьКФайлуJSON = СокрЛП(ПутьКФайлуJSON);

	ИзвлечениеДанных = Новый ИзвлечениеДанныхJSON();

	Попытка
		ИзвлечениеДанных.ОткрытьФайл(ПутьКФайлуJSON, Кодировка);
	Исключение
		ТекстОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ТекстОшибки = СтрШаблон("Ошибка чтения JSON из файла ""%1"":%2%3", ПутьКФайлуJSON, Символы.ПС, ТекстОшибки);
		ВызватьИсключение ТекстОшибки;
	КонецПопытки;

	Возврат ИзвлечениеДанных;

КонецФункции // ИнициализироватьИзвлечениеДанныхИзФайла()

// Функция - создает объект извлечения данных из JSON и инициализирует его данными из потока JSON
//
// Параметры:
//  ПотокJSON    - Строка    - поток данных JSON
//  Кодировка    - Строка    - используемая кодировка данных
//
// Возвращаемое значение:
//  ИзвлечениеДанныхJSON    - объект извлечения данных из JSON
//
Функция ИнициализироватьИзвлечениеДанныхИзПотока(ПотокJSON, Кодировка = "UTF-8")

	ИзвлечениеДанных = Новый ИзвлечениеДанныхJSON();

	Попытка
		ИзвлечениеДанных.ОткрытьПоток(ПотокJSON, Кодировка);
	Исключение
		ТекстОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ТекстОшибки = СтрШаблон("Ошибка чтения JSON из потока ""%1"":%2%3", ТИпЗнч(ПотокJSON), Символы.ПС, ТекстОшибки);
		ВызватьИсключение ТекстОшибки;
	КонецПопытки;

	Возврат ИзвлечениеДанных;

КонецФункции // ИнициализироватьИзвлечениеДанныхИзПотока()

// Функция - возвращает тип переданных данных для извлечения данных JSON
//
// Параметры:
//  ДанныеJSON      - Строка    - JSON-строка, путь к JSON-файлу или Поток
//                    Поток
//
// Возвращаемое значение:
//  Строка    - тип переданных данных (см. ТипыВходящихДанных)
//
Функция ТипДанных(Знач ДанныеJSON)

	ЭтоПоток = ТипЗнч(ДанныеJSON) = Тип("Поток")
	       ИЛИ ТипЗнч(ДанныеJSON) = Тип("ПотокВПамяти")
	       ИЛИ ТипЗнч(ДанныеJSON) = Тип("ФайловыйПоток");

	Если НЕ (ЭтоПоток ИЛИ ТипЗнч(ДанныеJSON) = Тип("Строка")) Тогда
		Возврат Неопределено;
	КонецЕсли;

	ТипДанных = Неопределено;

	Если ЭтоПоток Тогда
		ТипДанных = ТипыВходящихДанных().Поток;
	ИначеЕсли Лев(СокрЛП(ДанныеJSON), 1) = "{"
	      ИЛИ Лев(СокрЛП(ДанныеJSON), 1) = "[" Тогда
		ТипДанных = ТипыВходящихДанных().Строка;
	Иначе
		ФайлДанных = Новый Файл(ДанныеJSON);

		Если ФайлДанных.Существует() Тогда
			ТипДанных = ТипыВходящихДанных().Файл;
		КонецЕсли;
	КонецЕсли;

	Возврат ТипДанных;

КонецФункции // ТипДанных()

// Функция - возвращает возможные типы данных для извлечения данных JSON
//
// Возвращаемое значение:
//  ФиксированнаяСтруктура    - типы возвращаемых данных
//    *Строка    - Строка    - "Строка"
//    *Файл      - Строка    - "Файл"
//    *Поток     - Строка    - "Поток"
//
Функция ТипыВходящихДанных()

	ТипыДанных = Новый Структура();
	ТипыДанных.Вставить("Строка", "Строка");
	ТипыДанных.Вставить("Файл"  , "Файл");
	ТипыДанных.Вставить("Поток" , "Поток");

	Возврат Новый ФиксированнаяСтруктура(ТипыДанных);

КонецФункции // ТипыВходящихДанных()