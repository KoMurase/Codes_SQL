WITH d_2015 as (
select SURVEY_YEAR, PF_CODE, TOTAL_AMT
from POPU_TRANSITION
where SURVEY_YEAR = 2015
),
d_2020 as (
select SURVEY_YEAR, PF_CODE, TOTAL_AMT
from POPU_TRANSITION
where SURVEY_YEAR = 2020
),
result as (
select 
       d_2020.PF_CODE,
       CAST(d_2015.TOTAL_AMT as REAL) as amt_2015,
       CAST(d_2020.TOTAL_AMT as REAL) as amt_2020,
       ROUND( CAST(d_2020.TOTAL_AMT as REAL) / CAST(d_2015.TOTAL_AMT as REAL)* 100 )  as ratio
from d_2015
inner join d_2020
on d_2015.PF_CODE = d_2020.PF_CODE
)
select 
    result.PF_CODE 都道府県コード,
    PREFECTURE.PF_NAME 都道府県名,
    result.amt_2015 総人口2015年,
    result.amt_2020 総人口2020年,
    result.ratio 人口増加率
from result
inner join PREFECTURE
on result.PF_CODE = PREFECTURE.PF_CODE
where result.ratio > 100
order by result.ratio desc,
result.PF_CODE asc
;