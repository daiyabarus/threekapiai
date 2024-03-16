SELECT 
    TRIM(CONVERT(CHAR(20), _Q1.DATE_ID, 103)) AS DATE_ID,
    _D1.RBS_ID AS RBS,
    _Q1.UTRANCELL AS UtranCell,
    _Q1.RNC AS RNC,
    CAST(100 * (1 - (ISNULL(pmCellDowntimeAuto, 0) + ISNULL(pmCellDowntimeMan, 0)) / NULLIF(pm_count * 24 * 3600, 0)) AS DEC(19,5)) AS [3G_Cell_Availability],
	CAST(100 * ISNULL([pmNoSystemRabReleaseSpeech], 0) / NULLIF((ISNULL([pmNoSystemRabReleaseSpeech], 0) + ISNULL([pmNoNormalRabReleaseSpeech], 0)), 0) AS DEC(19,5)) AS [3G_CS_Drop_Rate],
	(pmDlTrafficVolumePsIntHs + pmDlTrafficVolumePs16 + pmDlTrafficVolumePs64 + pmDlTrafficVolumePs128 + pmDlTrafficVolumePs384 + pmUlTrafficVolumePsIntEul + pmUlTrafficVolumePs64 + pmUlTrafficVolumePs128 + pmUlTrafficVolumePs384) / 1024 AS [3G_Data_Volume_kb],
	CAST(100 * ISNULL([pmNoTimesRlAddToActSet], 0) / NULLIF((ISNULL([pmNoTimesRlAddToActSet], 0) + ISNULL([pmNoTimesCellFailAddToActSet], 0)), 0) AS DEC(19,5)) AS [3G_Mobility_Success_Rate_Soft_HOSR],
	CAST(100 * (ISNULL([pmNoSystemRabReleasePacket], 0) - ISNULL([pmNoSystemRabReleasePacketUra], 0) - ISNULL([pmChSwitchAttemptFachUra], 0) + ISNULL([pmChSwitchSuccFachUra], 0) - ISNULL([pmChSwitchAttemptDchUra], 0) + ISNULL([pmChSwitchSuccDchUra], 0) - ISNULL([pmChSwitchAttemptHsUra], 0) + ISNULL([pmChSwitchSuccHsUra], 0)) / NULLIF((ISNULL([pmNoNormalRabReleasePacket], 0) - ISNULL([pmNoNormalRabReleasePacketUra], 0) + ISNULL([pmNoSystemRabReleasePacket], 0) - ISNULL([pmNoSystemRabReleasePacketUra], 0) + ISNULL([pmChSwitchSuccFachUra], 0) + ISNULL([pmChSwitchSuccDchUra], 0) + ISNULL([pmChSwitchSuccHsUra], 0)), 0) AS DEC(19,5)) AS [3G_PS_Drop_Rate],
	CAST(100 * (ISNULL([pmNoRabEstablishSuccessSpeech], 0) / NULLIF(ISNULL([pmNoRabEstablishSuccessSpeech], 0), 0)) * (ISNULL([pmTotNoRrcConnectReqCsSucc], 0) / NULLIF((ISNULL([pmTotNoRrcConnectReqCsSucc], 0) - ISNULL([pmNoLoadSharingRrcConnCs], 0)), 0)) * (ISNULL([pmNoNormalNasSignReleaseCs], 0) / NULLIF((ISNULL([pmNoNormalNasSignReleaseCs], 0) + ISNULL([pmNoSystemNasSignReleaseCs], 0)), 0)) AS DEC(19,5)) AS [3G_RAN_CS_Accessibility],
	CAST(100 * (ISNULL([pmNoRabEstablishSuccessPacketInteractive], 0) / NULLIF(ISNULL([pmNoRabEstablishSuccessPacketInteractive], 0), 0)) * (ISNULL([pmTotNoTermRrcConnectReqPsSucc], 0) / NULLIF((ISNULL([pmTotNoTermRrcConnectReqPs], 0) - ISNULL([pmNoLoadSharingRrcConnPs], 0)), 0)) * (ISNULL([pmNoNormalNasSignReleasePs], 0) / NULLIF((ISNULL([pmNoNormalNasSignReleasePs], 0) + ISNULL([pmNoSystemNasSignReleasePs], 0)), 0)) AS DEC(19,5)) AS [3G_RAN_PS_Accessibility],
	CAST(-112 + (0.1 * (ISNULL(pmSumUlRssi, 0) / NULLIF(ISNULL(pmSamplesUlRssi, 0), 0))) AS DEC(19,5)) AS [3G_UL_RSSI],
	ISNULL((ISNULL(pmSumBestAmr12200RabEstablish, 0) + ISNULL(pmSumBestAmr5900RabEstablish, 0) + ISNULL(pmSumBestAmrWbRabEstablish, 0) + ISNULL(pmSumBestAmrNbMmRabEstablish, 0) + ISNULL(pmSumBestCs12Establish, 0)), 0) / 720 AS [3G_Voice_Erlang],
	ISNULL([pmNoSuccessOutIratHoSpeech], 0) AS [IRAT_HOSR_to_GSM],
	ISNULL((pmRedirectAttemptsEutra), 0) AS [3G_to_LTE_release_with_Redirect],
	CAST(100 * (ISNULL([pmTotNoRrcConnectSetup], 0) / NULLIF(ISNULL([pmTotNoRrcReq], 0), 0)) AS DEC(19,5)) AS [3G_RRC_success_rate],
  CAST(100* (ISNULL([pmSuccNonBlindInterlFreqHoCsSpeech],0)/ NULLIF(ISNULL([pmAttNonBlindInterFreqHoCsSpeech12]),0), 0) as DEC(19,5)) as [3G_IEF_HOSR],
	CAST(100 * (ISNULL([pmTotNoRrcConnectReqSuccess], 0) / NULLIF(ISNULL([pmTotNoRrcConnectReq], 0), 0)) AS DEC(19,5)) AS [3G_RACH_success_rate],
	CAST((ISNULL([pmSumAckedBitsSpi00], 0) + ISNULL([pmSumAckedBitsSpi01], 0) + ISNULL([pmSumAckedBitsSpi02], 0) + ISNULL([pmSumAckedBitsSpi03], 0) + ISNULL([pmSumAckedBitsSpi04], 0) + ISNULL([pmSumAckedBitsSpi05], 0) + ISNULL([pmSumAckedBitsSpi06], 0) + ISNULL([pmSumAckedBitsSpi07], 0) + ISNULL([pmSumAckedBitsSpi08], 0) + ISNULL([pmSumAckedBitsSpi09], 0) + ISNULL([pmSumAckedBitsSpi10], 0) + ISNULL([pmSumAckedBitsSpi11], 0) + ISNULL([pmSumAckedBitsSpi12], 0) + ISNULL([pmSumAckedBitsSpi13], 0) + ISNULL([pmSumAckedBitsSpi14], 0) + ISNULL([pmSumAckedBitsSpi15], 0)) / NULLIF((0.002 * ISNULL([pmSumNonEmptyUserBuffers], 0)), 0) AS DEC(19,5)) AS [3G_Downlink_Throughput_Kbps],
	CAST((ISNULL(pmSumAckedBitsCellEulTti10, 0) + ISNULL(pmSumAckedBitsCellEulTti2, 0)) / NULLIF((0.01 * ISNULL(pmNoActive10msFramesEul, 0)) + (0.002 * ISNULL(pmNoActive2msFramesEul, 0)), 0) AS DEC(19,2)) AS [3G_Uplink_Throughput_Kbps],
	(ISNULL(pmNoTimesRlAddToActSet, 0)) AS [3G_Soft_HO_attempts]


FROM (
	SELECT UTRANCELL
		,RNC
		,DATE_ID
        ,COUNT(DC.DC_E_RAN_UCELL_RAW.UtranCell) AS pm_count
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotNoTermRrcConnectReqPsSucc) AS pmTotNoTermRrcConnectReqPsSucc
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotNoRrcConnectSetup) AS pmTotNoRrcConnectSetup
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotNoRrcReq) AS pmTotNoRrcReq
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotNoTermRrcConnectReqPs) AS pmTotNoTermRrcConnectReqPs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoTimesRlDelFrActSet) AS pmNoTimesRlDelFrActSet
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumPsInteractive) AS pmSumPsInteractive
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumBestAmr5900RabEstablish) AS pmSumBestAmr5900RabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumRrcOnlyEstablish) AS pmSumRrcOnlyEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumFachPsIntRabEstablish) AS pmSumFachPsIntRabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumPsEulRabEstablish) AS pmSumPsEulRabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumBestAmr12200RabEstablish) AS pmSumBestAmr12200RabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumPsHsAdchRabEstablish) AS pmSumPsHsAdchRabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumBestAmrNbMmRabEstablish) AS pmSumBestAmrNbMmRabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoSystemRabReleasePacket) AS pmNoSystemRabReleasePacket
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoNormalRabReleasePacket) AS pmNoNormalRabReleasePacket
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoNormalRabReleaseSpeech) AS pmNoNormalRabReleaseSpeech
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoSystemRabReleaseSpeech) AS pmNoSystemRabReleaseSpeech
		,sum(DC.DC_E_RAN_UCELL_RAW.pmChSwitchSuccFachUra) AS pmChSwitchSuccFachUra
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoNormalRabReleasePacketUra) AS pmNoNormalRabReleasePacketUra
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoSystemRabReleasePacketUra) AS pmNoSystemRabReleasePacketUra
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotNoRrcConnectReqCsSucc) AS pmTotNoRrcConnectReqCsSucc
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotNoRrcConnectReqPs) AS pmTotNoRrcConnectReqPs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotNoRrcConnectReqPsSucc) AS pmTotNoRrcConnectReqPsSucc
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotNoRrcConnectReqCs) AS pmTotNoRrcConnectReqCs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoLoadSharingRrcConnCs) AS pmNoLoadSharingRrcConnCs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoLoadSharingRrcConnPs) AS pmNoLoadSharingRrcConnPs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishAttemptSpeech) AS pmNoRabEstablishAttemptSpeech
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishAttemptPacketInteractive) AS pmNoRabEstablishAttemptPacketInteractive
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishSuccessSpeech) AS pmNoRabEstablishSuccessSpeech
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishSuccessPacketInteractive) AS pmNoRabEstablishSuccessPacketInteractive
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoDirRetryAtt) AS pmNoDirRetryAtt
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumUlRssi) AS pmSumUlRssi
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSamplesUlRssi) AS pmSamplesUlRssi
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoFailedRabEstAttemptLackDlPwr) AS pmNoFailedRabEstAttemptLackDlPwr
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoFailedRabEstAttemptLackDlChnlCode) AS pmNoFailedRabEstAttemptLackDlChnlCode
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoFailedRabEstAttemptLackDlHwBest) AS pmNoFailedRabEstAttemptLackDlHwBest
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoFailedRabEstAttemptLackUlHwBest) AS pmNoFailedRabEstAttemptLackUlHwBest
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRrcReqDeniedAdmDlChnlCode) AS pmNoRrcReqDeniedAdmDlChnlCode
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRrcReqDeniedAdmDlPwr) AS pmNoRrcReqDeniedAdmDlPwr
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRrcReqDeniedAdmDlHw) AS pmNoRrcReqDeniedAdmDlHw
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRrcReqDeniedAdmUlHw) AS pmNoRrcReqDeniedAdmUlHw
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumBestCs12Establish) AS pmSumBestCs12Establish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumBestAmrWbRabEstablish) AS pmSumBestAmrWbRabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumBestPsHsAdchRabEstablish) AS pmSumBestPsHsAdchRabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumBestPsEulRabEstablish) AS pmSumBestPsEulRabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumBestDchPsIntRabEstablish) AS pmSumBestDchPsIntRabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumBestRrcOnlyEstablish) AS pmSumBestRrcOnlyEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmCellDowntimeAuto) AS pmCellDowntimeAuto
		,sum(DC.DC_E_RAN_UCELL_RAW.pmCellDowntimeMan) AS pmCellDowntimeMan
		,sum(DC.DC_E_RAN_UCELL_RAW.pmChSwitchAttemptFachUra) AS pmChSwitchAttemptFachUra
		,sum(DC.DC_E_RAN_UCELL_RAW.pmChSwitchAttemptDchUra) AS pmChSwitchAttemptDchUra
		,sum(DC.DC_E_RAN_UCELL_RAW.pmChSwitchSuccDchUra) AS pmChSwitchSuccDchUra
		,sum(DC.DC_E_RAN_UCELL_RAW.pmChSwitchAttemptHsUra) AS pmChSwitchAttemptHsUra
		,sum(DC.DC_E_RAN_UCELL_RAW.pmChSwitchSuccHsUra) AS pmChSwitchSuccHsUra
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishAttemptCs64) AS pmNoRabEstablishAttemptCs64
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishAttemptCs57) AS pmNoRabEstablishAttemptCs57
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishAttemptAmrNb) AS pmNoRabEstablishAttemptAmrNb
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishSuccessCs64) AS pmNoRabEstablishSuccessCs64
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishSuccessCs57) AS pmNoRabEstablishSuccessCs57
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishSuccessAmrNb) AS pmNoRabEstablishSuccessAmrNb
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishAttemptPacketStream) AS pmNoRabEstablishAttemptPacketStream
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishAttemptPacketStream128) AS pmNoRabEstablishAttemptPacketStream128
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishSuccessPacketStream) AS pmNoRabEstablishSuccessPacketStream
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishSuccessPacketStream128) AS pmNoRabEstablishSuccessPacketStream128
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoFailedRabEstAttemptLackUlHw) AS pmNoFailedRabEstAttemptLackUlHw
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoFailedRabEstAttemptLackDlHw) AS pmNoFailedRabEstAttemptLackDlHw
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRejRrcConnSpFlowCtrl) AS pmNoRejRrcConnSpFlowCtrl
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoSystemRabReleaseCs64) AS pmNoSystemRabReleaseCs64
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoSystemRabReleaseCsStream) AS pmNoSystemRabReleaseCsStream
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoSystemRbReleaseHs) AS pmNoSystemRbReleaseHs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoNormalRbReleaseHs) AS pmNoNormalRbReleaseHs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoNormalRabReleaseCs64) AS pmNoNormalRabReleaseCs64
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoNormalRabReleaseCsStream) AS pmNoNormalRabReleaseCsStream
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoSuccRbReconfOrigPsIntDch) AS pmNoSuccRbReconfOrigPsIntDch
		,sum(DC.DC_E_RAN_UCELL_RAW.pmUpswitchFachHsSuccess) AS pmUpswitchFachHsSuccess
		,sum(DC.DC_E_RAN_UCELL_RAW.pmUpswitchFachHsAttempt) AS pmUpswitchFachHsAttempt
		,sum(DC.DC_E_RAN_UCELL_RAW.pmPsIntHsToFachAtt) AS pmPsIntHsToFachAtt
		,sum(DC.DC_E_RAN_UCELL_RAW.pmPsIntHsToFachSucc) AS pmPsIntHsToFachSucc
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoSuccRbReconfPsIntDch) AS pmNoSuccRbReconfPsIntDch
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoCellFachDisconnectNormal) AS pmNoCellFachDisconnectNormal
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoCellFachDisconnectAbnorm) AS pmNoCellFachDisconnectAbnorm
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoHsCcAttempt) AS pmNoHsCcAttempt
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoHsCcSuccess) AS pmNoHsCcSuccess
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoSystemRbReleaseEul) AS pmNoSystemRbReleaseEul
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumDchDlRlcTotPacketThp) AS pmSumDchDlRlcTotPacketThp
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumDchDlRlcUserPacketThp) AS pmSumDchDlRlcUserPacketThp
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumDchUlRlcTotPacketThp) AS pmSumDchUlRlcTotPacketThp
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumDchUlRlcUserPacketThp) AS pmSumDchUlRlcUserPacketThp
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSamplesDchUlRlcTotPacketThp) AS pmSamplesDchUlRlcTotPacketThp
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSamplesDchDlRlcUserPacketThp) AS pmSamplesDchDlRlcUserPacketThp
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSamplesDchUlRlcUserPacketThp) AS pmSamplesDchUlRlcUserPacketThp
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSamplesBestDchPsIntRabEstablish) AS pmSamplesBestDchPsIntRabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSamplesBestPsHsAdchRabEstablish) AS pmSamplesBestPsHsAdchRabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSamplesFachPsIntRabEstablish) AS pmSamplesFachPsIntRabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoInCsIratHoSuccess) AS pmNoInCsIratHoSuccess
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoInCsIratHoAtt) AS pmNoInCsIratHoAtt
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoPagingAttemptUtranRejected) AS pmNoPagingAttemptUtranRejected
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoPagingAttemptCnInitDcch) AS pmNoPagingAttemptCnInitDcch
		,sum(DC.DC_E_RAN_UCELL_RAW.pmRlAddAttemptsBestCellPacketHigh) AS pmRlAddAttemptsBestCellPacketHigh
		,sum(DC.DC_E_RAN_UCELL_RAW.pmRlAddSuccessBestCellPacketHigh) AS pmRlAddSuccessBestCellPacketHigh
		,sum(DC.DC_E_RAN_UCELL_RAW.pmRlAddAttemptsBestCellSpeech) AS pmRlAddAttemptsBestCellSpeech
		,sum(DC.DC_E_RAN_UCELL_RAW.pmRlAddSuccessBestCellSpeech) AS pmRlAddSuccessBestCellSpeech
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishAttemptPacketInteractiveEul) AS pmNoRabEstablishAttemptPacketInteractiveEul
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishAttemptPacketInteractiveHs) AS pmNoRabEstablishAttemptPacketInteractiveHs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishSuccessPacketInteractiveEul) AS pmNoRabEstablishSuccessPacketInteractiveEul
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstablishSuccessPacketInteractiveHs) AS pmNoRabEstablishSuccessPacketInteractiveHs
		,avg(DC.DC_E_RAN_UCELL_RAW.pmSamplesUlRssi) AS AVG_pmSamplesUlRssi
		,sum(DC.DC_E_RAN_UCELL_RAW.pmDlTrafficVolumePs16) AS pmDlTrafficVolumePs16
		,sum(DC.DC_E_RAN_UCELL_RAW.pmDlTrafficVolumePsIntHs) AS pmDlTrafficVolumePsIntHs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmFaultyTransportBlocksBcUl) AS pmFaultyTransportBlocksBcUl
		,sum(DC.DC_E_RAN_UCELL_RAW.pmHsdschOverloadDetection) AS pmHsdschOverloadDetection
		,sum(DC.DC_E_RAN_UCELL_RAW.pmInDchIflsHhoAtt) AS pmInDchIflsHhoAtt
		,sum(DC.DC_E_RAN_UCELL_RAW.pmInDchIflsHhoSucc) AS pmInDchIflsHhoSucc
		,sum(DC.DC_E_RAN_UCELL_RAW.pmInHsIflsHhoAtt) AS pmInHsIflsHhoAtt
		,sum(DC.DC_E_RAN_UCELL_RAW.pmInHsIflsHhoSucc) AS pmInHsIflsHhoSucc
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoDirRetrySuccess) AS pmNoDirRetrySuccess
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoDiscardedCbsMsgOrders) AS pmNoDiscardedCbsMsgOrders
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoFailedAfterAdm) AS pmNoFailedAfterAdm
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoFailedRabEstAttemptExceedConnLimit) AS pmNoFailedRabEstAttemptExceedConnLimit
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoFailedRabEstAttemptLackDlAse) AS pmNoFailedRabEstAttemptLackDlAse
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoFailedRabEstAttemptLackUlAse) AS pmNoFailedRabEstAttemptLackUlAse
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoFailedRrcConnectReqCsHw) AS pmNoFailedRrcConnectReqCsHw
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoFailedRrcConnectReqHw) AS pmNoFailedRrcConnectReqHw
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoFailedRrcConnectReqPsHw) AS pmNoFailedRrcConnectReqPsHw
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoLoadSharingRrcConn) AS pmNoLoadSharingRrcConn
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoNormalNasSignReleaseCs) AS pmNoNormalNasSignReleaseCs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoNormalNasSignReleasePs) AS pmNoNormalNasSignReleasePs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoOfNonHoReqDeniedEul) AS pmNoOfNonHoReqDeniedEul
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoOfNonHoReqDeniedHs) AS pmNoOfNonHoReqDeniedHs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoOfNonHoReqDeniedInteractive) AS pmNoOfNonHoReqDeniedInteractive
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoOfNonHoReqDeniedSpeech) AS pmNoOfNonHoReqDeniedSpeech
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoOfReturningRrcConn) AS pmNoOfReturningRrcConn
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoOfSwDownNgAdm) AS pmNoOfSwDownNgAdm
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoOfSwDownNgCong) AS pmNoOfSwDownNgCong
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoOfTermSpeechCong) AS pmNoOfTermSpeechCong
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstBlockNodePsIntHsBest) AS pmNoRabEstBlockNodePsIntHsBest
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstBlockNodeSpeechBest) AS pmNoRabEstBlockNodeSpeechBest
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstBlockTnPsIntHsBest) AS pmNoRabEstBlockTnPsIntHsBest
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRabEstBlockTnSpeechBest) AS pmNoRabEstBlockTnSpeechBest
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRejRrcConnMpLoadC) AS pmNoRejRrcConnMpLoadC
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoReqDeniedAdm) AS pmNoReqDeniedAdm
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRlDeniedAdm) AS pmNoRlDeniedAdm
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRrcConnReqBlockNodeCs) AS pmNoRrcConnReqBlockNodeCs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRrcConnReqBlockNodePs) AS pmNoRrcConnReqBlockNodePs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRrcConnReqBlockTnCs) AS pmNoRrcConnReqBlockTnCs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRrcConnReqBlockTnPs) AS pmNoRrcConnReqBlockTnPs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRrcCsReqDeniedAdm) AS pmNoRrcCsReqDeniedAdm
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRrcPsReqDeniedAdm) AS pmNoRrcPsReqDeniedAdm
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoRrcReqDeniedAdm) AS pmNoRrcReqDeniedAdm
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoSysRelSpeechNeighbr) AS pmNoSysRelSpeechNeighbr
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoSysRelSpeechSoHo) AS pmNoSysRelSpeechSoHo
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoSysRelSpeechUlSynch) AS pmNoSysRelSpeechUlSynch
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoSystemNasSignReleaseCs) AS pmNoSystemNasSignReleaseCs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoSystemNasSignReleasePs) AS pmNoSystemNasSignReleasePs
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoTimesCellFailAddToActSet) AS pmNoTimesCellFailAddToActSet
		,sum(DC.DC_E_RAN_UCELL_RAW.pmNoTimesRlAddToActSet) AS pmNoTimesRlAddToActSet
		,sum(DC.DC_E_RAN_UCELL_RAW.pmOutDchIflsHhoAtt) AS pmOutDchIflsHhoAtt
		,sum(DC.DC_E_RAN_UCELL_RAW.pmOutDchIflsHhoSuccess) AS pmOutDchIflsHhoSuccess
		,sum(DC.DC_E_RAN_UCELL_RAW.pmOutHsIflsHhoAtt) AS pmOutHsIflsHhoAtt
		,sum(DC.DC_E_RAN_UCELL_RAW.pmOutHsIflsHhoSucc) AS pmOutHsIflsHhoSucc
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSamplesBestCs12Establish) AS pmSamplesBestCs12Establish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSamplesDlCode) AS pmSamplesDlCode
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumActiveDriftUesBestCell) AS pmSumActiveDriftUesBestCell
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumActiveUesBestCell) AS pmSumActiveUesBestCell
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumAmr12200RabEstablish) AS pmSumAmr12200RabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumAmr5900RabEstablish) AS pmSumAmr5900RabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumAmrNbMmRabEstablish) AS pmSumAmrNbMmRabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumBestAmr4750RabEstablish) AS pmSumBestAmr4750RabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumBestAmr7950RabEstablish) AS pmSumBestAmr7950RabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumBestCs57RabEstablish) AS pmSumBestCs57RabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumBestCs64RabEstablish) AS pmSumBestCs64RabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumCompMode) AS pmSumCompMode
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumDlCode) AS pmSumDlCode
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumOfTimesMeasOlDl) AS pmSumOfTimesMeasOlDl
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSumOfTimesMeasOlUl) AS pmSumOfTimesMeasOlUl
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotalTimeDlCellCong) AS pmTotalTimeDlCellCong
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotalTimeHsdschOverload) AS pmTotalTimeHsdschOverload
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotalTimeUlCellCong) AS pmTotalTimeUlCellCong
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotNoRrcConnectReq) AS pmTotNoRrcConnectReq
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotNoRrcConnectReqSuccess) AS pmTotNoRrcConnectReqSuccess
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotNoTermRrcConnectReq) AS pmTotNoTermRrcConnectReq
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotNoTermRrcConnectReqSucc) AS pmTotNoTermRrcConnectReqSucc
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTotNoUtranRejRrcConnReq) AS pmTotNoUtranRejRrcConnReq
		,sum(DC.DC_E_RAN_UCELL_RAW.pmTransportBlocksBcUl) AS pmTransportBlocksBcUl
		,sum(DC.DC_E_RAN_UCELL_RAW.pmUlTrafficVolumePs128) AS pmUlTrafficVolumePs128
		,sum(DC.DC_E_RAN_UCELL_RAW.pmUlTrafficVolumePs16) AS pmUlTrafficVolumePs16
		,sum(DC.DC_E_RAN_UCELL_RAW.pmUlTrafficVolumePs384) AS pmUlTrafficVolumePs384
		,sum(DC.DC_E_RAN_UCELL_RAW.pmUlTrafficVolumePs64) AS pmUlTrafficVolumePs64
		,sum(DC.DC_E_RAN_UCELL_RAW.pmUlTrafficVolumePsIntEul) AS pmUlTrafficVolumePsIntEul
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSamplesDchDlRlcTotPacketThp) AS pmSamplesDchDlRlcTotPacketThp
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSamplesBestRrcOnlyEstablish) AS pmSamplesBestRrcOnlyEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSamplesBestAmrWbRabEstablish) AS pmSamplesBestAmrWbRabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSamplesBestAmrNbMmRabEstablish) AS pmSamplesBestAmrNbMmRabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.pmSamplesBestPsEulRabEstablish) AS pmSamplesBestPsEulRabEstablish
		,sum(DC.DC_E_RAN_UCELL_RAW.PERIOD_DURATION) AS PERIOD_DURATION
		,sum(DC.DC_E_RAN_UCELL_RAW.pmDlTrafficVolumePs128) AS pmDlTrafficVolumePs128
		,sum(DC.DC_E_RAN_UCELL_RAW.pmDlTrafficVolumePs384) AS pmDlTrafficVolumePs384
		,sum(DC.DC_E_RAN_UCELL_RAW.pmDlTrafficVolumePs64) AS pmDlTrafficVolumePs64
		,sum(DC.DC_E_RAN_UCELL_RAW.pmDlTrafficVolumePsCommon) AS pmDlTrafficVolumePsCommon
		,sum(DC.DC_E_RAN_UCELL_RAW.pmUlTrafficVolumePsCommon) AS pmUlTrafficVolumePsCommon
		,sum(DC.DC_E_RAN_UCELL_RAW.pmRedirectAttemptsEutra) AS pmRedirectAttemptsEutra
	FROM DC.DC_E_RAN_UCELL_RAW
	GROUP BY UTRANCELL
		,RNC
		,DATE_ID
	) _Q1,
    
    (
		SELECT UTRANCELL
			,RNC
			,DATE_ID
			,sum(DC.DC_E_RAN_GSMREL_RAW.pmNoAttOutIratHoSpeech) AS pmNoAttOutIratHoSpeech
			,sum(DC.DC_E_RAN_GSMREL_RAW.pmNoSuccessOutIratHoSpeech) AS pmNoSuccessOutIratHoSpeech
			,sum(DC.DC_E_RAN_GSMREL_RAW.pmNoSuccessOutSbHoSpeech) AS pmNoSuccessOutSbHoSpeech
			,sum(DC.DC_E_RAN_GSMREL_RAW.pmNoAttOutSbHoSpeech) AS pmNoAttOutSbHoSpeech
			,sum(DC.DC_E_RAN_GSMREL_RAW.pmNoOutIratCcSuccess) AS pmNoOutIratCcSuccess
			,sum(DC.DC_E_RAN_GSMREL_RAW.pmNoOutIratCcAtt) AS pmNoOutIratCcAtt
		FROM DC.DC_E_RAN_GSMREL_RAW
		GROUP BY UTRANCELL
			,RNC
			,DATE_ID
	) _Q2,
    
    (
		SELECT UTRANCELL
			,RNC
			,DATE_ID
			,sum(DC.DC_E_RAN_HSDSCH_RAW.pmSumHsDlRlcTotPacketThp) AS pmSumHsDlRlcTotPacketThp
			,sum(DC.DC_E_RAN_HSDSCH_RAW.pmSamplesHsDlRlcTotPacketThp) AS pmSamplesHsDlRlcTotPacketThp
			,sum(DC.DC_E_RAN_HSDSCH_RAW.pmSumHsDlRlcUserPacketThp) AS pmSumHsDlRlcUserPacketThp
			,sum(DC.DC_E_RAN_HSDSCH_RAW.pmSamplesHsDlRlcUserPacketThp) AS pmSamplesHsDlRlcUserPacketThp
		FROM DC.DC_E_RAN_HSDSCH_RAW
		GROUP BY UTRANCELL
			,RNC
			,DATE_ID
	) _Q3,
    
    (
		SELECT UTRANCELL
			,RNC
			,DATE_ID
			,sum(DC.DC_E_RAN_EUL_RAW.pmSumEulRlcTotPacketThp) AS pmSumEulRlcTotPacketThp
			,sum(DC.DC_E_RAN_EUL_RAW.pmSamplesEulRlcTotPacketThp) AS pmSamplesEulRlcTotPacketThp
			,sum(DC.DC_E_RAN_EUL_RAW.pmSumEulRlcUserPacketThp) AS pmSumEulRlcUserPacketThp
			,sum(DC.DC_E_RAN_EUL_RAW.pmSamplesEulRlcUserPacketThp) AS pmSamplesEulRlcUserPacketThp
		FROM DC.DC_E_RAN_EUL_RAW
		GROUP BY UTRANCELL
			,RNC
			,DATE_ID
	) _Q4,
    
	(
		SELECT DISTINCT RBS_ID, UCELL_NAME
		FROM DC.DIM_E_RAN_UCELL
		WHERE STATUS = 'ACTIVE'
			AND RBS_ID <> ''
	) _D1,

    (
		SELECT UTRANCELL
			,RNC
			,DATE_ID
			,sum(DC.DC_E_RAN_UREL_RAW.pmSuccNonBlindInterFreqHoCsSpeech12) AS pmSuccNonBlindInterFreqHoCsSpeech12
			,sum(DC.DC_E_RAN_UREL_RAW.pmAttNonBlindInterFreqHoCsSpeech12) AS pmAttNonBlindInterFreqHoCsSpeech12
		FROM DC.DC_E_RAN_UREL_RAW
		GROUP BY UTRANCELL
			,RNC
			,DATE_ID
	) _Q5,
    
    (
		SELECT DC.DIM_E_RAN_UCELL.UCELL_NAME AS UTRANCELL
			,DC.DC_E_RBS_EDCHRESOURCES_RAW.RNC AS RNC
			,DC.DC_E_RBS_EDCHRESOURCES_RAW.DATE_ID AS DATE_ID
			,sum(DC.DC_E_RBS_EDCHRESOURCES_RAW.pmNoActive10msFramesEul) AS pmNoActive10msFramesEul
			,sum(DC.DC_E_RBS_EDCHRESOURCES_RAW.pmNoActive2msFramesEul) AS pmNoActive2msFramesEul
			,sum(DC.DC_E_RBS_EDCHRESOURCES_RAW.pmSumAckedBitsCellEulTti10) AS pmSumAckedBitsCellEulTti10
			,sum(DC.DC_E_RBS_EDCHRESOURCES_RAW.pmSumAckedBitsCellEulTti2) AS pmSumAckedBitsCellEulTti2
		FROM DC.DIM_E_RAN_UCELL
			,DC.DC_E_RBS_EDCHRESOURCES_RAW
			,DC.DIM_E_RAN_RBSLOCALCELL
		WHERE 
			(DC.DIM_E_RAN_UCELL.LOCALCellID = DC.DIM_E_RAN_RBSLOCALCELL.RBSLOCALCELL_ID)
			AND (DC.DIM_E_RAN_UCELL.OSS_ID = DC.DIM_E_RAN_RBSLOCALCELL.OSS_ID)
			AND (DC.DIM_E_RAN_UCELL.RBS_ID = DC.DIM_E_RAN_RBSLOCALCELL.RBS_ID)
			AND (DC.DIM_E_RAN_UCELL.RNC_ID = DC.DIM_E_RAN_RBSLOCALCELL.RNC_ID)
			AND (DC.DC_E_RBS_EDCHRESOURCES_RAW.Carrier = DC.DIM_E_RAN_RBSLOCALCELL.Carrier)
			AND (DC.DC_E_RBS_EDCHRESOURCES_RAW.OSS_ID = DC.DIM_E_RAN_RBSLOCALCELL.OSS_ID)
			AND (DC.DC_E_RBS_EDCHRESOURCES_RAW.RBS = DC.DIM_E_RAN_RBSLOCALCELL.RBS_ID)
			AND (DC.DC_E_RBS_EDCHRESOURCES_RAW.RNC = DC.DIM_E_RAN_RBSLOCALCELL.RNC_ID)
			AND (DC.DC_E_RBS_EDCHRESOURCES_RAW.Sector = DC.DIM_E_RAN_RBSLOCALCELL.Sector)
		GROUP BY DC.DIM_E_RAN_UCELL.UCELL_NAME
			,DC.DC_E_RBS_EDCHRESOURCES_RAW.RNC
			,DC.DC_E_RBS_EDCHRESOURCES_RAW.DATE_ID
	) _Q6,
    
    (
		SELECT
			  DC.DIM_E_RAN_UCELL.UCELL_NAME  AS UTRANCELL,
			  DC.DC_E_RBS_HSDSCHRES_RAW.RNC AS RNC,
			  DC.DC_E_RBS_HSDSCHRES_RAW.DATE_ID AS DATE_ID,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi00) AS pmSumAckedBitsSpi00,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi01) AS pmSumAckedBitsSpi01,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi02) AS pmSumAckedBitsSpi02,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi03) AS pmSumAckedBitsSpi03,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi04) AS pmSumAckedBitsSpi04,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi05) AS pmSumAckedBitsSpi05,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi06) AS pmSumAckedBitsSpi06,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi07) AS pmSumAckedBitsSpi07,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi08) AS pmSumAckedBitsSpi08,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi09) AS pmSumAckedBitsSpi09,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi10) AS pmSumAckedBitsSpi10,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi11) AS pmSumAckedBitsSpi11,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi12) AS pmSumAckedBitsSpi12,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi13) AS pmSumAckedBitsSpi13,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi14) AS pmSumAckedBitsSpi14,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumAckedBitsSpi15) AS pmSumAckedBitsSpi15,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmNoActiveSubFrames) AS pmNoActiveSubFrames,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmNoInactiveRequiredSubFrames) AS pmNoInactiveRequiredSubFrames,
			  sum(DC.DC_E_RBS_HSDSCHRES_RAW.pmSumNonEmptyUserBuffers) AS pmSumNonEmptyUserBuffers
		FROM
			  DC.DC_E_RBS_HSDSCHRES_RAW,
			  DC.DIM_E_RAN_UCELL,			  
			  DC.DIM_E_RAN_RBSLOCALCELL
		WHERE
			  ( DC.DIM_E_RAN_UCELL.LOCALCellID=DC.DIM_E_RAN_RBSLOCALCELL.RBSLOCALCELL_ID  )
			  AND  ( DC.DIM_E_RAN_UCELL.OSS_ID=DC.DIM_E_RAN_RBSLOCALCELL.OSS_ID  )
			  AND  ( DC.DIM_E_RAN_UCELL.RBS_ID=DC.DIM_E_RAN_RBSLOCALCELL.RBS_ID  )
			  AND  ( DC.DIM_E_RAN_UCELL.RNC_ID=DC.DIM_E_RAN_RBSLOCALCELL.RNC_ID  )
			  AND  ( DC.DC_E_RBS_HSDSCHRES_RAW.Carrier=DC.DIM_E_RAN_RBSLOCALCELL.Carrier  )
			  AND  ( DC.DC_E_RBS_HSDSCHRES_RAW.OSS_ID=DC.DIM_E_RAN_RBSLOCALCELL.OSS_ID  )
			  AND  ( DC.DC_E_RBS_HSDSCHRES_RAW.RBS=DC.DIM_E_RAN_RBSLOCALCELL.RBS_ID  )
			  AND  ( DC.DC_E_RBS_HSDSCHRES_RAW.RNC=DC.DIM_E_RAN_RBSLOCALCELL.RNC_ID  )
			  AND  ( DC.DC_E_RBS_HSDSCHRES_RAW.Sector=DC.DIM_E_RAN_RBSLOCALCELL.Sector  )
		GROUP BY
			  DC.DIM_E_RAN_UCELL.UCELL_NAME,
			  DC.DC_E_RBS_HSDSCHRES_RAW.RNC,
			  DC.DC_E_RBS_HSDSCHRES_RAW.DATE_ID
	) _Q7

WHERE _Q1.UTRANCELL *= _Q2.UTRANCELL
	AND _Q1.RNC *= _Q2.RNC
	AND _Q1.DATE_ID *= _Q2.DATE_ID
	AND _Q1.UTRANCELL *= _Q3.UTRANCELL
	AND _Q1.RNC *= _Q3.RNC
	AND _Q1.DATE_ID *= _Q3.DATE_ID
	AND _Q1.UTRANCELL *= _Q4.UTRANCELL
	AND _Q1.RNC *= _Q4.RNC
	AND _Q1.DATE_ID *= _Q4.DATE_ID	
	AND _Q1.UTRANCELL *= _Q5.UTRANCELL
	AND _Q1.RNC *= _Q5.RNC
	AND _Q1.DATE_ID *= _Q5.DATE_ID	
	AND _Q1.UTRANCELL *= _Q6.UTRANCELL
	AND _Q1.RNC *= _Q6.RNC
	AND _Q1.DATE_ID *= _Q6.DATE_ID
	AND _Q1.UTRANCELL *= _Q7.UTRANCELL
	AND _Q1.RNC *= _Q7.RNC
	AND _Q1.DATE_ID *= _Q7.DATE_ID
	AND _Q1.UTRANCELL *= _D1.UCELL_NAME
	AND (_Q1.DATE_ID BETWEEN '2024-02-26' and '2024-03-11')
	AND (
		_Q1.RNC like 'MS1RNC1' or
		_Q1.RNC like 'TO3RNC1' or
		_Q1.RNC like 'VAURNC9' or
		_Q1.RNC like 'MO1RNC1' or
		_Q1.RNC like 'TO5RNC1' or
		_Q1.RNC like 'HA1RNC1' or
		_Q1.RNC like 'ML2RNC1' or
		_Q1.RNC like 'BR1RNC1' or
		_Q1.RNC like 'VAURNC8' or
		_Q1.RNC like 'OT1RNC1'
	)

order by _Q1.DATE_ID, _Q1.RNC, _Q1.UTRANCELL;
