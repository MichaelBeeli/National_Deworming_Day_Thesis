// National Deworming Day Replication Package
// Author: Michael Beeli 
// Section: Main
// Function: Main Do File


set more off
clear all 
drop _all 


***** Define User ****

********************************************************************************
* INTEROPERABILITY
********************************************************************************
 

if c(username)=="michaelbeeli" {
	global user "/Users/michaelbeeli/Documents/Github/Thesis/Replication_Package"
	global datapath "/Users/michaelbeeli/Documents/Thesis"
}

********************************************************************************	
* GLOBALS
********************************************************************************
 
****** .txt Data 

	 
	* Create globals for 2010-2013 datasets (preexisting trends)
	local pre "ten eleven twelve thirteen"
	local i = 0
		
	foreach x of local pre {
		
		global hh_`x'  "$datapath/Data/Raw_Data/Household/Text/ASER Household201`i'.txt"
		local i = `i' +1
	}

	* Globals 2014 & 2016 (pre and post treatment)
	global hh_fourteen "$datapath/Data/Raw_DataHousehold/Text/ASER Household2014.txt"
	global hh_sixteen "$datapath/Data/Raw_DataHousehold/Text/ASER Household2016.txt"


****** .dta Data 

		
	* Create globals for 2010-2013  datasets (preexisting trends)
	local pre "ten eleven twelve thirteen"
	local i = 0
		

	forvalues x = 0/3 {
		
		global hh1`x'  "$datapath/Data/Raw_Data/Household/dta/hh_201`x'.dta"
		global nhh1`x'  "$udatapath/Data/Intermediate_Data/Household/hh_201`x'.dta"
	}
	 
	* Globals 2014 & 2016 (pre and post treatment)
	global hh14 "$datapath/Data/Raw_Data/Household/dta/hh_2014.dta"
	global hh16 "$datapath/Data/Raw_Data/Household/dta/hh_2016.dta"
	global nhh14 "$datapath/Data/Intermediate_Data/Household/hh_2014.dta"
	global nhh16 "$datapath/Data/Intermediate_Data/Household/hh_2016.dta"


	* Global for variable lists 
	global vlg " vlg_pucca_road vlg_electricity vlg_post_office vlg_bank vlg_ration_shop vlg_govt_clinic vlg_private_clinic  vlg_internet_cafe  vlg_anganwadi "
	

		
	* Globals for constructed datasets

	global impacthh "$datapath/Data/Intermediate_Data/Household/impacthh.dta"
	global trendhh "$datapath/Data/Intermediate_Data/Household/trendhh.dta"
	
	
****** Cleaned Data 

	global impact_clean "$datapath/Data/Clean_Data/Household/impact_clean.dta"
	global trend_clean "$datapath/Data/Clean_Data/Household/trend_clean.dta"


****** Cleaning Scripts

	global clean_main "$user/Scripts/01_cleaning/01_cleaning_main.do"
	global convert_dta "$user/Scripts/01_cleaning/01_convert_dta.do"
	global harmonize_preappend "$user/Scripts/01_cleaning/01_harmonize_preappend.do"
	global construct_intermediate "$user/Scripts/01_cleaning/01_construct_intermediate.do"
	global dummy_vars "$user/Scripts/01_cleaning/01_dummy_variables.do"
	
	
// Globals for Exploratory scripts

global exploratory_main "$user/Scripts/02_exploratory/02_exploratory_main.do"

global parallel_trends "$user/Scripts/02_exploratory/Parallel_Trends"

global r_construct "$user/Scripts/02_exploratory/R_construct"


// Globals for Analysis scripts

global analysis_main "$user/Scripts/03_Analysis/03_analysis_main.do"

global coefplot_lpm "$user/Scripts/03_Analysis/03_coefplot_lpm.do"

global coefplot_log "$user/Scripts/03_Analysis/03_coefplot_log.do"

global mainresults "$user/Scripts/03_Analysis/03_mainresults.do"

global coefplot_het "$user/Scripts/03_Analysis/03_coefplot_het.do"

global tripledff_lpm "$user/Scripts/03_Analysis/03_triplediff_lpm.do"

global tripledff_log "$user/Scripts/03_Analysis/03_triplediff_log.do"

global ordered_double "$user/Scripts/03_Analysis/03_doublediff_order"

global ordered_triple"$user/Scripts/03_Analysis_03/triplediff_order"
	
	

********************************************************************************	
* Install Packages/User Written Commands
********************************************************************************	

net install rscript, from("https://raw.githubusercontent.com/reifjulian/rscript/master") replace

ssc install gologit2

ssc install omodel

ssc install CiC

ssc install coefplot

net install st0063_1, from("http://www.stata-journal.com/software/sj4-3")

ssc install head

ssc install matchit

ssc install freqindex

net install strgroup.pkg, from("http://fmwww.bc.edu/RePEc/bocode/s/")




********************************************************************************	
* Cleaning
********************************************************************************	

do "$clean_main"


********************************************************************************	
* Exploratory Data Analysis
********************************************************************************	

do "$exploratory_main"

********************************************************************************	
* Primary Data Analysis
********************************************************************************	

do "$analysis_main"







