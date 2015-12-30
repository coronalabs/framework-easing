-------------------------------------------------------------------------------
--
-- easing.lua
--
-- Copyright (C) 2013 Corona Labs Inc. All Rights Reserved.
--
-------------------------------------------------------------------------------

-- NOTE: easing is assigned to the global var "easing" in init.lua.
-- This file should follows standard Lua module conventions

-----------------------------------------------------------------------------------------
-- localized variables
-----------------------------------------------------------------------------------------

local pow = math.pow
local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local abs = math.abs
local asin = math.asin

-- the easing table. The variable legend follows
-- t = transition current time
-- b = transition begin
-- c = change == transition ending - transition beginning
-- d = transition duration
-- a: amplitude
-- p: period

local easing = {}

-- per convention the params are to be called:
--t, tMax, start, delta
-- actual correspondence is

-- correspondence goes back to:
-- c - delta
-- b - start
-- d - tMax
-- t - t

-- so linear would be return b + c * t / d

-- the old lib params order is t, tMax, start, delta
-- the new lib params order is t, start, delta, tMax

easing.linear = function( t, tMax, start, delta )
	return delta * t / tMax + start
end

easing.inQuad = function( t, tMax, start, delta )
	t = t / tMax
	return delta * pow( t, 2 ) + start
end

easing.outQuad = function( t, tMax, start, delta )
	t = t / tMax
	return -delta * t * ( t - 2 ) + start
end

easing.inOutQuad = function( t, tMax, start, delta )
	t = t / tMax * 2
	if t < 1 then
		return delta / 2 * pow( t, 2 ) + start
	else
		return -delta / 2 * ( ( t - 1 ) * ( t - 3 ) - 1 ) + start
	end
end

easing.inCubic  = function( t, tMax, start, delta )
	t = t / tMax
	return delta * pow( t, 3 ) + start
end

easing.outCubic = function( t, tMax, start, delta )
	t = t / tMax - 1
	return delta * ( pow( t, 3 ) + 1 ) + start
end

easing.inOutCubic = function( t, tMax, start, delta )
	t = t / tMax * 2
	if t < 1 then
		return delta / 2 * t * t * t + start
	else
		t = t - 2
		return delta / 2 * ( t * t * t + 2 ) + start
	end
end

easing.outInCubic = function( t, tMax, start, delta )
	if t < tMax / 2 then
		return easing.outCubic( t * 2, tMax, start, delta / 2 )
	else
		return easing.inCubic( ( t * 2 ) - tMax, tMax, start + delta / 2, delta / 2 )
	end
end

easing.inQuart = function( t, tMax, start, delta )
	t = t / tMax
	return delta * pow( t, 4 ) + start
end

easing.outQuart = function( t, tMax, start, delta )
	t = t / tMax - 1
	return -delta * ( pow( t, 4 ) - 1 ) + start
end

easing.inOutQuart = function( t, tMax, start, delta )
	t = t / tMax * 2
	if t < 1 then
		return delta / 2 * pow( t, 4 ) + start
	else
		t = t - 2
		return -delta / 2 * ( pow( t, 4 ) - 2 ) + start
	end
end

easing.outInQuart = function( t, tMax, start, delta )
	if t < tMax / 2 then
		return easing.outQuart( t * 2, tMax, start, delta / 2 )
	else
		return easing.inQuart( ( t * 2 ) - tMax, tMax, start + delta / 2, delta / 2 )
	end
end

easing.inQuint = function( t, tMax, start, delta )
	t = t / tMax
	return delta * pow(t, 5) + start
end

easing.outQuint = function( t, tMax, start, delta )
	t = t / tMax - 1
	return delta * (pow(t, 5) + 1) + start
end

easing.inOutQuint = function( t, tMax, start, delta )
	t = t / tMax * 2
	if t < 1 then
		return delta / 2 * pow( t, 5 ) + start
	else
		t = t - 2
		return delta / 2 * ( pow( t, 5 ) + 2 ) + start
	end
end

easing.outInQuint = function( t, tMax, start, delta )
	if t < tMax / 2 then
		return easing.outQuint( t * 2, tMax, start, delta / 2 )
	else
		return easing.inQuint( ( t * 2 ) - tMax, tMax, start + delta / 2, delta / 2 )
	end
end

easing.inSine = function( t, tMax, start, delta )
	return -delta * cos( t / tMax * ( pi / 2 ) ) + delta + start
end

easing.outSine = function( t, tMax, start, delta )
	return delta * sin( t / tMax * ( pi / 2 ) ) + start
end

easing.inOutSine = function( t, tMax, start, delta )
	return -delta / 2 * ( cos( pi * t / tMax ) - 1 ) + start
end

easing.outInSine = function( t, tMax, start, delta )
	if t < tMax / 2 then
		return easing.outSine( t * 2, tMax, start, delta / 2 )
	else
		return easing.inSine( ( t * 2 ) -tMax, tMax, start + delta / 2, delta / 2 )
	end
end

easing.inExpo = function( t, tMax, start, delta )
        if t == 0 then
                return start
        else
                return delta * pow( 2, 10 * ( t / tMax - 1 ) ) + start - delta * 0.001
        end
end

easing.outExpo = function( t, tMax, start, delta )
	if t == tMax then
		return start + delta
	else
		return delta * ( -pow( 2, -10 * t / tMax ) + 1 ) + start
	end
end

easing.inOutExpo = function( t, tMax, start, delta )
	if t == 0 then return start end
	if t == tMax then return start + delta end
	t = t / tMax * 2
	if t < 1 then
		return delta / 2 * pow( 2, 10 * ( t - 1 ) ) + start - delta * 0.0005
	else
		t = t - 1
		return delta / 2 * 1.0005 * ( -pow( 2, -10 * t ) + 2 ) + start
	end
end

easing.outInExpo = function( t, tMax, start, delta )
	if t < tMax / 2 then
		return easing.outExpo( t * 2, tMax, start, delta / 2 )
	else
		return easing.inExpo( ( t * 2 ) - tMax, tMax, start + delta / 2, delta / 2 )
	end
end

easing.inCirc = function( t, tMax, start, delta )
	t = t / tMax
	return( -delta * ( sqrt( 1 - pow( t, 2 ) ) - 1 ) + start )
end

easing.outCirc = function( t, tMax, start, delta )
	t = t / tMax - 1
	return( delta * sqrt( 1 - pow( t, 2 ) ) + start )
end

easing.inOutCirc = function( t, tMax, start, delta )
	t = t / tMax * 2
	if t < 1 then
		return -delta / 2 * ( sqrt( 1 - t * t ) - 1 ) + start
	else
		t = t - 2
		return delta / 2 * ( sqrt( 1 - t * t ) + 1 ) + start
	end
end

easing.outInCirc = function( t, tMax, start, delta )
	if t < tMax / 2 then
		return easing.outCirc( t * 2, tMax, start, delta / 2 )
	else
		return easing.inCirc( ( t * 2 ) - tMax, tMax, start + delta / 2, delta / 2 )
	end
end

easing.inElastic = function( t, tMax, start, delta, a, p )
	if t == 0 then return start end
	t = t / tMax
	if t == 1 then return start + delta end
	if not p then p = tMax * 0.3 end
	local s
	if not a or a < abs( delta ) then
		a = delta
		s = p / 4
	else
		s = p / ( 2 * pi ) * asin( delta / a )
	end
	t = t - 1
	return -( a * pow( 2, 10 * t ) * sin( ( t * tMax - s ) * ( 2 * pi ) / p ) ) + start
end

easing.outElastic = function( t, tMax, start, delta, a, p )
	if t == 0 then return start end
	t = t / tMax
	if t == 1 then return start + delta end
	if not p then p = tMax * 0.3 end
	local s
	if not a or a < abs( delta ) then
		a = delta
		s = p / 4
	else
		s = p / ( 2 * pi ) * asin( delta / a )
	end
	return a * pow( 2, -10 * t ) * sin( ( t * tMax - s ) * ( 2 * pi ) / p ) + delta + start
end

easing.inOutElastic = function( t, tMax, start, delta, a, p )
	if t == 0 then return start end
	t = t / tMax * 2
	if t == 2 then return start + delta end
	if not p then p = tMax * ( 0.3 * 1.5 ) end
	if not a then a = 0 end
	if not a or a < abs( delta ) then
		a = delta
		s = p / 4
	else
		s = p / ( 2 * pi ) * asin( delta / a )
	end
	if t < 1 then
		t = t - 1
		return -0.5 * ( a * pow( 2, 10 * t ) * sin( ( t * tMax - s ) * ( 2 * pi ) / p ) ) + start
	else
		t = t - 1
		return a * pow( 2, -10 * t ) * sin( ( t * tMax - s ) * ( 2 * pi ) / p ) * 0.5 + delta + start
	end
end

easing.outInElastic = function( t, tMax, start, delta, a, p )
	if t < tMax / 2 then
		return easing.outElastic( t * 2, tMax, start, delta / 2, a, p )
	else
		return easing.inElastic( ( t * 2 ) - tMax, tMax, start + delta / 2, delta / 2, a, p )
	end
end

easing.inBack = function( t, tMax, start, delta, s )
	if not s then s = 1.70158 end
	t = t / tMax
	return delta * t * t * ( ( s + 1 ) * t - s ) + start
end

easing.outBack = function( t, tMax, start, delta, s )
	if not s then s = 1.70158 end
	t = t / tMax - 1
	return delta * ( t * t * ( ( s + 1 ) * t + s ) + 1 ) + start
end

easing.inOutBack = function( t, tMax, start, delta, s )
	if not s then s = 1.70158 end
	s = s * 1.525
	t = t / tMax * 2
	if t < 1 then
		return delta / 2 * ( t * t * ( ( s + 1 ) * t - s ) ) + start
	else
		t = t - 2
		return delta / 2 * ( t * t * ( ( s + 1 ) * t + s ) + 2 ) + start
	end
end

easing.outInBack = function( t, tMax, start, delta, s )
	if t < tMax / 2 then
		return easing.outBack( t * 2, tMax, start, delta / 2, s )
	else
		return easing.inBack( ( t * 2 ) - tMax, tMax, start + delta / 2, delta / 2, s )
	end
end

easing.outBounce = function( t, tMax, start, delta )
	t = t / tMax
	if t < 1 / 2.75 then
		return delta * ( 7.5625 * t * t ) + start
	elseif t < 2 / 2.75 then
		t = t - ( 1.5 / 2.75 )
		return delta * ( 7.5625 * t * t + 0.75 ) + start
	elseif t < 2.5 / 2.75 then
		t = t - ( 2.25 / 2.75 )
		return delta * ( 7.5625 * t * t + 0.9375 ) + start
	else
		t = t - ( 2.625 / 2.75 )
		return delta * ( 7.5625 * t * t + 0.984375 ) + start
	end
end

easing.inBounce = function( t, tMax, start, delta )
	return delta - easing.outBounce( tMax - t, tMax, 0, delta ) + start
end

easing.inOutBounce = function( t, tMax, start, delta )
	if t < tMax / 2 then
		return easing.inBounce( t * 2, tMax, 0, delta ) * 0.5 + start
	else
		return easing.outBounce( t * 2 - tMax, tMax, 0, delta ) * 0.5 + delta * .5 + start
	end
end

easing.outInBounce = function( t, tMax, start, delta )
	if t < tMax / 2 then
		return easing.outBounce( t * 2, tMax, start, delta / 2 )
	else
		return easing.inBounce( ( t * 2 ) - tMax, tMax, start + delta / 2, delta / 2 )
	end
end

easing.continuousLoop = function( t, tMax, start, delta)
	local interval = t / tMax
	if interval < 0.5 then
		return start + delta * interval * 2
	else
		return start + delta * ( 1 - interval ) * 2
	end
end

return easing
