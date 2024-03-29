rule = {
	matches = {
		{
			{
				"node.name",
				"equals",
				"alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_4__sink",
			},
			{
				"node.nick",
				"matches",
				"HDMI *",
			},
		},
	},
	apply_properties = {
		["node.disabled"] = true,
	},
}

table.insert(alsa_monitor.rules, rule)
