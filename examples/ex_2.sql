WITH calc_ratio AS (
select PF_CODE, INP_YES, INP_NO, UNIDENTIFIED,
    ROUND(
    CAST(INP_YES as REAL) / CAST((INP_YES+INP_NO+UNIDENTIFIED) as REAL
    ) * 100, 1) as ratio
from HOSPITALIZATION
),
pr as(
select PF_CODE, PF_NAME
from PREFECTURE
)
select
calc_ratio.PF_CODE 都道府県コード,
--pr.PF_CODE,
pr.PF_NAME as 都道府県名,
calc_ratio.ratio as 入院率
from calc_ratio
inner join pr
on calc_ratio.PF_CODE = pr.PF_CODE
order by
    入院率 DESC
    , pr.PF_CODE ASC;
;