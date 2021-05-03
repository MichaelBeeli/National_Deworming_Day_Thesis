// National Deworming Day Replication Package
// Author: Michael Beeli 
// Section: Cleaning
// Function: Standardizing Dummy Variables 


set more off
clear all 
drop _all 



* Standardize for Household Impact Data
********************************************************************************

use "$impacthh", clear



*** Replace No = 2 with No = 0

local wrongno "hh_electricity_conn vlg_post_office_num  vlg_bank_num vlg_ration_shop_num vlg_govt_clinic_num  vlg_private_clinic_num vlg_internet_cafe_num  vlg_anganwadi_num      hh_electricity_today hh_toilet hh_tv hh_motor_vehicle  hh_computer_use hh_mobile hh_grad tuition "


foreach x of local wrongno {
	
	replace `x' = 0 if `x' == 1
	replace `x' = 1 if `x' == 2
	label define `x'  0 "No" 1 "Yes", replace
}


*** Replace child_gender with female dummy

replace child_gender = 0 if child_gender == 1
replace child_gender = 1 if child_gender == 2
rename child_gender         child_female


*** Drop remaining unnecessary variables 

drop hh_motor_veh_4whl hh_motor_veh_2whl preschool_no hh_electricity_today


*** Rename village-level dummies 

rename vlg_post_office_num      post_office
rename vlg_bank_num             bank
rename vlg_ration_shop_num      ration_shop
rename vlg_govt_clinic_num      govt_clinic
rename vlg_private_clinic_num   private_clinic
rename vlg_internet_cafe_num    internet_cafe
rename vlg_anganwadi_num        anganwadi
rename preschool_yes            preschool
rename kindergarton_yes         kindergarton

*** Clean ID

replace id = _n if post == 1

*** Harmonize district labels 

replace district_name = subinstr(district_name, "*", "", .)

replace district_name = strtrim(district_name)

replace district_name = subinstr(district_name, "(", "", .)

replace district_name = subinstr(district_name, ")", "", .)

replace district_name = "Ribhoi" if district_name == "Ri Bhoi"

replace district_name = "Rangareddy" if district_name == "Rangareddi"

replace district_name = "Pakur" if district_name == "Pakaur"

replace district_name = "Leh Ladakh" if district_name == "LehLadakh"

replace district_name = "Bulandshahar" if district_name == "Bulandshahr"

replace district_name = "Almora" if district_name == "Almora"

replace district_name = "Tarn Taran" if district_name == "Tarn-Taran"

replace district_name = "Janjgir - Champa" if district_name == "Janjgir_Champa"

replace district_name = "Bara Banki" if district_name == "Barabanki"

replace district_name= subinstr(district_name,`"""',"",.)

gen District = upper(district_name)

encode(District), gen(District_code)

drop  district_code district_name



**** Harmonize State labels ****


replace state_name= subinstr(state_name,`"""',"",.)


replace state_name = subinstr(state_name, "(", "", .)

replace state_name = subinstr(state_name, ")", "", .)


replace state_name = "ARUNACHAL PRADESH " if state_name == "Arunachal pardesh"

replace state_name = "TAMIL NADU " if state_name == "TAMILNADU"


gen State = upper(state_name)

replace State = "ARUNACHAL PRADESH" if State == "ARUNACHAL PRADESH "


encode(State), gen(State_code)

drop  state_code State

*** Convert Test-Scores into categorical dummies 

local scores "math_code read_code english_code"

foreach x of local scores {
	
	tab `x', gen(`x')
	
	
	gen five_`x' = 0
	replace five_`x' = 1  if `x' > 4 & `x' != .
	
	gen four_`x' = 0
	replace four_`x' = 1  if `x' > 3 & `x' != .
	

	
	gen three_`x' = 0
	replace three_`x' = 1  if `x' > 2 & `x' != .
	
	
	gen two_`x' = 0
	replace two_`x' = 1  if `x' > 2 & `x' != .
	
}


// Add categorical dummies for 4 or higher

local scores "math_code read_code english_code"

foreach x of local scores {
	

	gen bin_`x' = 0
	replace bin_`x' = 1  if `x' > 3 & `x' != .
	


}

replace bin_math_code = 1 if math_code4 == 1 | math_code5 == 1
replace bin_read_code = 1 if read_code4 == 1 | read_code5 == 1
replace bin_english_code = 1 if english_code4 == 1 | english_code5 == 1


*** Create dummies for class-level by age

gen std_8 = 0
replace std_8 = 1 if child_age < 14 & child_age > 6

gen std_12 = 0
replace std_12 = 1 if child_age >= 14

gen female_child_age = 0 
replace female_child_age = 1 if child_female == 1 & child_age > 12 

******* Drop ages without test scores *******
drop if child_age < 5


*** Generate Treatment variable 

gen treat = 1 if school_govt == 1 | surveyed_school == 1 

replace treat = 0 if school_private == 1 | school_madarsa == 1 | school_other == 1


gen treat_post = 0

replace treat_post = treat*post


*** Create attendance variable 

gen attend_gov = 0 
replace attend_gov = 1 if school_govt == 1

gen attend_priv = 0
replace attend_priv = 1 if school_private ==1

local dummies "four_math_code four_read_code four_english_code  attend_gov attend_priv hh_electricity_conn post_office bank ration_shop govt_clinic private_clinic internet_cafe anganwadi hh_toilet hh_mobile hh_computer_use"


foreach x of local dummies {
	
	label define `x'  0 "No" 1 "Yes", replace
}


local controls "post_office govt_clinic ration_shop private_clinic internet_cafe anganwadi"

// Keep relevant variables 
keep *read_code *math_code bin*  *english_code State District* village_code hh* child* test* school* read_code* math_code* test_language  post* english* treat*  std* attend* `controls'


***** Label Variables
label variable five_math_code "Can do division"
label variable five_read_code "Can read a standard level-2 text"
label variable five_english_code "Can at least read simple English sentences"

label variable four_math_code "Can do two-digit subtraction"
label variable four_read_code "Can read a standard level-1 text"
label variable four_english_code "Can read simple English words"

label variable three_math_code "Can recognize numbers 11-99"
label variable three_read_code "Can read words"
label variable three_english_code "Can identify lowercase English letters"

label variable two_math_code "Can recognize numbers 1-9"
label variable two_read_code "Can identify letters"
label variable two_english_code "Can identify uppercase English letters"

label variable math_code1 "Can not do any arithmetic"
label variable math_code2 "Can recognize numbers 1-9"
label variable math_code3 "Can recognize numbers 11-99"
label variable math_code4 "Can do two-digit subtraction"
label variable math_code5 "Can do division"

label variable read_code1 "Can not read"
label variable read_code2 "Can identify letters"
label variable read_code3 "Can read words"
label variable read_code4 "Can read a standard level-1 text"
label variable read_code5 "Can read a standard level-2 text"

label variable english_code1 "Can not read English"
label variable english_code2 "Can identify uppercase English letters"
label variable english_code3 "Can identify lowercase English letters"
label variable english_code4 "Can read simple English words"
label variable english_code5 "Can read simple English sentences"


label variable attend_gov "Attend Government School"
label variable attend_priv "Attend Private School"
label variable hh_electricity_conn "Household has electricity conneection"
label variable  post_office "Village has a post office"
label variable ration_shop "Village has a Public Distribution Scheme ration shop"
label variable govt_clinic  "Village has a government clinic"
label variable private_clinic "Village has a private clinic"
label variable internet_cafe "Village has an internet cafe"
label variable anganwadi "Village has an Anganwadi"
label variable hh_toilet "Household has a toilet"
label variable hh_mobile "Household has a mobile phone"
label variable hh_computer_use "Household has a person who can use a computer"


label variable child_female "Female Children"


*** Create categorical variable of age groups *** 

gen agegroup = ""

replace agegroup = "5-10" if child_age < 11
replace agegroup = "11-16" if child_age > 10


** Create dummy for high-capacity states treated in NDD 2015 and interaction variables **


gen high_cap  =  0
replace high_cap = 1 if inlist(State_code, 3, 4, 5, 6, 9, 14, 16, 17, 27, 29, 30, 32 )

gen gender_post = child_female*post
gen gender_treat = child_female*treat
gen gender_treat_post = child_female*treat*post

gen high_cap_post = high_cap*post
gen high_cap_treat = high_cap*treat
gen high_cap_treat_post = high_cap*treat*post


save "$impact_clean", replace




* Standardize for Household pre-trend Data
********************************************************************************

use "$trendhh", clear


// Keep relevant variables 
keep state_code state_name district_name village_code district_code hh_id child_age child_gender school* read_code* math_code* test_language hh_multiplier post* english* test_sample

*** Harmonize different test score variables

// Relabel year variables 

gen byte ten = 1 if post1 == 0
gen  byte eleven = 1 if post1 == 1
gen byte twelve = 1 if post2 == 1
gen byte thirteen = 1 if post3 == 1
gen byte fourteen = 1 if post4 == 1
gen byte sixteen  = 1 if post5 == 1

// Convert test scores to categorical dummies 

local scores "math_code read_code"

foreach x of local scores {
	

	gen bin_`x' = 0
	replace bin_`x' = 1  if `x' > 3 & `x' != .
	


}

replace bin_math_code = 1 if math_code4 == 1 | math_code5 == 1
replace bin_read_code = 1 if read_code4 == 1 | read_code5 == 1

*** Replace child_gender with female dummy

replace child_gender = 0  if child_gender == 1
replace child_gender = 1  if child_gender == 2

rename child_gender          child_female


*** Clean ID

gen id = _n 

*** Harmonize district labels 


replace district_name = subinstr(district_name, "*", "", .)

replace district_name = strtrim(district_name)

replace district_name = subinstr(district_name, "(", "", .)

replace district_name = subinstr(district_name, ")", "", .)

replace district_name = "Ribhoi" if district_name == "Ri Bhoi"

replace district_name = "Rangareddy" if district_name == "Rangareddi"

replace district_name = "Pakur" if district_name == "Pakaur"

replace district_name = "Leh Ladakh" if district_name == "LehLadakh"

replace district_name = "Bulandshahar" if district_name == "Bulandshahr"

replace district_name = "Almora" if district_name == "Almora"

replace district_name = "Tarn Taran" if district_name == "Tarn-Taran"
replace district_name = "Tarn Taran" if district_name == "Tarn_Taran"

replace district_name = "Janjgir - Champa" if district_name == "Janjgir_Champa"

replace district_name = "Janjgir - Champa" if district_name == "Janjgir _ Champa"

replace district_name = "Bara Banki" if district_name == "Barabanki"

replace district_name = "Bara Banki" if district_name == "Barabanki"

replace district_name= subinstr(district_name,`"""',"",.)


gen District = upper(district_name)

encode(District), gen(District_code)

drop  district_code district_name



*** Create dummies for class-level by age

gen std_8 = 0
replace std_8 = 1 if child_age < 14 & child_age > 6

gen std_12 = 0
replace std_12 = 1 if child_age >= 14

*** Create attendance variable 

gen attend_gov = 0 
replace attend_gov = 1 if school_govt == 1

gen attend_priv = 0
replace attend_priv = 1 if school_private ==1


*** Generate Treatment variable 

gen treat = 1 if school_govt == 1 

replace treat = 0 if school_private == 1 | school_madarsa == 1 | school_other == 1




// Keep relevant variables 
keep state* District* village_code hh* child* test* school* read_code* math_code* test_language  post*  bin* std* attend*



save "$trend_clean", replace






