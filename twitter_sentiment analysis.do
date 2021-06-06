
***sentiment analysis***
**import data into stata
**kenny's state

foreach var in "alaska" "alabama"	"arkansas"	"arizona"	"california"	"colorado"	"connecticut"	"district_of_columbia"	"delaware"	"florida"	"georgia"	"hawaii"	"iowa"	"idaho"	"illinois"	"indiana"	"kansas"	"kentucky"	"louisiana"	"massachusetts"	"maryland"	"maine"	"michigan"	"minnesota"	"missouri" "virginia" "montana" "oklahoma" "puerto rico" "rhode island" "tennessee" "utah" "washington" "wyoming"  "south_dakota" {
	foreach i of num 2011/2022 {
	capture noisily import delimited "/Users/kenny/Downloads/USA_tweets/`var'`i'.csv", varnames(1) encoding(UTF-8) clear 

	**gen year, month and day
	destring year month day hour min second, replace 
	gen data1 = substr(created_at,1,10)
	gen time1 = substr(created_at,12,19)
	capture noisily gen year = substr(data1,1, 4)
	capture noisily gen month = substr(data1,6, 2)
	capture noisily gen day = substr(data1,9, 2)
	**gen time
	capture noisily gen hour = substr(time1,1, 2)
	capture noisily gen min = substr(time1,4, 2)
	capture noisily gen second = substr(time1,7, 2)
	**gen state symbol
	capture noisily gen state = "`var'"	
	
	
	capture noisily save "/Users/kenny/Downloads/USA_tweet_dta/`var'`i'.dta", replace 
	

}
	}
**weiyu's state
foreach var in "mississippi"	"montana"	"nebraska"	"nevada"	"new_hampshire"	"new_jersey"	"new_mexico"	"new_york"	"north_carolina"	"north_dakota"	"ohio"	"oregon"	"pennsylvania"	"south_carolina"	"texas"	"vermont"	"west_virginia"	"wisconsin"{
	foreach i of num 2011/2022 {
	capture noisily import delimited "/Users/kenny/Downloads/USA_tweets/`var'`i'.csv", varnames(1) encoding(UTF-8) clear 

	**gen year, month and day
	capture noisily gen year = substr(date,1, 4)
	capture noisily gen month = substr(date,6, 2)
	capture noisily gen day = substr(date,9, 2)
	**gen time
	capture noisily gen hour = substr(time,1, 2)
	capture noisily gen min = substr(time,4, 2)
	capture noisily gen second = substr(time,7, 2)
	**gen state symbol
	capture noisily gen state = "`var'"	
	
	capture noisily save "/Users/kenny/Downloads/USA_tweet_dta/`var'`i'.dta", replace 
	

}
	}

*** append all year data
**kenny
use  "/Users/kenny/Downloads/USA_tweet_dta/alaska2011near.dta", clear
foreach var in "alaska" "alabama"	"arkansas"	"arizona"	"california"	"colorado"	"connecticut"	"district_of_columbia"	"delaware"	"florida"	"georgia"	"hawaii"	"iowa"	"idaho"	"illinois"	"indiana"	"kansas"	"kentucky"	"louisiana"	"massachusetts"	"maryland"	"maine"	"michigan"	"minnesota"	"missouri" "virginia" "montana" "oklahoma" "puerto rico" "rhode island" "south dakota" "tennessee" "utah" "washington" "wyoming"{
	foreach i of num 2011/2022 {
	append using  "/Users/kenny/Downloads/USA_tweet_dta/`var'`i'near.dta" , force
	
	}
}

**weiyu
use  "/Users/kenny/Downloads/USA_tweet_dta/mississippi2011.dta", clear
foreach var in "mississippi"	"montana"	"nebraska"	"nevada"	"new_hampshire"	"new_jersey"	"new_mexico"	"new_york"	"north_carolina"	"north_dakota"	"ohio"	"oregon"	"pennsylvania"	"south_carolina"	"texas"	"vermont"	"west_virginia"	"wisconsin"{
	foreach i of num 2011/2021 {
	append using  "/Users/kenny/Downloads/USA_tweet_dta/`var'`i'.dta" , force
	
	}
}

**convert to csv for sentiment analysis in python
	
duplicates drop
save "/Users/kenny/Downloads/total.dta"
**and then export to csv forr python sentiment analysis

destring longi, replace force

drop longi lat

gen geocode = substr(place,35, 33)
split geocode, parse(",") gen(geo)


replace geo2 = substr(geo2, 1, length(geo2)-2) if substr(geo2, -1, 1) == "}"
rename (geo1 geo2) (longi lat)

drop if longi == .

tab state

export delimited using "/Users/kenny/Downloads/PHD degree preparation/GMU/HAP618 phyton/final project/twitter large data/twitter_weiyu.csv", replace

gen case_id = _n


***analysis***	

import delimited "/Users/kenny/Downloads/PHD degree preparation/GMU/HAP618 phyton/final project/twitter large data/tweet_sent2.csv", encoding(UTF-8) clear 
**create state identifier
drop GEOID
gen GEOID=0
replace GEOID =	01	if state =="alabama"
replace GEOID =	02	if state =="alaska"
replace GEOID =	04	if state =="arizona"
replace GEOID =	05	if state =="arkansas"
replace GEOID =	06	if state =="california"
replace GEOID =	08	if state =="colorado"
replace GEOID =	09	if state =="connecticut"
replace GEOID =	10	if state =="delaware"
replace GEOID =	12	if state =="florida"
replace GEOID =	13	if state =="georgia"
replace GEOID =	15	if state =="hawaii"
replace GEOID =	16	if state =="idaho"
replace GEOID =	17	if state =="illinois"
replace GEOID =	18	if state =="indiana"
replace GEOID =	19	if state =="iowa"
replace GEOID =	20	if state =="kansas"
replace GEOID =	21	if state =="kentucky"
replace GEOID =	22	if state =="louisiana"
replace GEOID =	23	if state =="maine"
replace GEOID =	24	if state =="maryland"
replace GEOID =	25	if state =="massachusetts"
replace GEOID =	26	if state =="michigan"
replace GEOID =	27	if state =="minnesota"
replace GEOID =	28	if state =="mississippi"
replace GEOID =	29	if state =="missouri"
replace GEOID =	30	if state =="montana"
replace GEOID =	31	if state =="nebraska"
replace GEOID =	32	if state =="nevada"
replace GEOID =	33	if state =="new_hampshire"
replace GEOID =	34	if state =="new_jersey"
replace GEOID =	35	if state =="new_mexico"
replace GEOID =	36	if state =="new_york"
replace GEOID =	37	if state =="north_carolina"
replace GEOID =	38	if state =="north_dakota"
replace GEOID =	39	if state =="ohio"
replace GEOID =	40	if state =="oklahoma"
replace GEOID =	41	if state =="oregon"
replace GEOID =	42	if state =="pennsylvania"
replace GEOID =	44	if state =="rhode island"
replace GEOID =	45	if state =="south_carolina"
replace GEOID =	46	if state =="south_dakota"
replace GEOID =	47	if state =="tennessee"
replace GEOID =	48	if state =="texas"
replace GEOID =	49	if state =="utah"
replace GEOID =	50	if state =="vermont"
replace GEOID =	51	if state =="virginia"
replace GEOID =	53	if state =="washington"
replace GEOID =	54	if state =="west_virginia"
replace GEOID =	55	if state =="wisconsin"
replace GEOID =	56	if state =="wyoming"
replace GEOID =	60	if state =="american_samoa"
replace GEOID =	66	if state =="guam"
replace GEOID =	69	if state =="northern_mariana_islands"
replace GEOID =	72	if state =="puerto rico"
replace GEOID =	78	if state =="virgin_islands"
replace GEOID =	11	if state =="district_of_columbia"

***append dataset
append using  "/Users/kenny/Downloads/PHD degree preparation/GMU/HAP618 phyton/final project/twitter large data/twitter_data_for_analysis" , force

***clean data
replace GEOID = geoid if GEOID==.
replace reply = replies_count if reply==.
replace retweets = retweets_count if retweets ==.
replace like= likes_count if like ==.
replace videos = video if videos==.

drop com
bysort geoid: egen com = mean(compound)


drop  covid sentiment positive


gen covid =0
replace covid=1 if (year==2019 & month==12) | year==2020

gen sentiment =0 if compound <= -0.05
replace sentiment =1 if compound > -0.05 & compound < 0.05
replace sentiment =2 if compound >= 0.05

gen positive = 0
replace positive =1 if compound >= 0.05


foreach var of varlist replies_count retweets_count  likes_count video {
	drop if `var' =="NA"
}

destring(replies_count retweets_count photos likes_count video), gen(reply retweets photo like videos)

*** create the box plot by year
graph box compound, over(year)

**regression
reg sentiment c.year i.covid   i.month  i.hour reply retweets like i.videos longi lat

logistic positive c.year i.covid   i.month  ib1.hour reply retweets like i.videos longi lat, cluster(GEOID)

logistic positive c.year i.covid##c.hour    i.month  reply retweets like i.videos longi lat, cluster(GEOID)

**create cleean data set for github
keep created_at date time user_id username name tweet language com covid data1 time1 hour min second year month day sentiment positive reply retweets like longi lat neg neu pos compound state GEOID videos

tab state
***create data for mapping in R
duplicates drop GEOID, force

tab GEOID 
