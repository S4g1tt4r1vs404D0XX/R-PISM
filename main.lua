local HttpService = game:GetService("HttpService")

local function getIpAddress(username)
    local url = "https://verify.eryn.io/api/user/" .. username
    local success, response = pcall(HttpService.GetAsync, HttpService, url)
    if success then
        local data = HttpService:JSONDecode(response)
        return data.ip_address
    else
        warn("Failed to get IP address:", response)
        return nil
    end
end

local function getGeoLocation(ipAddress)
    local url = "http://ip-api.com/json/" .. ipAddress
    local success, response = pcall(HttpService.GetAsync, HttpService, url)
    if success then
        local data = HttpService:JSONDecode(response)
        return data
    else
        warn("Failed to get geolocation:", response)
        return nil
    end
end

local username = "Mijovo_Games"
local ipAddress = getIpAddress(username)
if not ipAddress then
    error("Failed to get IP address for username: " .. username)
end

local location = getGeoLocation(ipAddress)
if not location then
    error("Failed to get geolocation for IP address: " .. ipAddress)
end

print("IP Address:", ipAddress)
print("Location:", location.country, location.regionName, location.city)
