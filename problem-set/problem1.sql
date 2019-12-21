/*
health_us_2019
--
Year
StateAbbr
StateDesc
CityName
GeographicLevel
DataSource
Category
UniqueID
Measure
Data_Value_Unit
DataValueTypeID
Data_Value_Type
Data_Value
Low_Confidence_Limit
High_Confidence_Limit
Data_Value_Footnote_Symbol
Data_Value_Footnote
PopulationCount
GeoLocation
CategoryID
MeasureId
CityFIPS
TractFIPS
Short_Question_Text
*/

ALTER TABLE `medical`.`health_us_2019`
ADD INDEX `health_us_2019_Measure_index`(`Measure`) USING BTREE;

describe health_us_2019

select * from health_us_2019 limit 1

select
distinct StateAbbr, StateDesc
from health_us_2019

select
distinct GeographicLevel
from health_us_2019

select
distinct Measure, MeasureId, Category, CategoryID
from health_us_2019

select *
from health_us_2019
where StateAbbr = 'TX'
and MeasureId = 'CHD'

select
    chd.StateAbbr,
    chd.StateDesc,
    chd.CityName,
    chd.CityFIPS,
    chd.Data_Value as chd_value,
    chd.Data_Value_Unit as chd_unit,
    lpa.Data_Value as lpa_value,
    lpa.Data_Value_Unit as lpa_unit
from (
    select *
    from health_us_2019
    where StateAbbr = 'TX'
    and GeographicLevel = 'City'
    and MeasureId = 'CHD'
    and DataValueTypeID = 'AgeAdjPrv'
) as chd
join (
    select *
    from health_us_2019
    where StateAbbr = 'TX'
    and GeographicLevel = 'City'
    and MeasureId = 'LPA'
    and DataValueTypeID = 'AgeAdjPrv'
) as lpa
on chd.CityFIPS = lpa.CityFIPS
