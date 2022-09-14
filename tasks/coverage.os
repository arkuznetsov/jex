#Использовать 1commands
#Использовать asserts
#Использовать fs
#Использовать json

СистемнаяИнформация = Новый СистемнаяИнформация;
ЭтоWindows = Найти(НРег(СистемнаяИнформация.ВерсияОС), "windows") > 0;

КаталогРезультатов = "build/reports";

ФС.ОбеспечитьКаталог(КаталогРезультатов);
ПутьКСтат = ОбъединитьПути(КаталогРезультатов, "stat.json");

Команда = Новый Команда;
Команда.УстановитьКоманду("oscript");
Если НЕ ЭтоWindows Тогда
	Команда.ДобавитьПараметр("-encoding=utf-8");
КонецЕсли;
Команда.ДобавитьПараметр(СтрШаблон("-codestat=%1", ПутьКСтат));    
Команда.ДобавитьПараметр("tasks/test.os");
Команда.ПоказыватьВыводНемедленно(Истина);

КодВозврата = Команда.Исполнить();

Файл_Стат = Новый Файл(ПутьКСтат);
Ожидаем.Что(Файл_Стат.Существует(), СтрШаблон("Файл <%1> с результатами покрытия не существует!", Файл_Стат.ПолноеИмя)).ЭтоИстина();

ЧтениеТекста = Новый ЧтениеТекста(ПутьКСтат, КодировкаТекста.UTF8);

СтрокаJSON = ЧтениеТекста.Прочитать();
ЧтениеТекста.Закрыть();

Парсер = Новый ПарсерJSON();
ДанныеПокрытия = Парсер.ПрочитатьJSON(СтрокаJSON);

ЗаписьXML = Новый ЗаписьXML;
ЗаписьXML.ОткрытьФайл(ОбъединитьПути(КаталогРезультатов, "genericCoverage.xml"));
ЗаписьXML.ЗаписатьОбъявлениеXML();
ЗаписьXML.ЗаписатьНачалоЭлемента("coverage");
ЗаписьXML.ЗаписатьАтрибут("version", "1");

Для Каждого Файл Из ДанныеПокрытия Цикл
	
	ДанныеФайла = Файл.Значение;
	
	ЗаписьXML.ЗаписатьНачалоЭлемента("file");
	ЗаписьXML.ЗаписатьАтрибут("path", ДанныеФайла.Получить("#path"));
	
	Для Каждого КлючИЗначение Из ДанныеФайла Цикл
		
		Если КлючИЗначение.Ключ = "#path" Тогда
			Продолжить;
		КонецЕсли;
		
		ДанныеПроцедуры = КлючИЗначение.Значение;
		Для Каждого ДанныеСтроки Из ДанныеПроцедуры Цикл
			
			ЗаписьXML.ЗаписатьНачалоЭлемента("lineToCover");
			
			ЗаписьXML.ЗаписатьАтрибут("lineNumber", ДанныеСтроки.Ключ);
			Покрыто = Число(ДанныеСтроки.Значение.Получить("count")) > 0;
			ЗаписьXML.ЗаписатьАтрибут("covered", Формат(Покрыто, "БИ=true; БЛ=false"));
			
			ЗаписьXML.ЗаписатьКонецЭлемента(); // lineToCover
		КонецЦикла;
	КонецЦикла;
	
	ЗаписьXML.ЗаписатьКонецЭлемента(); // file
	
КонецЦикла;

ЗаписьXML.ЗаписатьКонецЭлемента(); // coverage
ЗаписьXML.Закрыть();

ЗавершитьРаботу(КодВозврата);