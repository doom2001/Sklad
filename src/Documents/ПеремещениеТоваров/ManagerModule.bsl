Функция СтруктураПечатныхФорм() Экспорт
	
	ПечатныеФормы = Новый Структура;
	ПечатныеФормы.Вставить("НакладнаяНаПеремещение", "Накладная на перемещение");
	ПечатныеФормы.Вставить("РасходнаяНакладная", "Расходная накладная"); 
	ПечатныеФормы.Вставить("ПриходнаяНакладная", "Приходная накладная");	
	
	Возврат ПечатныеФормы; 
	
КонецФункции


Функция СобратьДанныеДляПечати(Ссылка) Экспорт
	
	ДанныеДляПечати = Новый Структура;			
	
	ЗапросШапка = Новый Запрос;
	ЗапросШапка.Текст = "ВЫБРАТЬ
	|	ПеремещениеТоваров.Номер,
	|	ПеремещениеТоваров.Дата,
	|	ПРЕДСТАВЛЕНИЕ(ПеремещениеТоваров.СкладОтправитель) КАК СкладОтправитель,
	|	ПРЕДСТАВЛЕНИЕ(ПеремещениеТоваров.СкладПолучатель) КАК СкладПолучатель
	|ИЗ
	|	Документ.ПеремещениеТоваров КАК ПеремещениеТоваров";
	ЗапросШапка.УстановитьПараметр("Ссылка", Ссылка);	
	ДанныеШапки = ЗапросШапка.Выполнить().Выбрать();	
	ДанныеШапки.Следующий();
		
	СтруктураШапки = Новый Структура;
	СтруктураШапки.Вставить("Номер"				, Формат(ДанныеШапки.Номер, "ЧГ=;"));
	СтруктураШапки.Вставить("Дата"				, Формат(ДанныеШапки.Дата, "ДЛФ=Д"));
	СтруктураШапки.Вставить("СкладОтправитель"	, ДанныеШапки.СкладОтправитель);
	СтруктураШапки.Вставить("СкладПолучатель"	, ДанныеШапки.СкладПолучатель);	
	
	ЗапросТовары = Новый Запрос;
	ЗапросТовары.Текст = "ВЫБРАТЬ
	|	ПеремещениеТоваровТовары.НомерСтроки,
	|	ПеремещениеТоваровТовары.Номенклатура,
	|	ПеремещениеТоваровТовары.ЕдиницаИзмерения КАК ЕдИзм,
	|	ПеремещениеТоваровТовары.Количество
	|ИЗ
	|	Документ.ПеремещениеТоваров.Товары КАК ПеремещениеТоваровТовары
	|ГДЕ
	|	ПеремещениеТоваровТовары.Ссылка = &Ссылка";
	ЗапросТовары.УстановитьПараметр("Ссылка", Ссылка);
	ДанныеТЧ = ЗапросТовары.Выполнить().Выгрузить();

	ДанныеДляПечати.Вставить("СтруктураШапки", ДанныеШапки);
	ДанныеДляПечати.Вставить("ТаблицаТовары" , ДанныеТЧ);
	
	Возврат ДанныеДляПечати;
	
КонецФункции

Процедура ПечатьНакладнаяНаПеремещение(ТабДок, Ссылка)
	
	ДанныеДляПечати = СобратьДанныеДляПечати(Ссылка);	
		
	Макет = Документы.ПеремещениеТоваров.ПолучитьМакет("НакладнаяНаПеремещение");
	
	ОбластьШапкаДок = Макет.ПолучитьОбласть("ШапкаДок");
	ОбластьШапкаТаб = Макет.ПолучитьОбласть("ШапкаТаб");
	ОбластьПодвал	= Макет.ПолучитьОбласть("Подвал"); 	
	 	
	
	ОбластьШапкаДок.Параметры.Заполнить(ДанныеДляПечати.СтруктураШапки);
	
	ТабДок.Вывести(ОбластьШапкаДок);
	ТабДок.Вывести(ОбластьШапкаТаб);	
	
	Для Каждого СтрокаТЧ Из ДанныеДляПечати.ТаблицаТовары Цикл
		
		ОбластьСтрокаТЧ = Макет.ПолучитьОбласть("СтрокаТаб");		
		ОбластьСтрокаТЧ.Параметры.Заполнить(СтрокаТЧ);
		ТабДок.Вывести(ОбластьСтрокаТЧ);
				
	КонецЦикла;

	ТабДок.Вывести(ОбластьПодвал);
	
КонецПроцедуры

Процедура ПечатьПриходнаяНакладная(ТабДок, Ссылка)
	
	ДанныеДляПечати = СобратьДанныеДляПечати(Ссылка);	
		
	Макет = ПолучитьОбщийМакет("ПриходнаяНакладная");
	
	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	ОбластьШапкаДок	 = Макет.ПолучитьОбласть("Шапка");
	ОбластьШапкаТаб  = Макет.ПолучитьОбласть("ТоварыШапка");	
	ОбластьПодвал	 = Макет.ПолучитьОбласть("Подвал");  	
	 	
	ОбластьЗаголовок.Параметры.Заполнить(ДанныеДляПечати.СтруктураШапки);
	
	ТабДок.Вывести(ОбластьЗаголовок);
	ТабДок.Вывести(ОбластьШапкаДок);
	ТабДок.Вывести(ОбластьШапкаТаб);	
	
	Для Каждого СтрокаТЧ Из ДанныеДляПечати.ТаблицаТовары Цикл
		
		ОбластьСтрокаТЧ = Макет.ПолучитьОбласть("Товары");		
		ОбластьСтрокаТЧ.Параметры.Заполнить(СтрокаТЧ);
		ТабДок.Вывести(ОбластьСтрокаТЧ);
				
	КонецЦикла;

	ТабДок.Вывести(ОбластьПодвал);
	
КонецПроцедуры

Процедура ПечатьРасходнаяНакладная(ТабДок, Ссылка)
	
	ДанныеДляПечати = СобратьДанныеДляПечати(Ссылка);	
		
	Макет = ПолучитьОбщийМакет("РасходнаяНакладная");

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	ОбластьШапкаДок	 = Макет.ПолучитьОбласть("Шапка");
	ОбластьШапкаТаб  = Макет.ПолучитьОбласть("ТоварыШапка");	
	ОбластьПодвал	 = Макет.ПолучитьОбласть("Подвал"); 	
	 	
	ОбластьЗаголовок.Параметры.Заполнить(ДанныеДляПечати.СтруктураШапки);
	
	ТабДок.Вывести(ОбластьЗаголовок);
	ТабДок.Вывести(ОбластьШапкаДок);
	ТабДок.Вывести(ОбластьШапкаТаб);	
	
	Для Каждого СтрокаТЧ Из ДанныеДляПечати.ТаблицаТовары Цикл
		
		ОбластьСтрокаТЧ = Макет.ПолучитьОбласть("Товары");		
		ОбластьСтрокаТЧ.Параметры.Заполнить(СтрокаТЧ);
		ТабДок.Вывести(ОбластьСтрокаТЧ);
				
	КонецЦикла;

	ТабДок.Вывести(ОбластьПодвал);
	
КонецПроцедуры

Процедура Печать(ТабДок, Ссылка, ИмяМакета) Экспорт
	
	Если ИмяМакета = "НакладнаяНаПеремещение" Тогда
		
		ПечатьНакладнаяНаПеремещение(ТабДок, Ссылка);
		
	ИначеЕсли ИмяМакета = "РасходнаяНакладная" Тогда
		 
		 ПечатьРасходнаяНакладная(ТабДок, Ссылка);

	ИначеЕсли ИмяМакета = "ПриходнаяНакладная" Тогда
	
		ПечатьПриходнаяНакладная(ТабДок, Ссылка);
		
	КонецЕсли;		
	
КонецПроцедуры