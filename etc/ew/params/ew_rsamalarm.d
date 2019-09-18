TreatAsIni
LogFile 1
MaxMsgSize 50000

[RSAM]
AlarmSubnet	Alpha
InputRing	SCN_RING
OutputRing	PICK_RING

[StationDefaults]
TriggerParameters	50 2 10 180 True
EventAlarmTracker	50 2 30 180 False
TremorAlarmTracker	50 2 1200 5400 False

[Alpha]
StationsNecessaryForTremorAlarm 3
TremorAlarmEnabled False
EventAlarmEnabled False
StationsNecessaryForEventAlarm 3
CheckInhibitStationsDelay 0
EventAlarmResetTime 1
TremorAlarmResetTime 10
Station RDE:EHZ:AV
Station RDN:EHZ:AV
Station RDT:EHZ:AV
Station RDW:BHZ:AV
Station RDWB:BHZ:AV
Station RED:EHZ:AV
Station REF:EHZ:AV
Station RSO:EHZ:AV

[trRing_General]
InstId INST_AVO
ModuleId MOD_EWRSAMALARM
DefaultRingSize 1000000
TransportIdFile c:\Earthworm\run\params\earthworm_global.d
HeartbeatRing TEST_RING
HeartbeatInterval 60
ActiveRing TEST_RING


[RDE:EHZ:AV]
[RDN:EHZ:AV]
[RDT:EHZ:AV]
[RDW:BHZ:AV]
[RDWB:BHZ:AV]
UseAsInhibitor True
[RED:EHZ:AV]
[REF:EHZ:AV]
[RSO:EHZ:AV]
