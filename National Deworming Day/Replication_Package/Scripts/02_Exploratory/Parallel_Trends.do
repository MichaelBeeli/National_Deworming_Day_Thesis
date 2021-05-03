// National Deworming Day Replication Package
// Author: Michael Beeli 
// Section: Exploratory Data Analysis
// Function: Test Parallel Trends


set more off
clear all 
drop _all 

******************** Set Graph Scheme ************************************
	
	/* 
ssc install grstyle, replace 
	
	set scheme s2color, perm
	
	grstyle init 
	
	grstyle set plain
	
	set scheme cleanplots, perm

	
*/



****** Install combined graph package *******
	/* 
	net install grc1leg,from( http://www.stata.com/users/vwiggins/) 
	ssc inst eqprhistogram

	*/
	


************ Create Basic Visualization of Trends ************ 

use "$trend_clean", clear

gen year = 0

replace year = 2012 if post2 == 1
replace year = 2013 if post3 == 1
replace year = 2014 if post4 == 1
replace year = 2016 if post5 == 1

keep if year > 0

gen treat = 1 if school_govt == 1 

replace treat = 0 if school_private == 1 | school_madarsa == 1 | school_other == 1


cd "$user/Figures"
collapse (mean) bin_read_code bin_math_code [pweight=hh_multiplier], by(treat year)



  tw connected bin_read_code year if treat == 0 || connected bin_read_code year if treat == 1, legend(order(1 "Control" 2 "Treatment")) xline(2014, lpattern("-")) ti(" % Can read a standard level-1 text") yti("Percent") ylab(0.3(0.05)0.7)
  
graph save "readtrend.png", replace
  
   tw connected bin_math_code year if treat == 0 || connected bin_math_code year if treat == 1, legend(order(1 "Control" 2 "Treatment")) xline(2014, lpattern("-")) ti(" % Can do two-digit subtraction") yti("Percent")  ylab(0.25(0.05)0.65)
  
graph save "mathtrend.png", replace
	
graph combine "readtrend.png" "mathtrend.png", col(1)
	
grc1leg  "readtrend.png" "mathtrend.png", row(1) legendfrom()

graph export "basictrend.png", replace





************ Show Trends with Confidence intervals ************




use "$trend_clean", clear


gen Year = 0

replace Year = 2012 if post2 == 1
replace Year = 2013 if post3 == 1
replace Year = 2014 if post4 == 1
replace Year = 2016 if post5 == 1

keep if Year > 0

gen treat = 1 if school_govt == 1 

replace treat = 0 if school_private == 1 | school_madarsa == 1 | school_other == 1


svyset village_code [pweight=hh_multiplier], strata(District) || hh_id

//  FITTED TRENDS COMPARISON
svy: regress bin_read_code i.treat##i.Year
margins treat#Year
marginsplot, name(readmarginsplot, replace) ti("Year-wise Reading trend comparison with 95% CI") xti("Treatment") recastci(rarea) plot1opts(lcolor(dkgreen) mcolor(dkgreen)) ci1opts(color(dkgreen) fintensity(10) lpattern("--")) plot2opts(lcolor(ebblue) mcolor(ebblue)) ci2opts(color(ebblue) fintensity(10)  lpattern("--")) plot3opts(lcolor(lavender) mcolor(lavender)) ci3opts(color(lavender) fintensity(10) lpattern("--"))  plot4opts(lcolor(cranberry) lpattern("--") mcolor(cranberry)) ci4opts(color(cranberry) fintensity(10) lpattern("--")) legend(row(1))

graph save "readtrend2.png", replace

svy: regress bin_read_code i.treat##i.Year
margins treat#Year
marginsplot, name(mathmarginsplot, replace)  ti("Year-wise Math trend comparison with 95% CI") xti("Treatment") recastci(rarea) plot1opts(lcolor(dkgreen) mcolor(dkgreen)) ci1opts(color(dkgreen) fintensity(10) lpattern("--")) plot2opts(lcolor(ebblue) mcolor(ebblue)) ci2opts(color(ebblue) fintensity(10)  lpattern("--")) plot3opts(lcolor(lavender) mcolor(lavender)) ci3opts(color(lavender) fintensity(10) lpattern("--"))  plot4opts(lcolor(cranberry) lpattern("--") mcolor(cranberry)) ci4opts(color(cranberry) fintensity(10) lpattern("--")) legend(row(1))


graph save "mathtrend2.png", replace


grc1leg  "readtrend2.png" "mathtrend2.png", row(1) legendfrom()


graph export "marginstrend.png", replace


