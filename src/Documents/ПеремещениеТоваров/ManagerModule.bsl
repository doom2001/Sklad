Процедура Печать(ТабДок, Ссылка) Экспорт
	
	Макет = Документы.ПеремещениеТоваров.ПолучитьМакет("НакладнаяНаПеремещение");
	
	ОбластьШапкаДок = Макет.ПолучитьОбласть("ШапкаДок");
	ОбластьШапкаТаб = Макет.ПолучитьОбласть("ШапкаТаб");
	ОбластьПодвал	= Макет.ПолучитьОбласть("Подвал"); 	
	
	ЗапросШапка = Новый Запрос;
	ЗапросШапка.Текст = "ВЫБРАТЬ
	|	ПеремещениеТоваров.Номер,
	|	ПеремещениеТоваров.Дата,
	|	ПеремещениеТоваров.СкладОтправитель,
	|	ПеремещениеТоваров.СкладПолучатель
	|ИЗ
	|	Документ.ПеремещениеТоваров КАК ПеремещениеТоваров";
	ЗапросШапка.УстановитьПараметр("Ссылка", Ссылка);	
	ДанныеШапки = ЗапросШапка.Выполнить().Выбрать();	
	ДанныеШапки.Следующий(); 	
	
	ОбластьШапкаДок.Параметры.Заполнить(ДанныеШапки);
	ТабДок.Вывести(ОбластьШапкаДок);
		
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
	ДанныеТЧ = ЗапросТовары.Выполнить().Выбрать();
	
	Пока ДанныеТЧ.Следующий() Цикл
		
		ОбластьСтрокаТЧ = Макет.ПолучитьОбласть("СтрокаТаб");		
		ОбластьСтрокаТЧ.Параметры.Заполнить(ДанныеТЧ);
		ТабДок.Вывести(ОбластьСтрокаТЧ);
				
	КонецЦикла;

	ТабДок.Вывести(ОбластьПодвал);		
	
КонецПроцедуры