class KPIResultCounter:
    def __init__(
        self,
        cell_data,
        mockpi,
        kpi_process_result,
        rawdaily_data,
        rawdaily_col,
    ):
        self.cell_data = cell_data
        self.mockpi = mockpi
        self.kpi_process_result = kpi_process_result
        self.rawdaily_data = rawdaily_data
        self.rawdaily_col = rawdaily_col

    def _get_rnc_mapping(self):
        rnc_mapping = {}
        for raw_data in self.rawdaily_data[1:]:
            cell_name = raw_data[self.rawdaily_col.get("UtranCell", 4)]
            rnc = raw_data[self.rawdaily_col.get("RNC", 2)]
            if cell_name in self.cell_data:
                rnc_mapping.setdefault(rnc, set()).add(cell_name)
        return rnc_mapping

    def _utrancell_by_rnc(self):
        utrancell_count_by_rnc = {}
        for raw_data in self.rawdaily_data[1:]:
            rnc = raw_data[self.rawdaily_col.get("RNC", 2)]
            utrancell_count_by_rnc[rnc] = utrancell_count_by_rnc.get(rnc, 0) + 1
        return utrancell_count_by_rnc

    def count_summary(self):
        rnc_mapping = self._get_rnc_mapping()
        cells_in_rnc = self._utrancell_by_rnc()
        result_summary = []

        for rnc, cells in rnc_mapping.items():
            total_cells = len(cells)
            rnc_cell_count = cells_in_rnc.get(rnc, 0)
            remark = ""
            degraded_count = 0
            improved_count = 0
            maintain_count = 0
            degraded_10_to_20 = 0
            degraded_20_to_30 = 0
            degraded_above_30 = 0

            for result in self.kpi_process_result:
                cell_name = result[2]
                mockpi = result[3]
                if cell_name in cells and mockpi == self.mockpi:
                    flag_result_one_week = result[23]
                    delta_percent = result[22]

                    if flag_result_one_week == "Degrade":
                        degraded_count += 1
                        if delta_percent > 10 and delta_percent <= 20:
                            degraded_10_to_20 += 1
                        elif delta_percent > 20 and delta_percent <= 30:
                            degraded_20_to_30 += 1
                        elif delta_percent > 30:
                            degraded_above_30 += 1
                    elif flag_result_one_week == "Improve":
                        improved_count += 1
                    elif flag_result_one_week == "Maintain":
                        maintain_count += 1

            def percent_cells(count):
                return (count / total_cells) * 100 if total_cells > 0 else 0

            def percent_rnc(count, rnc_count):
                return (count / rnc_count) * 100 if rnc_count > 0 else 0

            cells_degrade_percent = percent_cells(degraded_count)
            rnc_degrade_percent = percent_rnc(degraded_count, rnc_cell_count)
            cells_improve_percent = percent_cells(improved_count)
            rnc_improve_percent = percent_rnc(improved_count, rnc_cell_count)
            cells_maintain_percent = percent_cells(maintain_count)
            rnc_maintain_percent = percent_rnc(maintain_count, rnc_cell_count)
            degraded_10_to_20_percentage = percent_cells(degraded_10_to_20)
            rnc_10_to_20_percentage = percent_rnc(degraded_10_to_20, rnc_cell_count)
            degraded_20_to_30_percentage = percent_cells(degraded_20_to_30)
            rnc_20_to_30_percentage = percent_rnc(degraded_20_to_30, rnc_cell_count)
            degraded_above_30_percentage = percent_cells(degraded_above_30)
            rnc_above_30_percentage = percent_rnc(degraded_above_30, rnc_cell_count)

            if cells_degrade_percent > cells_maintain_percent:
                if degraded_above_30_percentage > (
                    degraded_10_to_20_percentage + degraded_20_to_30_percentage
                ):
                    remark = "Major Degrade"
                elif degraded_20_to_30_percentage > (
                    degraded_above_30_percentage + degraded_10_to_20_percentage
                ):
                    remark = "Avg Degrade"
                elif degraded_10_to_20_percentage > (
                    degraded_above_30_percentage + degraded_20_to_30_percentage
                ):
                    remark = "Slight Degrade"

            elif cells_maintain_percent > cells_degrade_percent:
                if degraded_above_30_percentage > (
                    degraded_10_to_20_percentage + degraded_20_to_30_percentage
                ):
                    remark = "Maintain With Major Degrade"
                elif degraded_20_to_30_percentage > (
                    degraded_above_30_percentage + degraded_10_to_20_percentage
                ):
                    remark = "Maintain With Avg Degrade"
                elif degraded_10_to_20_percentage > (
                    degraded_above_30_percentage + degraded_20_to_30_percentage
                ):
                    remark = "Maintain With Slight Degrade"

            elif cells_improve_percent > cells_degrade_percent:
                if degraded_above_30_percentage > (
                    degraded_10_to_20_percentage + degraded_20_to_30_percentage
                ):
                    remark = "Improve with Major Degrade"
                elif degraded_20_to_30_percentage > (
                    degraded_above_30_percentage + degraded_10_to_20_percentage
                ):
                    remark = "Improve with Avg Degrade"
                elif degraded_10_to_20_percentage > (
                    degraded_above_30_percentage + degraded_20_to_30_percentage
                ):
                    remark = "Improve with Slight Degrade"

            result_summary.append(
                [
                    rnc,
                    self.mockpi,
                    rnc_cell_count,  # Replace cells_in_rnc with rnc_cell_count
                    total_cells,
                    "{:.2f}%".format(cells_improve_percent),
                    "{:.2f}%".format(rnc_improve_percent),
                    improved_count,
                    "{:.2f}%".format(cells_maintain_percent),
                    "{:.2f}%".format(rnc_maintain_percent),
                    maintain_count,
                    "{:.2f}%".format(cells_degrade_percent),
                    "{:.2f}%".format(rnc_degrade_percent),
                    degraded_count,
                    "{:.2f}%".format(degraded_10_to_20_percentage),
                    "{:.2f}%".format(rnc_10_to_20_percentage),
                    degraded_10_to_20,
                    "{:.2f}%".format(degraded_20_to_30_percentage),
                    "{:.2f}%".format(rnc_20_to_30_percentage),
                    degraded_20_to_30,
                    "{:.2f}%".format(degraded_above_30_percentage),
                    "{:.2f}%".format(rnc_above_30_percentage),
                    degraded_above_30,
                    remark,
                ]
            )

        return result_summary

