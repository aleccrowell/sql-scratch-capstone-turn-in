{\rtf1\ansi\ansicpg1252\cocoartf1671
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 select * from survey limit 10;\
 \
 select count(DISTINCT user_id) from survey;\
 \
 select question, count(DISTINCT user_id) from survey group by 1;\
 \
 select * from quiz limit 5;\
 \
 select * from home_try_on limit 5;\
 \
 select * from purchase limit 5;\
 \
WITH temp_join as \
(select quiz.user_id, (hto.user_id is not null) as home_try_on, hto.number_of_pairs from quiz left join home_try_on as hto on quiz.user_id = hto.user_id)\
select temp_join.user_id as user_id, temp_join.home_try_on as home_try_on, temp_join.number_of_pairs as number_of_pairs, (purchase.user_id is not null) as is_purchase from temp_join left join purchase on temp_join.user_id = purchase.user_id limit 10;\
 \
WITH temp_join as \
(select quiz.user_id, (hto.user_id is not null) as home_try_on, hto.number_of_pairs from quiz left join home_try_on as hto on quiz.user_id = hto.user_id),\
funnel as \
(select temp_join.user_id as user_id, temp_join.home_try_on as home_try_on, temp_join.number_of_pairs as number_of_pairs, (purchase.user_id is not null) as is_purchase from temp_join left join purchase on temp_join.user_id = purchase.user_id)\
select (1.0 * sum(home_try_on) / count(home_try_on)) as quiz_to_hto, (1.0 * sum(is_purchase) / sum(home_try_on)) as hto_to_purch from funnel;\
\
WITH temp_join as \
(select quiz.user_id, (hto.user_id is not null) as home_try_on, hto.number_of_pairs from quiz left join home_try_on as hto on quiz.user_id = hto.user_id),\
funnel as \
(select temp_join.user_id as user_id, temp_join.home_try_on as home_try_on, temp_join.number_of_pairs as number_of_pairs, (purchase.user_id is not null) as is_purchase from temp_join left join purchase on temp_join.user_id = purchase.user_id)\
select number_of_pairs, (1.0 * sum(is_purchase) / count(is_purchase)) as purchase_rate from funnel group by 1;}