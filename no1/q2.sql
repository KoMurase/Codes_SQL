WITH TARGET as (
SELECT
    *
FROM 
    SLEEP_TIME_DTL
WHERE
    PF_CODE = "01000" OR PF_CODE = "02000" OR PF_CODE = "03000" OR PF_CODE = "04000" OR PF_CODE = "07000"
    
),
t2 as (
SELECT
    AG.AGE_CODE as 年齢コード,
    sum(TARGET.SP_TIME_5) as ５時間未満,
    sum(TARGET.SP_TIME_6) as ５時間以上６時間未満,
    sum(TARGET.SP_TIME_7) as ６時間以上７時間未満,
    sum(TARGET.SP_TIME_8) as ７時間以上８時間未満,
    sum(TARGET.SP_TIME_9) as ８時間以上９時間未満,
    sum(TARGET.SP_TIME_9OVER) as ９時間以上
FROM TARGET
INNER JOIN
    AGE_GRP as AG
    ON AG.AGE_CODE = TARGET.AGE_CODE
GROUP BY
    年齢コード
)
SELECT
    *
FROM t2
INNER JOIN
    PREFECTURE as PR
    ON PR.PF_CODE = t2.PF_CODE
;