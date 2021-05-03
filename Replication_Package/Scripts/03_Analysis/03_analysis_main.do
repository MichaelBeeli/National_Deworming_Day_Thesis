// National Deworming Day Replication Package
// Author: Michael Beeli 
// Section: Analysis
// Function: Analysis Main Script 


set more off
clear all 
drop _all 


// Load clean data

use "$impact_clean", clear 

// Set survey-weighting and cluster parameters

svyset village_code [pweight=hh_multiplier], strata(District) || hh_id

// Clear any residual stored estimates

eststo clear


****************************************************************
* Coefplot: Linear Probability Model



do "$coefplot_lpm"



****************************************************************


****************************************************************
* Coefplot: Logistic Regression Model



do "$coefplot_log"



****************************************************************



****************************************************************
* Main Results LaTeX Table 



do "$mainresults"



****************************************************************



****************************************************************
* Coefplot: Heterogenous Effects



do "$coefplot_het"



****************************************************************




****************************************************************
* Triple-Difference LPM LaTeX Table



do "$tripledff_lpm"



****************************************************************



****************************************************************
* Triple-Difference Log LaTeX Table



do "$tripledff_log"



****************************************************************



****************************************************************
* Ordered Logit (Double-Diff)



do "$ordered_double"


****************************************************************


****************************************************************
* Ordered Logit (Triple-Diff)



do "$ordered_triple"


****************************************************************





