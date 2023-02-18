local ORB_SCALE = 10

return {
	bodyRadius = function(body)
		return math.sqrt(body.mass / math.pi) * ORB_SCALE
	end,
}
