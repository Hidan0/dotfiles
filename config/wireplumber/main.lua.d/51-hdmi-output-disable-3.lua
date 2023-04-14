rule = {
	matches = {
		{
			{ "node.name", "equals", "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__HDMI3__sink" },
		},
	},
	apply_properties = {
		["node.disabled"] = true,
	},
}

table.insert(alsa_monitor.rules, rule)
