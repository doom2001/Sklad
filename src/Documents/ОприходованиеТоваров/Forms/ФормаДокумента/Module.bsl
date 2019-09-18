
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

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	СтрокаТабличнойЧасти 		= Элементы.Товары.ТекущиеДанные;

КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	СтрокаТабличнойЧасти 		= Элементы.Товары.ТекущиеДанные;

КонецПроцедуры

&НаКлиенте
Процедура НоваяСтрока(Команда)
	СтрокаТабличнойЧасти 		= Элементы.Товары.ТекущиеДанные;
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПослеУдаления(Элемент)
 КонецПроцедуры
 
 // отрабатываем подбор
&НаКлиенте
Процедура Подбор(Команда)
	ПараметрыФормы = Новый Структура ("ЗакрыватьПриВыборе", Истина);
	ОткрытьФорму("Справочник.Номенклатура.ФормаВыбора", ПараметрыФормы, Элементы.Товары);
 КонецПроцедуры
           // отрабатываем подбор
&НаКлиенте
Процедура ТоварыОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	Сч 		=  проверкаНаличия(ВыбранноеЗначение);
	 
	 Если Сч = 0 Тогда
		 Элементы.Товары.ДобавитьСтроку();
		 Элементы.Товары.ТекущиеДанные.Номенклатура = ВыбранноеЗначение;
		 ЗаполнитьДанные(Элементы.Товары.ТекущиеДанные.Номенклатура, Элементы.Товары.ТекущиеДанные.НомерСтроки);
	 КонецЕсли
 КонецПроцедуры
         // отрабатываем подбор
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
Процедура  ЗаполнитьДанные(товар, строка)
	
	Для каждого строч из Объект.Товары Цикл
		Если Строч.НомерСтроки = Строка Тогда
			
			Строч.ЕдИзм				= Товар.ЕдИзм;
			Строч.Количество		= 1;
			
		КонецЕсли;
		
	КонецЦикла;
	
	КонецПроцедуры

 &НаСервере
 Функция РольПользователя(Роль)
	 
	 Возврат	РольДоступна(Роль);
	 
 КонецФункции
   
   
  
 

	