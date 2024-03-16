class Flag:
    @staticmethod
    def flag5_inc():
        return [
            "3G_Cell_Availability",
            "3G_Mobility_Success_Rate_Soft_HOSR",
            "3G_RAN_CS_Accessibility",
            "3G_RAN_PS_Accessibility",
            "3G_RACH_success_rate",
            "Average_Reported_CQI",
        ]

    @staticmethod
    def flag5_dcr():
        return [
            "3G_CS_Drop_Rate",
            "3G_PS_Drop_Rate",
            "3G_UL_RSSI",
        ]

    @staticmethod
    def mockpi_agg_list():
        return [
            "3G_Cell_Availability",
            "3G_CS_Drop_Rate",
            "3G_Mobility_Success_Rate_Soft_HOSR",
            "3G_PS_Drop_Rate",
            "3G_RAN_CS_Accessibility",
            "3G_RAN_PS_Accessibility",
            "3G_UL_RSSI",
            "3G_RRC_success_rate",
            "3G_RACH_success_rate",
            "3G_Downlink_Throughput_Kbps",
            "3G_Uplink_Throughput_Kbps",
        ]

    @staticmethod
    def mockpi_sum_list():
        return [
            "3G_Data_Volume_kb",
            "3G_Voice_Erlang",
            "IRAT_HOSR_to_GSM",
            "3G_to_LTE_release_with_Redirect",
            "3G_Soft_HO_attempts",
        ]


# """
# 3G_Cell_Availability
# 3G_CS_Drop_Rate
# 3G_Data_Volume_kb
# 3G_Mobility_Success_Rate_Soft_HOSR
# 3G_PS_Drop_Rate
# 3G_RAN_CS_Accessibility
# 3G_RAN_PS_Accessibility
# 3G_UL_RSSI
# 3G_Voice_Erlang
# IRAT_HOSR_to_GSM
# 3G_to_LTE_release_with_Redirect
# 3G_RRC_success_rate
# 3G_RACH_success_rate
# 3G_Downlink_Throughput_Kbps
# 3G_Uplink_Throughput_Kbps
# 3G_Soft_HO_attempts
#
# """
