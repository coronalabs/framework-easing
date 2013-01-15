-------------------------------------------------------------------------------
--
-- easing.lua
--
-- Copyright (C) 2013 Corona Labs Inc. All Rights Reserved.
--
-------------------------------------------------------------------------------

-- NOTE: easing is assigned to the global var "easing" in init.lua.
-- This file should follos standard Lua module conventions
local easing = {}

easing.linear = function( t, tMax, start, delta )
	return start + delta*t/tMax;
end

easing.inQuad = function( t, tMax, start, delta )
	t = t/tMax
	return start + delta*t*t;
end

easing.outQuad = function( t, tMax, start, delta )
	t = t/tMax
	return start - delta*t*(t-2);
end

easing.inOutQuad = function( t, tMax, start, delta )
	t = (t + t)/tMax
	delta = delta / 2
	return t<1
		and (start + delta*t*t)
		or (start - (delta*((t-1)*(t-3)-1)))
end

easing.inExpo = function( t, tMax, start, delta )
	return t==0
		and start
		or (start + delta*(math.pow(2, 10*(t/tMax-1)) - 0.001))
end

easing.outExpo = function( t, tMax, start, delta )
	return t==tMax
		and (start + delta)
		or (start + delta*1.001*(-math.pow(2, -10*t/tMax) + 1))
end

easing.inOutExpo = function( t, tMax, start, delta )
	if t==0 then return start
	elseif t==tMax then return start+delta
	else
		t = (t + t)/tMax
		delta = delta / 2
		return t<1
			and (start + delta*(math.pow(2, 10*(t-1)) - 0.0001))
			or (start + delta*1.0001*(-math.pow(2, -10*(t-1)) +2))
	end
end

local function outBounce( t, tMax, start, delta )
	t = t/tMax
	if t < (1/2.75) then
		return start + delta*(7.5625*t*t)
	elseif t < (2/2.75) then
		t = t - (1.5/2.75)
		return start + delta*(7.5625*t*t + .75)
	elseif t < (2.5/2.75) then
		t = t - (2.25/2.75)
		return start + delta*(7.5625*t*t + .9375)
	else
		t = t - (2.625/2.75)
		return start + delta*(7.5625*t*t + .984375)
	end
end
local function inBounce( t, tMax, start, delta )
	return start + delta - outBounce( t, tMax, start, delta )
end

easing.outBounce = outBounce
easing.inBounce = inBounce
easing.inOutBounce = function( t, tMax, start, delta )
	if t < (0.5*tMax) then
		return start + 0.5*inBounce( t, tMax, start, delta )
	else
		return start + 0.5*( delta + outBounce( t, tMax, start, delta ) )
	end
end

return easing
