// National Deworming Day Replication Package
// Author: Michael Beeli 
// Section: Analysis
// Function: Triple-Difference (Gender) Table



preserve 

keep if agegroup == "5-10"


	quietly eststo gen_read_lpm_5: svy: reg three_read_code treat post child_female treat_post gender_post gender_treat gender_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code



	quietly eststo gen_math_lpm_5: svy: reg three_math_code treat post child_female treat_post gender_post gender_treat gender_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code
	
	

	quietly eststo gen_english_lpm_5: svy: reg three_english_code treat post child_female treat_post gender_post gender_treat gender_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code
	
	
	
restore





preserve 

keep if agegroup == "11-16"


	quietly eststo gen_read_lpm_11: svy: reg four_read_code treat post child_female treat_post gender_post gender_treat gender_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code



	quietly eststo gen_math_lpm_11: svy: reg four_math_code treat post child_female treat_post gender_post gender_treat gender_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code
	
	

	quietly eststo gen_english_lpm_11: svy: reg four_english_code treat post child_female treat_post gender_post gender_treat gender_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code
	
	
	
restore



cd "$user/Tables"


esttab gen_read_lpm_5 gen_math_lpm_5 gen_english_lpm_5 gen_read_lpm_11 gen_math_lpm_11 gen_english_lpm_11  using ///
"triplegen.tex",  replace unstack gaps  nonumbers modelwidth(1) mgroups("5-7" "11-16", pattern(1 0 0 1 0 0) span  prefix(\multicolumn{@span}{c}{) suffix(}) ///
erepeat(\cmidrule(lr){@span})) mtitles("Reading" "Math" "English" "Reading" "Math" "English") se(%9.4f) b(%9.4f) ar2 stats(r2_a N, fmt(%9.3f %9.0f) labels("Number of Observations")) nonotes starlevels(* .10 ** .05 *** .01) keep( _cons treat post child_female treat_post  gender_treat_post gender_post gender_treat) coeflabels(treatment "Treatment" post "Post" treat_post "Treat*Post" child_female "Female" gender_post "Female*Post" gender_treat "Female*Treat" gender_treat_post "Treat*Post*Female") addnote("Note: Controls include state, presence of clinics and Anganwadis, and household toilet access") 
