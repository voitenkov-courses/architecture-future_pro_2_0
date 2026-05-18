# Агрегаты Будущее 2.0

Описание ключевых агрегатов по каждому Bounded Context: корень, границы, инварианты, идентификатор, публикуемые события.

## Регистрация пациента

Агрегат: Пациент (Patient)
|Поле|Значение|
|----|--------|
|Корень|Patient|
|Идентификатор|PatientID: UUID|
|Объекты-значения|MedicalCardRef|
|Публикуемые события|PatientRegistered, PatientUpdated|

Инварианты:
- У пациента обязательны ФИО и дата рождения.
- Пациент привязан ровно к одной клинике при регистрации.

## Ведение медкарты

Агрегат: Медкарта (MedicalCard)
|Поле|Значение|
|----|--------|
|Корень|MedicalCard|
|Идентификатор|MedicalCardID: UUID|
|Объекты-значения|DiagnoseRef, PrescriptionRef, TestRef|
|Публикуемые события: MedicalCardCreated| 

Инварианты:
- Медкарта создается для зарегистрированного пациента.

## Запись пациента на прием

Агрегат: Запись на прием (Appointment)
|Поле|Значение|
|----|--------|
|Корень|Appointment|
|Идентификатор|AppointmentID: UUID|
|Объекты-значения|AppointmentTime, CabinetNo, DoctorRef, ClinicRef|
|Публикуемые события: AppointmentCreated, AppointmentUpdated, AppointmentDeleted|

Инварианты:
- На прием записывается пациент с оформленной медкартой.

## Постановка диагноза

Агрегат: Диагноз (Diagnose)
|Поле|Значение|
|----|--------|
|Корень|Diagnose|
|Идентификатор|DiagnoseID: UUID|
|Объекты-значения|DoctorRef, MedicalCardRef, DiagnoseDescription, DeseaseID|
|Публикуемые события: DiagnoseAdded, DiagnoseUpdated|

Инварианты:
- Диагноз ставится пациенту, записанному на прием.
- Если есть направление на анализы, диагноз ставится после получения результатов.

## Направление на анализы

Агрегат: Анализ (Test)
|Поле|Значение|
|----|--------|
|Корень|Test|
|Идентификатор|TestID: UUID|
|Объекты-значения|DoctorRef, MedicalCardRef, TestResult|
|Публикуемые события: TestOrdered, TestCompleted, TestResultAdded|

Инварианты:
- Направление на анализы создается для пациента, записанного на прием.

## Назначение на лечение

Агрегат: Назначение (Prescription)
|Поле|Значение|
|----|--------|
|Корень|Prescription|
|Идентификатор|PrescriptionID: UUID|
|Объекты-значения|DoctorRef, MedicalCardRef, PrescriptionDescription|
|Публикуемые события: PrescriptionAdded, PrescriptionUpdated|

Инварианты:
- Лечение назначается пациентам с поставленным диагнозом.

## Управление аналитическими витринами

Агрегат: Витрина (DataMart)
|Поле|Значение|
|----|--------|
|Корень|DataMart|
|Идентификатор|DataMartID: UUID|
|Объекты-значения|DataMartDefinition|
|Публикуемые события: DataMartCreated, DatamartUpdated, DatamartDeleted|

## Управление счетами за услуги

Агрегат: Счет (Bill)
|Поле|Значение|
|----|--------|
|Корень|Bill|
|Идентификатор|BillID: UUID|
|Объекты-значения|BillSum, ServiceRef, PatientRef, DoctorRef, Date, ClinicRef|
|Публикуемые события: BillCreated|


## Управление оплатами услуг
Агрегат: Оплата (Payment)
|Поле|Значение|
|----|--------|
|Корень|Payment|
|Идентификатор|PaymentID: UUID|
|Объекты-значения|BillRef, PaymentTypeRef|
|Публикуемые события: PaymentReceived|

Инварианты:
- Прием должен быть оплачен после назначения лечения

## Управление оформлением кредитов
Агрегат: Кредит (Credit)
|Поле|Значение|
|----|--------|
|Корень|Credit|
|Идентификатор|CreditID: UUID|
|Объекты-значения|BillRef|
|Публикуемые события: CreditApproved, CreditRejected, CreditIssued, CreditClosed|

Инварианты:
- Кредит оформляется только на оформленные услуги.
- Сумма кредита не может быть больше стоимости всех неоплаченных услуг.
- Кредит не может быть оформлен без получения подтверждения.

## Управление финансовыми операциями
Агрегат: Финансовая операция (FinOperation)
|Поле|Значение|
|----|--------|
|Корень|FinOperation|
|Идентификатор|FinOperationID: UUID|
|Объекты-значения|OperationSum, OperationType, Date, Employee|
|Публикуемые события: OperationApproved, OperationRejected, OperationCreated|

Инварианты:
- Операция не может быть проведена без получения подтверждения.

## Управление клиниками
Агрегат: Хозяйственная операция (InvOperation)
|Поле|Значение|
|----|--------|
|Корень|InvOperation|
|Идентификатор|InvOperationID: UUID|
|Объекты-значения|Quantity, OperationType, Date, Employee, ClinicRef, ItemRef|
|Публикуемые события: OperationApproved, OperationRejected, OperationCreated|

Инварианты:
- Операция не может быть проведена без получения подтверждения.