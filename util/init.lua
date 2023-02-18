local ORB_SCALE = 10

return {
	bodyRadius = function(body)
		return math.sqrt(body.mass / math.pi) * ORB_SCALE
	end,
	radiusToMass = function(radius)
		if radius <= 0 then
			return 0
		end
		return (math.pi * radius ^ 2) / ORB_SCALE ^ 2
	end,
}
