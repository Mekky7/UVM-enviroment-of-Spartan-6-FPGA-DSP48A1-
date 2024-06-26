quit -sim
vcover report DSP_DB.ucdb -all -annotate -details -output dsp_coverage.txt
coverage report -output functional_coverage_report.txt -srcfile=* -detail -option -directive -cvg
