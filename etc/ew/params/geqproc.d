
# Configuration file for geqproc
#
# Alternate head of mega-module not unlike eqproc or eqprelim.
# We pick up TYPE_LOC_GLOBAL from the input ring (as output by global_proc),
# convert to TYPE_HYP2000ARC, and then pass along the pipe.  There
# is no throttle or waiting to make sure this is the "final" version
# as that task is assumed to be performed elsewhere such as in global_proc.
# 
# Note also that we throw out any arrivals not suitable for Hypo (e.g. depth
# phases).  This is dangerous and could result in a solution considerably
# less accurate than the original.  It is concommitant upon the user to
# assure that geqproc is attached to a ring that only has global loc
# messages for areas with dense station coverage for which picks are
# included in the incoming message.  eqfilterII may be used for this task.

LogFile 1     # 0 means don't create a disc log file. 1=> do.
              # 2 means write to module log but not to stderr/stdout
MyModuleId MOD_GEQPROC
InRing     GLOBAL_RING
OutRing    HYPO_RING
HeartBeatInt 30
PipeTo "eqbuf eqbuf.d"

#
# Optional Debug switch - if this is uncommented
# lots of debug messages will be produced 
#
Debug

# What message logos to listen to. Can be more than one, but no more
# than five.
# The type is one of TYPE_LOC_GLOBAL, no choice

GetEventsFrom INST_WILDCARD MOD_GLOBALPROC # TYPE_LOC_GLOBAL

