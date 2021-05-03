// National Deworming Day Replication Package
// Author: Michael Beeli 
// Section: Cleaning
// Function: Converting Raw Data to .dta format 


set more off
clear all 
drop _all 



	
* Globals 
********************************************************************************
 
* Create globals for 2010-2013 datasets (preexisting trends)
 
local pre "ten eleven twelve thirteen"
local i = 0
	

foreach x of local pre {
	
	global hh_`x'  "$datapath/Data/Raw_Data/Household/Text/ASER Household201`i'.txt"
	local i = `i' +1
}

* Globals 2014 & 2016 (pre and post treatment)

global hh_fourteen "$datapath/Data/Raw_Data/Household/Text/ASER Household2014.txt"

global hh_sixteen "$datapath/Data/Raw_Data/Household/Text/ASER Household2016.txt"


* Convert Household Data to .dta 
********************************************************************************
 
import delimited "$hh_ten", clear

save "$datapath/Data/Raw_Data/Household/dta/hh_2010.dta", replace

import delimited "$hh_eleven", clear

save "$datapath/Data/Raw_Data/Household/dta/hh_2011.dta", replace

import delimited "$hh_twelve", clear

save "$datapath/Data/Raw_Data/Household/dta/hh_2012.dta", replace

import delimited "$hh_thirteen", clear

save "$datapath/Data/Raw_Data/Household/dta/hh_2013.dta", replace

import delimited "$hh_fourteen", clear

save "$datapath/Data/Raw_Data/Household/dta/hh_2014.dta", replace

import delimited "$hh_sixteen", bindquote(strict) clear

save "$datapath/Data/Raw_Data/Household/dta/hh_2016.dta", replace



