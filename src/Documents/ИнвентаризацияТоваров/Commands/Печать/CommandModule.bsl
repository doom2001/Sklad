&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ТабДок = Новый ТабличныйДокумент;
	Печать(ТабДок, ПараметрКоманды);	

	ТабДок.ОтображатьСетку		= Ложь;
	ТабДок.Защита				= Ложь;
	ТабДок.ТолькоПросмотр		= Ложь;
	ТабДок.ОтображатьЗаголовки	= Ложь;
	
	ТабДок.Показать();
	
КонецПроцедуры

&НаСервере
Процедура Печать(ТабДок, ДокСсылка)

	Документы.ПеремещениеТоваров.Печать(ТабДок, ДокСсылка);

КонецПроцедуры