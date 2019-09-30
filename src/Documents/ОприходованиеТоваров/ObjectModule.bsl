 
 //***************************************************************************************************

Процедура ОбработкаПроведения(Отказ, Режим)

	// регистр ОстаткиТоваров Приход
	Движения.ОстаткиТоваров.Записывать = Истина;
	Для Каждого ТекСтрокаТовары Из Товары Цикл
		Движение 				= Движения.ОстаткиТоваров.Добавить();
		Движение.ВидДвижения 	= ВидДвиженияНакопления.Приход;
		Движение.Период 		= Дата;
		Движение.Склад 			= Склад;
		Движение.Номенклатура 	= ТекСтрокаТовары.Номенклатура;		
		Движение.Количество 	= ТекСтрокаТовары.Количество;
		Движение.ЕдИзм			= ТекСтрокаТовары.ЕдИзм;
	КонецЦикла;
	//=================================

КонецПроцедуры


Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ИнвентаризацияТоваров") Тогда
		// Заполнение шапки
		ВидОперации	= ДанныеЗаполнения.ВидОперации;
		Комментарий	= ДанныеЗаполнения.Комментарий;		
		Склад		= ДанныеЗаполнения.Склад;
		
		// Заполнение табличной части
		Для Каждого ТекСтрокаТовары Из ДанныеЗаполнения.Товары Цикл
			
			Кво = ТекСтрокаТовары.Количество - ТекСтрокаТовары.КоличествоУчет;
			Если Кво > 0 Тогда
				НоваяСтрока = Товары.Добавить();
				НоваяСтрока.ЕдИзм		 = ТекСтрокаТовары.ЕдИзм;
				НоваяСтрока.Количество	 = Кво;
				НоваяСтрока.Номенклатура = ТекСтрокаТовары.Номенклатура;				
			КонецЕсли;
		
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры
