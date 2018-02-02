--@----------------------------------------------------------------------------------------
--[[
	Http
	
	Library for HttpService
--]]
--@----------------------------------------------------------------------------------------
local HttpService = {GetAsync = function() end; PostAsync = function() end}--game:GetService("HttpService");
local aloopi = require 'aloopi'
--@----------------------------------------------------------------------------------------
local HttpContentType = aloopi.class() {
	__type = 'HttpContentType';
	
	['__init(str)'] = function(self, content_type)
		self['type: str'] = content_type;
	end
	
}
--@----------------------------------------------------------------------------------------
local Http = aloopi.class () {
	__type = 'Http';
	
	--[[
		string|table Http.Get(string url, bool nocache = false, dictionary headers = nil,
		bool err = false)
		
		Abstracted HttpService.GetAsync. Safely calls GET method and returns data or error data.
	
		@args:
			(string)url - Url of website.
			(bool)nocache
			(dictionary)headers - GET Headers.
			
		@returns:
			string - GET Response.
			
			OR
			
			table - Error response.
			{
				status = 000		- Http Status Code
				msg = ""			- Http Status Code Meaning/Msg
			}
	--]]
	['Get(str, bool?, tab<str, str>?, bool?)'] = function(self, url, nocache, headers, err)
		local success, data = pcall(function()
			return HttpService:GetAsync(url, nocache, headers);
		end)
		
		if (success) then
			return data
		else
			local errInfo, errOutput = self.Err(url, "post", data);
			
			if (errInfo and errOutput) then
				if (err) then
					error(errOutput)
				else
					return errInfo;
				end
			end
			
			-- Well we don't know what it is, so error.
			error(data);
		end
	end;
	
	--[[
		string|table Http.Post(string url, string data[, HttpContentType content_type, 
		bool compress, dictionary headers = nil, bool err = false])
		
		Abstracted HttpService.PostAsync. Safely calls POST method and returns data or 
		error data.
	
		@args:
			url
				Type: string
				Required
			data
				Type: string
				Required
			content_type
				Type: HttpContentType
				Defaults to: Enum.HttpContentType.ApplicationJson
			compress
				Type: bool
				Defaults to: false
			headers
				Type: dictionary
				Defaults to: nil
			
		@returns:
			string - POST Response.
			
			OR
			
			table - Error response.
			{
				status = 000		- Http Status Code
				msg = ""			- Http Status Code Meaning/Msg
			}
	--]]
	['Post(str, str, HttpContentType, bool, str?, bool?)'] = 
	function(self, url, data, content_type, compress, headers, err)
		local success, data = pcall(function()
			return HttpService:PostAsync(url, data, content_type.type, compress, headers);
		end)
		
		if (success) then
			return data
		else
			local errInfo, errOutput  = self.Err(url, "post", data);
			
			if (errInfo and errOutput) then
				if (err) then
					error(errOutput)
				else
					return errInfo;
				end
			end
			
			-- Well we don't know what it is, so error.
			error(data);
		end
	end;
	
	--[[
		bool Http.DidErr(string|table response)
		
		Checks if http response was an error reponse or not.
		
		@returns:
			bool	- True if the response is an error response.
	--]]
	DidErr = function(self, response)
		if (type(response) == "table") then
			return true;
		end
		return false;
	end;
	
	--[[
		table, string Http.Err(string url, string method, string data)
		
		Pretty error output
	--]]
	['Err(str, str, str)'] = function(self, url, method, data)
		local status, msg = data:match("HTTP ([%d]+) %(HTTP/[%d.]+ [%d]+ ([%w]*)%)");
		if (status and msg) then
			local info = {
				method = method;
				url = url;
				status = tonumber(status);
				msg = msg;
			};
			
			local str = 
			"Method: " .. info.method .. "\n\
			Url: " .. info.url .. "\n\
			Status: " .. info.status .. "\n\
			Msg: " .. info.msg;
		
			return info, str;
		end
	end
}
--@----------------------------------------------------------------------------------------
print(
	Http.Get('https://www.youtube.com/', nil, nil, true)
)
--@----------------------------------------------------------------------------------------