# Каталог доменных событий Будущее 2.0

Каталог описывает доменные события платформы: источник, семантику, подписчиков и минимальный контракт (обязательные поля payload). Все события передаются через Event Bus (Apache Kafka) в формате Avro, версионируются через Schema Registry.

## Регистрация пациента (Patient Registration)

### PatientRegistered

|Поле|Значение|
|----|--------|
|Источник|Patient Registration|
|Агрегат|Patient|
|Семантика|Новый пациент зарегистрирован в системе|
|Подписчики|MedicalCard|

Минимальный контракт (payload):
|Поле|Тип|Описание|
|----|---|--------|
|PatientID|UUID|ID пациента|
|FullName|string|ФИО пациента|
|DateOfBirth|date|Дата рождения|
|ClinicID|UUID|ID клиники приписки|
|MedicalCardID|UUID|ID медкарты|

### PatientUpdated

|Поле|Значение|
|----|--------|
|Источник|Patient Registration|
|Агрегат|Patient|
|Семантика|Данные пациента изменены|
|Подписчики|MedicalCard|

Минимальный контракт (payload):
|Поле|Тип|Описание|
|----|---|--------|
|PatientID|UUID|ID пациента|
|FullName|string|ФИО пациента|
|DateOfBirth|date|Дата рождения|
|ClinicID|UUID|ID клиники приписки|

## Ведение медкарты (MedicalCard Management)

### MedicalCardCreated

|Поле|Значение|
|----|--------|
|Источник|MedicalCard Management|
|Агрегат|MedicalCard|
|Семантика|Медкарта создана|
|Подписчики|Appointment Management|

Минимальный контракт (payload):
|Поле|Тип|Описание|
|----|---|--------|
|MedicalCardID|UUID|ID медкарты|

## Запись пациента на прием (Appointment Management)

### AppointmentCreated

|Поле|Значение|
|----|--------|
|Источник|Appointment Management|
|Агрегат|Appointment|
|Семантика|Создана запись на прием|
|Подписчики||

Минимальный контракт (payload):
|Поле|Тип|Описание|
|----|---|--------|
|MedicalCardID|UUID|ID медкарты|
|Time|Time|Время и дата записи|
|CabinetNo|integer|Номер кабинета|
|DoctorID|UUID|ID врача|
|ClinicID|UUID|ID клиники|

### AppointmentUpdated

|Поле|Значение|
|----|--------|
|Источник|Appointment Management|
|Агрегат|Appointment|
|Семантика|Изменена запись на прием|
|Подписчики||

Минимальный контракт (payload):
|Поле|Тип|Описание|
|----|---|--------|
|MedicalCardID|UUID|ID медкарты|
|Time|Time|Время и дата записи|
|CabinetNo|integer|Номер кабинета|
|DoctorID|UUID|ID врача|
|ClinicID|UUID|ID клиники|


## Постановка диагноза (Diagnose Management)

### DiagnoseAdded

|Поле|Значение|
|----|--------|
|Источник|Diagnose Management|
|Агрегат|Diagnose|
|Семантика|Добавлен диагноз|
|Подписчики|MedicalCard Management|

Минимальный контракт (payload):
|Поле|Тип|Описание|
|----|---|--------|
|MedicalCardID|UUID|ID медкарты|
|DiagnoseID|UUID|ID диагноза|

## Направление на анализы (Test Management)

### TestOrdered

|Поле|Значение|
|----|--------|
|Источник|Test Management|
|Агрегат|Test|
|Семантика|Создано направление на анализы|
|Подписчики||

Минимальный контракт (payload):
|Поле|Тип|Описание|
|----|---|--------|
|MedicalCardID|UUID|ID медкарты|
|TestID|UUID|ID анализов|
|Status|Enum|Статус|

### TestCompleted

|Поле|Значение|
|----|--------|
|Источник|Test Management|
|Агрегат|Test|
|Семантика|Анализы готовы|
|Подписчики||

Минимальный контракт (payload):
|Поле|Тип|Описание|
|----|---|--------|
|MedicalCardID|UUID|ID медкарты|
|TestID|UUID|ID анализов|
|Status|Enum|Статус|
|TestResultID|UUID|ID результатов анализов|


### TestResultAdded

|Поле|Значение|
|----|--------|
|Источник|Test Management|
|Агрегат|Test|
|Семантика|В медкарту добавлены результаты анализов|
|Подписчики|MedicalCard Management|

Минимальный контракт (payload):
|Поле|Тип|Описание|
|----|---|--------|
|MedicalCardID|UUID|ID медкарты|
|TestResultID|UUID|ID результатов анализов|

## Назначение на лечение (Prescription Management)

### PrescriptionAdded

|Поле|Значение|
|----|--------|
|Источник|Prescription Management|
|Агрегат|Prescription|
|Семантика|В медкарту добавлено назначение на лечение|
|Подписчики|MedicalCard Management|

Минимальный контракт (payload):
|Поле|Тип|Описание|
|----|---|--------|
|MedicalCardID|UUID|ID медкарты|
|PrescriptionID|UUID|ID назначения на лечение|

## Управление счетами за услуги (Bill Management)

### BillCreated

|Поле|Значение|
|----|--------|
|Источник|Bill Management|
|Агрегат|Bill|
|Семантика|Создан счет на оплату услуги|
|Подписчики|Payment Management|

Минимальный контракт (payload):
|Поле|Тип|Описание|
|----|---|--------|
|BillID|UUID|ID счета|
|PatientID|UUID|ID пациента|
|DoctorID|UUID|ID врача|
|ServiceID|UUID|ID услуги|
|ClinicID|UUID|ID клиники|
|Date|date|Дата|

## Управление платежами (Payment Management)

### PaymentReceived

|Поле|Значение|
|----|--------|
|Источник|Payment Management|
|Агрегат|Payment|
|Семантика|Создан счет на оплату услуги|
|Подписчики||

Минимальный контракт (payload):
|Поле|Тип|Описание|
|----|---|--------|
|PaymentID|UUID|ID оплаты|
|BillID|UUID|ID счета|
|PaymentTypeID|UUID|ID способа оплаты|
|Date|date|Дата|

## Управление оформлением кредитов (Credit Management)

### CreditApproved

|Поле|Значение|
|----|--------|
|Источник|Credit Management|
|Агрегат|Credit|
|Семантика|Кредит одобрен|
|Подписчики||

Минимальный контракт (payload):
|Поле|Тип|Описание|
|----|---|--------|
|CreditID|UUID|ID заявки на кредит|
|BillID|UUID|ID счета|
|Status|Enum|Статус|
|Date|date|Дата|

### CreditRejected

|Поле|Значение|
|----|--------|
|Источник|Credit Management|
|Агрегат|Credit|
|Семантика|Кредит отклонен|
|Подписчики||

Минимальный контракт (payload):
|Поле|Тип|Описание|
|----|---|--------|
|CreditID|UUID|ID заявки на кредит|
|BillID|UUID|ID счета|
|Status|Enum|Статус|
|Date|date|Дата|

### CreditIssued

|Поле|Значение|
|----|--------|
|Источник|Credit Management|
|Агрегат|Credit|
|Семантика|Кредит выдан|
|Подписчики||

Минимальный контракт (payload):
|Поле|Тип|Описание|
|----|---|--------|
|CreditID|UUID|ID заявки на кредит|
|BillID|UUID|ID счета|
|Status|Enum|Статус|
|Date|date|Дата|