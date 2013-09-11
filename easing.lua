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

easing.linear = function( t, b, c, d )
	return c * t / d + b
end

easing.inQuad = function( t, b, c, d )
	t = t / d
	return c * pow( t, 2 ) + b
end

easing.outQuad = function( t, b, c, d )
	t = t / d
	return -c * t * ( t - 2 ) + b
end

easing.inOutQuad = function( t, b, c, d )
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow( t, 2 ) + b
	else
		return -c / 2 * ( ( t - 1 ) * ( t - 3 ) - 1 ) + b
	end
end

easing.inCubic  = function( t, b, c, d )
	t = t / d
	return c * pow( t, 3 ) + b
end

easing.outCubic = function( t, b, c, d )
	t = t / d - 1
	return c * ( pow( t, 3 ) + 1 ) + b
end

easing.inOutCubic = function( t, b, c, d )
	t = t / d * 2
	if t < 1 then
		return c / 2 * t * t * t + b
	else
		t = t - 2
		return c / 2 * ( t * t * t + 2 ) + b
	end
end

easing.outInCubic = function( t, b, c, d )
	if t < d / 2 then
		return easing.outCubic( t * 2, b, c / 2, d )
	else
		return easing.inCubic( ( t * 2 ) - d, b + c / 2, c / 2, d )
	end
end

easing.inQuart = function( t, b, c, d )
	t = t / d
	return c * pow( t, 4 ) + b
end

easing.outQuart = function( t, b, c, d )
	t = t / d - 1
	return -c * ( pow( t, 4 ) - 1 ) + b
end

easing.inOutQuart = function( t, b, c, d )
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow( t, 4 ) + b
	else
		t = t - 2
		return -c / 2 * ( pow( t, 4 ) - 2 ) + b
	end
end

easing.outInQuart = function( t, b, c, d )
	if t < d / 2 then
		return easing.outQuart( t * 2, b, c / 2, d )
	else
		return easing.inQuart( ( t * 2 ) - d, b + c / 2, c / 2, d )
	end
end

easing.inQuint = function( t, b, c, d )
	t = t / d
	return c * pow(t, 5) + b
end

easing.outQuint = function( t, b, c, d )
	t = t / d - 1
	return c * (pow(t, 5) + 1) + b
end

easing.inOutQuint = function( t, b, c, d )
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow( t, 5 ) + b
	else
		t = t - 2
		return c / 2 * ( pow( t, 5 ) + 2 ) + b
	end
end

easing.outInQuint = function( t, b, c, d )
	if t < d / 2 then
		return easing.outQuint( t * 2, b, c / 2, d )
	else
		return easing.inQuint( ( t * 2 ) - d, b + c / 2, c / 2, d )
	end
end

easing.inSine = function( t, b, c, d )
	return -c * cos( t / d * ( pi / 2 ) ) + c + b
end

easing.outSine = function( t, b, c, d )
	return c * sin( t / d * ( pi / 2 ) ) + b
end

easing.inOutSine = function( t, b, c, d )
	return -c / 2 * ( cos( pi * t / d ) - 1 ) + b
end

easing.outInSine = function( t, b, c, d )
	if t < d / 2 then
		return easing.outSine( t * 2, b, c / 2, d )
	else
		return easing.inSine( ( t * 2 ) -d, b + c / 2, c / 2, d )
	end
end

easing.inExpo = function( t, b, c, d )
        if t == 0 then
                return b
        else
                return c * pow( 2, 10 * ( t / d - 1 ) ) + b - c * 0.001
        end
end

easing.outExpo = function( t, b, c, d )
	if t == d then
		return b + c
	else
		return c * 1.001 * ( -pow( 2, -10 * t / d ) + 1 ) + b
	end
end

easing.inOutExpo = function( t, b, c, d )
	if t == 0 then return b end
	if t == d then return b + c end
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow( 2, 10 * ( t - 1 ) ) + b - c * 0.0005
	else
		t = t - 1
		return c / 2 * 1.0005 * ( -pow( 2, -10 * t ) + 2 ) + b
	end
end

easing.outInExpo = function( t, b, c, d )
	if t < d / 2 then
		return easing.outExpo( t * 2, b, c / 2, d )
	else
		return easing.inExpo( ( t * 2 ) - d, b + c / 2, c / 2, d )
	end
end

easing.inCirc = function( t, b, c, d )
	t = t / d
	return( -c * ( sqrt( 1 - pow( t, 2 ) ) - 1 ) + b )
end

easing.outCirc = function( t, b, c, d )
	t = t / d - 1
	return( c * sqrt( 1 - pow( t, 2 ) ) + b )
end

easing.inOutCirc = function( t, b, c, d )
	t = t / d * 2
	if t < 1 then
		return -c / 2 * ( sqrt( 1 - t * t ) - 1 ) + b
	else
		t = t - 2
		return c / 2 * ( sqrt( 1 - t * t ) + 1 ) + b
	end
end

easing.outInCirc = function( t, b, c, d )
	if t < d / 2 then
		return transitionLibrary._easing.outCirc( t * 2, b, c / 2, d )
	else
		return transitionLibrary._easing.inCirc( ( t * 2 ) - d, b + c / 2, c / 2, d )
	end
end

easing.inElastic = function( t, b, c, d, a, p )
	if t == 0 then return b end
	t = t / d
	if t == 1 then return b + c end
	if not p then p = d * 0.3 end
	local s
	if not a or a < abs( c ) then
		a = c
		s = p / 4
	else
		s = p / ( 2 * pi ) * asin( c/a )
	end
	t = t - 1
	return -( a * pow( 2, 10 * t ) * sin( ( t * d - s ) * ( 2 * pi ) / p ) ) + b
end

easing.outElastic = function( t, b, c, d, a, p )
	if t == 0 then return b end
	t = t / d
	if t == 1 then return b + c end
	if not p then p = d * 0.3 end
	local s
	if not a or a < abs( c ) then
		a = c
		s = p / 4
	else
		s = p / ( 2 * pi ) * asin( c/a )
	end
	return a * pow( 2, -10 * t ) * sin( ( t * d - s ) * ( 2 * pi ) / p ) + c + b
end

easing.inOutElastic = function( t, b, c, d, a, p )
	if t == 0 then return b end
	t = t / d * 2
	if t == 2 then return b + c end
	if not p then p = d * ( 0.3 * 1.5 ) end
	if not a then a = 0 end
	if not a or a < abs( c ) then
		a = c
		s = p / 4
	else
		s = p / ( 2 * pi ) * asin( c / a )
	end
	if t < 1 then
		t = t - 1
		return -0.5 * ( a * pow( 2, 10 * t ) * sin( ( t * d - s ) * ( 2 * pi ) / p ) ) + b
	else
		t = t - 1
		return a * pow( 2, -10 * t ) * sin( ( t * d - s ) * ( 2 * pi ) / p ) * 0.5 + c + b
	end
end

easing.outInElastic = function( t, b, c, d, a, p )
	if t < d / 2 then
		return easing.outElastic( t * 2, b, c / 2, d, a, p )
	else
		return easing.inElastic( ( t * 2 ) - d, b + c / 2, c / 2, d, a, p )
	end
end

easing.inBack = function( t, b, c, d, s )
	if not s then s = 1.70158 end
	t = t / d
	return c * t * t * ( ( s + 1 ) * t - s ) + b
end

easing.outBack = function( t, b, c, d, s )
	if not s then s = 1.70158 end
	t = t / d - 1
	return c * ( t * t * ( ( s + 1 ) * t + s ) + 1 ) + b
end

easing.inOutBack = function( t, b, c, d, s )
	if not s then s = 1.70158 end
	s = s * 1.525
	t = t / d * 2
	if t < 1 then
		return c / 2 * ( t * t * ( ( s + 1 ) * t - s ) ) + b
	else
		t = t - 2
		return c / 2 * ( t * t * ( ( s + 1 ) * t + s ) + 2 ) + b
	end
end

easing.outInBack = function( t, b, c, d, s )
	if t < d / 2 then
		return easing.outBack( t * 2, b, c / 2, d, s )
	else
		return easing.inBack( ( t * 2 ) - d, b + c / 2, c / 2, d, s )
	end
end

easing.outBounce = function( t, b, c, d )
	t = t / d
	if t < 1 / 2.75 then
		return c * ( 7.5625 * t * t ) + b
	elseif t < 2 / 2.75 then
		t = t - ( 1.5 / 2.75 )
		return c * ( 7.5625 * t * t + 0.75 ) + b
	elseif t < 2.5 / 2.75 then
		t = t - ( 2.25 / 2.75 )
		return c * ( 7.5625 * t * t + 0.9375 ) + b
	else
		t = t - ( 2.625 / 2.75 )
		return c * ( 7.5625 * t * t + 0.984375 ) + b
	end
end

easing.inBounce = function( t, b, c, d )
	return c - easing.outBounce( d - t, 0, c, d ) + b
end

easing.inOutBounce = function( t, b, c, d )
	if t < d / 2 then
		return easing.inBounce( t * 2, 0, c, d ) * 0.5 + b
	else
		return easing.outBounce( t * 2 - d, 0, c, d ) * 0.5 + c * .5 + b
	end
end

easing.outInBounce = function( t, b, c, d )
	if t < d / 2 then
		return easing.outBounce( t * 2, b, c / 2, d )
	else
		return easing.inBounce( ( t * 2 ) - d, b + c / 2, c / 2, d )
	end
end

easing.continuousLoop = function( t, b, c, d )
	local interval = t / d 
	if interval < 0.5 then
		return ( ( c - b ) * ( interval + interval ) ) + b
	else
		return ( ( b - c ) * ( ( interval - 0.5 ) * 2 ) ) + c
	end
end

return easing