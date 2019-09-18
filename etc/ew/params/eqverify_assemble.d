
#
# This is eqverify_assemble's parameter file
#
MyModuleId  MOD_EQPROC  # module id to label logfile  with.
                        # Note: eqverify_assemble is part of a mega-module 
                        # which is ultimately started by the program eqproc.
                        # All child processes of this mega-module need to use 
                        # the same module id (thus use eqproc's module id).
LogFile       1         # 0=no log; 1=log errors
                        # 2=write to moduel log but not to stderr/stdout
# send output to the following command:
 PipeTo "log_everything"
# PipeTo "hypo_mgr hypo_mgr.d ncal.hyp"

# Required commands to turn glitch tests on or off.
# Specify the minimum version (from eqassemble) for
# which a test should be run.
# eqassemble versions are: Prelim: 0; Rapid: 1; Final: 2
# specify 3 to turn off a test for all versions
test_slopevsmag  2
test_freefitrms  2
test_codawt      2
test_pgroup      1

# event weight at which event is "noise" for Prelim (version 0), 
# Rapid (version 1) or Final (version 2) reports from eqassemble
PrelimThreshold     1   
RapidThreshold	    1	
FinalThreshold	    3 

# Optional commands that change eqverify_assemble test defaults
# force_report  18 2.0    # report events with more than 18 picks
#                         # and mag>=2.0 regardless of event weight
# define_glitch  4 0.03   # a glitch is at least 4 picks within
                          # 0.03 seconds
# MaxDeltaT         30.   # consider arrival times within this many
#                         # seconds of the 1st arriving pick
# coda_clip        820    # level at which a coda-avg-absolute-value
#                         # is clipped (see notes in eqcoda.command)
