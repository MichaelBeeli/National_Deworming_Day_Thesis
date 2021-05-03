// National Deworming Day Replication Package
// Author: Michael Beeli 
// Section: Exploratory Analysis
// Function: Preparing Data for Descriptive Graphs in R


********************************************************************************
* INTEROPERABILITY
********************************************************************************

use "$impact_clean", clear

keep if post == 0

svyset village_code [pweight=hh_multiplier], strata(District) || hh_id


gen age1 = 1 if child_age == 5 | child_age == 6 | child_age == 7
replace age1 = 2 if child_age == 8 | child_age == 9 | child_age == 10
replace age1 = 3 if child_age == 11 | child_age == 12 | child_age == 13
replace age1 = 4  if child_age == 14 | child_age == 15 | child_age == 16

 svy: mean bin_read_code bin_english_code bin_math_code, over(age1 child_female)
 
gsort age1 

gen Age = "5-7" if age1 == 1
replace Age = "8-10" if age1 == 2
replace  Age = "11-13" if age1 == 3
replace Age = "14-16" if age1 == 4


collapse (mean) bin_read_code bin_english_code bin_math_code [pweight=hh_multiplier], by(Age child_female)


drop if Age ==  ""

drop if child_female == . 

drop if bin_read_code == 0

gen Gender = "Female"
replace Gender = "Male" if child_female == 0


egen id = concat(Gender Age)


drop child_female

gen temp = substr(Age, 1, 2 )

replace temp = "5" if temp == "5-"
replace temp = "8" if temp == "8-"

destring temp, gen(num)

gsort num


cd "$datapath/Data/Clean_Data/Household"
save "het_descriptives_bin.dta", replace 




use "$impact_clean", clear

keep if post == 0

svyset village_code [pweight=hh_multiplier], strata(District) || hh_id


gen age1 = 1 if child_age == 5 | child_age == 6 | child_age == 7
replace age1 = 2 if child_age == 8 | child_age == 9 | child_age == 10
replace age1 = 3 if child_age == 11 | child_age == 12 | child_age == 13
replace age1 = 4  if child_age == 14 | child_age == 15 | child_age == 16


gsort age1 

gen Age = "5-7" if age1 == 1
replace Age = "8-10" if age1 == 2
replace  Age = "11-13" if age1 == 3
replace Age = "14-16" if age1 == 4


collapse (mean) read_code1 read_code2 read_code3 read_code4 read_code5 math_code1 math_code2 math_code3 math_code4 math_code5 english_code1 english_code2 english_code3 english_code4 english_code5 [pweight=hh_multiplier], by(Age)


drop if Age ==  ""

drop if read_code1 == .


reshape long read_code math_code english_code, i(Age) j(j)

rename read_code code1 
rename math_code code2 
rename english_code code3 

gen n = _n

gen k = j

drop j

reshape long code, i(n) j(j) 

gen type = "read" if j == 1 
replace type = "math" if j == 2
replace type = "english" if j == 3

egen key = concat(type Age)


gen temp = substr(Age, 1, 2 )

replace temp = "5" if temp == "5-"
replace temp = "8" if temp == "8-"

destring temp, gen(num)

gsort num k




save "het_descriptives.dta", replace 





