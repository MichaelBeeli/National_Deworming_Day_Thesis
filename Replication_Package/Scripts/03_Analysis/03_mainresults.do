// National Deworming Day Replication Package
// Author: Michael Beeli 
// Section: Analysis
// Function: Main Results Table 





cd "$user/Tables"

esttab read_lpm_5 math_lpm_5 english_lpm_5 read_log_5 math_log_5 english_log_5  using ///
"mainresults.tex",  replace unstack  nonumbers compress modelwidth(1) mgroups("Linear Model" "Logit Model", pattern(1 0 0 1 0 0) span  prefix(\multicolumn{@span}{c}{) suffix(}) ///
erepeat(\cmidrule(lr){@span})) mtitles("Reading" "Math" "English" "Reading" "Math" "English") se(%9.4f) b(%9.4f) ar2 stats(r2_a N, fmt(%9.3f %9.0f) labels("Adjusted R Squared" "Number of Observations")) nonotes starlevels(* .10 ** .05 *** .01) keep( _cons treat post treat_post) coeflabels(treatment "5-7: Treatment" post "5-7: Post" treat_post "5-7: Treat*Post") addnote("Note: Controls include state, presence of clinics and Anganwadis, and household toilet access")



esttab read_lpm_11 math_lpm_11 english_lpm_11 read_log_11 math_log_11 english_log_11  using ///
"mainresults.tex",  append unstack  nonumbers compress modelwidth(1) mgroups("Linear Model" "Logit Model", pattern(1 0 0 1 0 0) span  prefix(\multicolumn{@span}{c}{) suffix(}) ///
erepeat(\cmidrule(lr){@span})) mtitles("Reading" "Math" "English" "Reading" "Math" "English") se(%9.4f) b(%9.4f) ar2 stats(r2_a N, fmt(%9.3f %9.0f) labels("Adjusted R Squared" "Number of Observations")) nonotes starlevels(* .10 ** .05 *** .01) keep( _cons treat post treat_post) coeflabels(treatment "8-10: Treatment" post "8-10: Post" treat_post "8-10: Treat*Post") addnote("Note: Controls include state, presence of clinics and Anganwadis, and household toilet access")

