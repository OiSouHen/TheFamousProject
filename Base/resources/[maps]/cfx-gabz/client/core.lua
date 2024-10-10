CreateThread(function()
	RequestIpl("gabz_pillbox_milo_")

	local HospitalInterior = GetInteriorAtCoords(311.2546, -592.4204, 42.32737)
	if IsValidInterior(HospitalInterior) then
		RemoveIpl("rc12b_fixed")
		RemoveIpl("rc12b_destroyed")
		RemoveIpl("rc12b_default")
		RemoveIpl("rc12b_hospitalinterior_lod")
		RemoveIpl("rc12b_hospitalinterior")

		RefreshInterior(HospitalInterior)
	end

	RequestIpl("gabz_mrpd_milo_")

	local PoliceInterior = GetInteriorAtCoords(451.0129, -993.3741, 29.1718)
	if IsValidInterior(PoliceInterior) then      
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm1")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm2")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm3")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm4")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm5")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm6")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm7")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm8")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm9")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm10")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm11")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm12")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm13")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm14")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm15")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm16")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm17")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm18")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm19")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm20")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm21")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm22")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm23")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm24")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm25")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm26")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm27")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm28")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm29")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm30")
		EnableInteriorProp(PoliceInterior, "v_gabz_mrpd_rm31")

		RefreshInterior(PoliceInterior)
	end

	RequestIpl("gabz_imp_impexp_interior_placement_interior_1_impexp_intwaremed_milo_")

	local ImportInterior = GetInteriorAtCoords(941.00840000, -972.66450000, 39.14678000)
	if IsValidInterior(ImportInterior) then
		EnableInteriorProp(ImportInterior, "branded_style_set")
		EnableInteriorProp(ImportInterior, "car_floor_hatch")

		RefreshInterior(ImportInterior)
	end
end)