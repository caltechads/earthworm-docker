#
#  mseedarchiver configuration file
#
 MyModuleId     MOD_EWMSEEDARCHIVER   # module id for this program
 RingName       WAVE_MSEED          # transport ring to use for input

 MaxOpenFiles   100                 # maximum number of open files, should be set to
                                    # the number of files being actively written at
                                    # any given time.

 HeartBeatInt   30                  # EW internal heartbeat interval (sec)
 LogFile        1                   # If 0, don't write logfile; if 1, do
                                    # if 2, write to module log but not to 
                                    # stderr/stdout
#
# Logos of messages to process, only TYPE_MSEED
#              Installation       Module       Message Type
 GetMsgLogo    INST_WILDCARD   MOD_WILDCARD    TYPE_MSEED
 
 MaxMsgSize     4096          # maximum size (bytes) for input/output msgs
 QueueSize	 400          # max# messages in outgoing circular msg buffer

#
# Optional parameters
#
#Verbosity  0                 # set verbosity, useful for diagnostics

# List of station/channel/network/loc codes to process.
#--------------------------------------------------------
#
# Use any combination of Send_scnl (to send data as-is) and
#   Send_scnl_remap (to change the SCNL on the fly) commands.
# Use * as a wildcard for any field. A wildcard in the
#   "map to" fields of Send_scnl_remap means that field will
#   not be renamed.
#
#                  send SCNL     map to SCNL
# Send_scnl       JMP ASZ NC 01                # send this specific channel
# Send_scnl       JPS *   NC *                 # send all components of JPS NC
# Send_scnl_remap JGR VHZ NC --   *   EHZ * *  # change component code only
# Send_scnl_remap CAL *   NC *    ALM *   * *  # send all component of CAL, but
                                               # change the station code to ALM
Send_scnl * * * *

#
# Define archive(s), locations to write out miniSEED records.
#
# Archive definitions can contain substitution flags that are evaluated
# for each miniSEED record.  For a full list of substitution flags read
# the overview below.  More than one archive definition may be specified.
#
#Archive /data/archive/%n/%s/%Y.%j.%n.%s.%l.%c.mseed
# Windows example (may use backslashes or forward slashes):
#Archive D:\data\archive\%n\%s\%Y.%j.%n.%s.%l.%c.mseed
#


# An archive format is expanded for each record using the following
# substitution flags:
# 
#   n : network code, white space removed
#   s : station code, white space removed
#   l : location code, white space removed
#   c : channel code, white space removed
#   Y : year, 4 digits
#   y : year, 2 digits zero padded
#   j : day of year, 3 digits zero padded
#   H : hour, 2 digits zero padded
#   M : minute, 2 digits zero padded
#   S : second, 2 digits zero padded
#   F : fractional seconds, 4 digits zero padded
#   q : single character record quality indicator (D, R, Q, M)
#   L : data record length in bytes
#   r : sample rate (Hz) as a rounded integer
#   R : sample rate (Hz) as a float with 6 digit precision
#   % : the percent (%) character
#   # : the number (#) character
# 
# The flags are prefaced with either the "%" or "#" modifier.
# The "%" modifier indicates a defining flag while the "#"
# indicates a non-defining flag.  All records with the same set of
# defining flags will be written to the same file.  Non-defining flags
# will be expanded using the values in the first record for the
# resulting file name.
# 
# Time flags are based on the start time of the given record.
#
# EXAMPLES
# 
# The format string for the predefined BUD layout:
# 
# /archive/%n/%s/%s.%n.%l.%c.%Y.%j
# 
# would expand to day length files named something like:
# 
# /archive/NL/HGN/HGN.NL..BHE.2003.055
# 
# As an example of using non-defining flags the format string for the
# predefined CSS layout:
# 
# /data/%Y/%j/%s.%c.%Y:%j:#H:#M:#S
# 
# would expand to:
# 
# /data/2003/055/HGN.BHE.2003:055:14:17:54
# 
# resulting in day length files because the hour, minute and second are
# specified with the non-defining modifier.  The hour, minute and second
# fields are from the first record in the file.
