// National Deworming Day Replication Package
// Author: Michael Beeli 
// Section: Cleaning
// Function: Constructing Intermediate Datasets


set more off
clear all 
drop _all 

	
* Globals 
********************************************************************************
 

 
* Create globals for 2010-2013  datasets (preexisting trends)

local pre "ten eleven twelve thirteen"
local i = 0
	

forvalues x = 0/3 {
	
	global hh1`x'  "$datapath/Data/Raw_Data/Household/dta/hh_201`x'.dta"
	global nhh1`x'  "$datapath/Data/Intermediate_Data/Household/hh_201`x'.dta"
}
 
* Globals 2014 & 2016 (pre and post treatment)

global hh14 "$datapath/Data/Raw_Data/Household/dta/hh_2014.dta"
global hh16 "$datapath/Data/Raw_Data/Household/dta/hh_2016.dta"
global nhh14 "$datapath/Data/Intermediate_Data/Household/hh_2014.dta"
global nhh16 "$datapath/Data/Intermediate_Data/Household/hh_2016.dta"


* Globals for variable lists 

global vlg " vlg_pucca_road vlg_electricity vlg_post_office vlg_bank vlg_ration_shop vlg_govt_clinic vlg_private_clinic  vlg_internet_cafe  vlg_anganwadi "


* Harmonize Household Data
********************************************************************************
 
* Drop unnecessary variables

use "$hh10", clear

	drop  vlg_govt_primary_school* vlg_govt_middle_school* vlg_govt_secondary_school* vlg_private_school* mother_mobile_test mother_class mother_gone_to_school_yes mother_age father_class father_gone_to_school_no father_gone_to_school_yes father_age bonus* hh_newspaper_yes hh_newspaper_no hh_reading_material_yes hh_reading_material_no hh_cable_tv__yes hh_cable_tv__no hh_dvd_yes hh_dvd_no hhtype_katcha hhtype_semi_katcha hhtype_pucca


save "$nhh10", replace 


use "$hh11", clear

	drop vlg_solar_energy vlg_govt_primary_school* vlg_govt_middle_school* vlg_govt_secondary_school* vlg_private_school* mother_class mother_gone_to_school_yes mother_age father_class father_gone_to_school_no father_gone_to_school_yes father_age hh_newspaper hh_reading_material hh_cable_tv  hh_type
	

save "$nhh11", replace


use "$hh12", clear

	drop vlg_solar_energy vlg_govt_primary_school* vlg_govt_middle_school* vlg_govt_secondary_school* vlg_private_school mother_class mother_gone_to_school_yes mother_age father_class father_gone_to_school_no father_gone_to_school_yes father_age hh_newspaper hh_reading_material hh_cable_tv  hh_type
	


save "$nhh12", replace



use "$hh13", clear

	drop vlg_solar_energy vlg_govt_primary_school* vlg_govt_middle_school* vlg_govt_secondary_school* vlg_private_school* mother_class mother_gone_to_school_yes mother_age father_class father_gone_to_school_no father_gone_to_school_yes father_age hh_newspaper hh_reading_material hh_cable_tv  hh_type
	
	
save "$nhh13", replace



use "$hh14", clear

	drop vlg_solar_energy vlg_govt_primary_school* vlg_govt_middle_school* vlg_govt_secondary_school* vlg_private_school* mother_class mother_gone_to_school mother_age father_class father_gone_to_school father_age hh_newspaper hh_reading_material hh_cable_tv  hh_type
	

save "$nhh14", replace



use "$hh16", clear

	drop vlg_solar_energy vlg_govt_primary_school* vlg_govt_middle_school* vlg_govt_secondary_school* vlg_private_school* mother_class mother_gone_to_school mother_age father_class father_gone_to_school father_age hh_newspaper hh_reading_material hh_cable_tv  hh_type
	

save "$nhh16", replace


* Harmonize variables 


use "$nhh10", clear 


// Rename village-level variables
rename vlg_govt_primary_health_clinic      vlg_govt_clinic 
rename vlg_private_health_clinic           vlg_private_clinic 

	
// Harmonize test score variables
forvalues x =1/5 {
	
	gen math_code`x' = 0
	gen read_code`x' = 0
	
}


replace math_code1 = 1    if math_nothing == 1    
replace math_code2 = 1    if math_num_1_9 == 1     
replace math_code3 = 1    if math_num_10_99 == 1   
replace math_code4 = 1    if math_subtraction == 1 
replace math_code5 = 1    if math_division == 1    

replace read_code1 = 1    if read_nothing == 1     
replace read_code2 = 1    if read_letter == 1      
replace read_code3 = 1    if read_word == 1       
replace read_code4 = 1    if read_level_1  == 1   
replace read_code5 = 1    if read_level_2 == 1    



save "$nhh10", replace


use "$nhh11", clear 


// Rename village-level variables
rename vlg_govt_primary_health_clinic      vlg_govt_clinic 
rename vlg_private_health_clinic           vlg_private_clinic 

	
// Harmonize test score variables
forvalues x =1/5 {
	
	gen math_code`x' = 0
	gen read_code`x' = 0
	
}


replace math_code1 = 1    if math_nothing == 1    
replace math_code2 = 1    if math_num_1_9 == 1     
replace math_code3 = 1    if math_num_10_99 == 1   
replace math_code4 = 1    if math_subtraction == 1 
replace math_code5 = 1    if math_division == 1    

replace read_code1 = 1    if read_nothing == 1     
replace read_code2 = 1    if read_letter == 1      
replace read_code3 = 1    if read_word == 1       
replace read_code4 = 1    if read_level_1  == 1   
replace read_code5 = 1    if read_level_2 == 1    



save "$nhh11", replace



use "$nhh12", clear 


// Rename village-level variables
rename vlg_govt_primary_health_clinic      vlg_govt_clinic 
rename vlg_private_health_clinic           vlg_private_clinic 

// Harmonize village-level variables
foreach x of global vlg{
	
	encode `x', gen(`x'_num)
	drop `x'
}


// Harmonize test score variables
forvalues x =1/5 {
	
	gen math_code`x' = 0
	gen read_code`x' = 0
	
}


replace math_code1 = 1    if math_nothing == 1    
replace math_code2 = 1    if math_num_1_9 == 1     
replace math_code3 = 1    if math_num_10_99 == 1   
replace math_code4 = 1    if math_subtraction == 1 
replace math_code5 = 1    if math_division == 1    

replace read_code1 = 1    if read_nothing == 1     
replace read_code2 = 1    if read_letter == 1      
replace read_code3 = 1    if read_word == 1       
replace read_code4 = 1    if read_level_1  == 1   
replace read_code5 = 1    if read_level_2 == 1    


save "$nhh12", replace



use "$nhh13", clear 


// Rename village-level variables
rename vlg_govt_primary_health_clinic      vlg_govt_clinic 
rename vlg_private_health_clinic           vlg_private_clinic 

// Harmonize village-level variables
foreach x of global vlg{
	
	encode `x', gen(`x'_num)
	drop `x'
}


// Convert test scores to categorical dummies 
forvalues x =1/5 {
	
	gen math_code`x' = 0
	gen read_code`x' = 0
	
}


local scores "math_code read_code"

foreach x of local scores {
	
	tab `x', gen(_`x')


}


replace math_code1 = 1    if _math_code1 == 1    
replace math_code2 = 1    if _math_code2 == 1     
replace math_code3 = 1    if _math_code3 == 1   
replace math_code4 = 1    if _math_code4 == 1 
replace math_code5 = 1    if _math_code5 == 1    

replace read_code1 = 1    if _read_code1 == 1     
replace read_code2 = 1    if _read_code2 == 1      
replace read_code3 = 1    if _read_code3 == 1       
replace read_code4 = 1    if _read_code4 == 1   
replace read_code5 = 1    if _read_code5 == 1    
	


save "$nhh13", replace


use "$nhh14", clear 


// Rename village-level variables
rename vlg_govt_primary_health_clinic      vlg_govt_clinic 
rename vlg_private_health_clinic           vlg_private_clinic 

// Harmonize village-level variables
foreach x of global vlg{
	
	encode `x', gen(`x'_num)
	drop `x'
}

save "$nhh14", replace


use "$nhh16", clear 


// Rename village-level variables
rename vlg_govt_primary_health_clinic      vlg_govt_clinic 
rename vlg_private_health_clinic           vlg_private_clinic 

// Harmonize village-level variables
foreach x of global vlg{
	
	encode `x', gen(`x'_num)
	drop `x'
}

save "$nhh16", replace








