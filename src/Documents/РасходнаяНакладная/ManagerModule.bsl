Функция СтруктураПечатныхФорм() Экспорт
	
	ПечатныеФормы = Новый Структура;	 
	ПечатныеФормы.Вставить("ПриходнаяНакладная", "Приходная накладная");	
	
	Возврат ПечатныеФормы; 
	
КонецФункции

Процедура Печать(ТабДок, Ссылка, ИмяМакета) Экспорт
	
	//Макет = Документы.РасходнаяНакладная.ПолучитьМакет("Печать");
	Макет = ПолучитьОбщийМакет("РасходнаяНакладная");
	
	Запрос = Новый Запрос;
	Запрос.Текст =  
	"ВЫБРАТЬ
	|	РасходнаяНакладная.Дата,
	|	РасходнаяНакладная.Номер,
	|	РасходнаяНакладная.Контрагент,
	|	РасходнаяНакладная.Товары.(
	|		НомерСтроки,
	|		Номенклатура,
	|		ЕдИзм,
	|		Количество
	|	)
	|ИЗ
	|	Документ.РасходнаяНакладная КАК РасходнаяНакладная
	|ГДЕ
	|	РасходнаяНакладная.Ссылка В (&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	ОбластьТоварыШапка = Макет.ПолучитьОбласть("ТоварыШапка");
	ОбластьТовары = Макет.ПолучитьОбласть("Товары");
	Подвал = Макет.ПолучитьОбласть("Подвал");

	ТабДок.Очистить();

	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		
		ОбластьЗаголовок.Параметры.Заполнить(Выборка);
		ОбластьЗаголовок.Параметры.Дата = Формат(Выборка.Дата, "ДЛФ=Д");
		
		ТабДок.Вывести(ОбластьЗаголовок);	

		Шапка.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Шапка);

		ТабДок.Вывести(ОбластьТоварыШапка);
		ВыборкаТовары = Выборка.Товары.Выбрать();
		Пока ВыборкаТовары.Следующий() Цикл
			ОбластьТовары.Параметры.Заполнить(ВыборкаТовары);
			ТабДок.Вывести(ОбластьТовары, ВыборкаТовары.Уровень());
		КонецЦикла;

		Подвал.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Подвал);

		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;

КонецПроцедуры
