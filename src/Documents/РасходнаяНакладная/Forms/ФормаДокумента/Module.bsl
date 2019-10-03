&НаКлиенте
Процедура ТоварыНоменклатураПриИзменении(Элемент)
	
	СтрокаТабличнойЧасти 			= Элементы.Товары.ТекущиеДанные;
	СтрокаТабличнойЧасти.ЕдИзм		= РаботаСоСправочниками.УстановкаЕдИзм(СтрокаТабличнойЧасти.Номенклатура);
		
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	 
	 Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
	 	 Объект.Склад = Справочники.Склады.Основной;
	     Объект.Ответственный = ПараметрыСеанса.ТекущийПользователь;
	 КонецЕсли;	  
		  
КонецПроцедуры

// отрабатываем подбор
&НаКлиенте
Процедура Подбор(Команда)
			
	ПараметрыФормы = Новый Структура ("Склад", Объект.Склад);
		
	ОткрытьФорму("Справочник.Номенклатура.Форма.ФормаПодбора", 
			ПараметрыФормы, 
			,
			,
			,
			,
			Новый ОписаниеОповещения("ОбработатьРезультатПодбора", ЭтотОбъект));
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьРезультатПодбора(ПараметрЗакрытия, Парам2) Экспорт
	
	Если ПараметрЗакрытия <> Неопределено Тогда	
		
		ОбработатьПодборНаСервере(ПараметрЗакрытия);
		
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Процедура ОбработатьПодборНаСервере(АдресВХранилище)
			
	Таблица = ПолучитьИзВременногоХранилища(АдресВХранилище);
	Для Каждого СтрокаТаблицы Из Таблица Цикл
		
		МассивСтрок = Объект.Товары.НайтиСтроки(Новый Структура("Номенклатура", СтрокаТаблицы.Номенклатура));
		
		Если МассивСтрок.Количество() = 0 Тогда
			НоваяСтрока = Объект.Товары.Добавить();
			НоваяСтрока.Номенклатура = СтрокаТаблицы.Номенклатура;
			НоваяСтрока.ЕдИзм = СтрокаТаблицы.Номенклатура.ЕдИзм; 
			НоваяСтрока.Количество = СтрокаТаблицы.Количество; 						
		Иначе
			Строка = МассивСтрок[0];			
			Строка.Количество = Строка.Количество + СтрокаТаблицы.Количество;			
		КонецЕсли;
		
	КонецЦикла;		
	
КонецПроцедуры	
       
&НаКлиенте
 Процедура ТоварыОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Сч = проверкаНаличия(ВыбранноеЗначение);
	
	Если Сч = 0 Тогда
		 Элементы.Товары.ДобавитьСтроку();
		 Элементы.Товары.ТекущиеДанные.Номенклатура = ВыбранноеЗначение;
		 ЗаполнитьДанные(Элементы.Товары.ТекущиеДанные.Номенклатура, Элементы.Товары.ТекущиеДанные.НомерСтроки);
	КонецЕсли;
	
 КонецПроцедуры

//отрабатываем подбор
&НаСервере
Функция проверкаНаличия(ВыбранноеЗначение)	
	
	Сч = 0;
	Для каждого Строч Из Объект.Товары Цикл
		 Если Строч.Номенклатура 	= ВыбранноеЗначение тогда
			 Строч.Количество 		= Строч.Количество + 1;// Если товар уже есть - то просто приплюсуем его;
			 Сч = 1;
		 КонецЕсли;
	КонецЦикла;
	
	Возврат Сч;
	
КонецФункции	

// отрабатываем подбор

&НаСервере
Процедура ЗаполнитьДанные(товар, строка)
		
	Для каждого строч из Объект.Товары Цикл
		Если Строч.НомерСтроки = Строка Тогда			
			Строч.ЕдИзм				= Товар.ЕдИзм;
			Строч.Количество		= 1;
		КонецЕсли;		
	КонецЦикла;
	
КонецПроцедуры
	
	

   
  





 
 
	