-- 解答例の写経
-- WITHを多用しなくても解けることが分かった。
SELECT 
    HP.PF_CODE AS 都道府県コード
    , PF.PF_NAME AS 都道府県名
    , ROUND (
        CAST(HP.INP_YES AS REAL) / CAST( (HP.INP_yes + HP.INP_NO + HP.UNDENTIFIED) AS REAL)
    * 100
    , 1
    ) AS 入院率

FROM 
    HOSPITALIZATION AS HP
    INNER JOIN PREFECTURE AS PF
    ON PF.PF_CODE = HP.PF_CODE

ORDER BY 
    入院率 DESC 
    , HP.PF_CODE AS ASC;