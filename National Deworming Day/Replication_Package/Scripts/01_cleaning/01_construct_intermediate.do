// National Deworming Day Replication Package
// Author: Michael Beeli 
// Section: Cleaning
// Function: Constructing Intermediate Datasets


set more off
clear all 
drop _all 


* Construct Intermediate Datasets
********************************************************************************
 
 
 

* Construct impact evaluation datasets

use "$nhh14", clear


append using "$nhh16", gen(post)

save "$impacthh", replace 

* Construct pre-existing trends datasets


// Households

use "$nhh10", clear 





	append using "$nhh11", gen(post1)
	append using "$nhh12", gen(post2) force
	append using "$nhh13", gen(post3) force 
	append using "$nhh14", gen(post4) force 
	append using "$nhh16", gen(post5) force 
	

save "$trendhh", replace
