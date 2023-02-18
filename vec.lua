local Vec = {}

local atan2 = math.atan2
local sqrt = math.sqrt

local m = {
	__index = Vec,
	__tostring = function(self)
		return string.format("(%+0.3f,%+0.3f)", self.x, self.y)
	end,
}

Vec.new = function(x, y)
	return setmetatable({
		x = x,
		y = y,
	}, m)
end

Vec.mul = function(self, other)
	return Vec.new(self.x * other.x, self.y * other.y)
end

Vec.add = function(self, other)
	return Vec.new(self.x + other.x, self.y + other.y)
end

Vec.sub = function(self, other)
	return Vec.new(self.x - other.x, self.y - other.y)
end

Vec.angle_to = function(self, other)
	return atan2(self.y - other.y, self.x - other.x)
end

Vec.normalize = function(self)
	local len = self:len()
	return Vec.new(self.x / len, self.y / len)
end

Vec.len = function(self)
	return sqrt(self.x * self.x + self.y * self.y)
end

Vec.len2 = function(self)
	return self.x * self.x + self.y * self.y
end

Vec.dist = function(self, other)
	local dx = self.x - other.x
	local dy = self.y - other.y
	return sqrt(dx * dx + dy * dy)
end

Vec.dist2 = function(self, other)
	local dx = self.x - other.x
	local dy = self.y - other.y
	return dx * dx + dy * dy
end

Vec.scale = function(self, scalar)
	return Vec.new(self.x * scalar, self.y * scalar)
end

Vec.of = function(value)
	return Vec.new(value, value)
end

Vec.clone = function(self)
	return Vec.new(self.x, self.y)
end

return setmetatable(Vec, {
	__call = function(_, x, y)
		return Vec.new(x, y)
	end,
})
