---
-- @description Library http
 module("http")

--- http.Fetch
-- @usage shared_m
-- Launches a GET request.
--
-- @param  url string  The URL of the website to fetch.
-- @param  onSuccess=nil function  Function to be called on success. Arguments are   string body  string size - equal to string.len(body)  table headers  number code - The HTTP success code
-- @param  onFailure=nil function  Function to be called on failure. Arguments are   string error - The error message
function Fetch( url,  onSuccess,  onFailure) end

--- http.Post
-- @usage shared_m
-- Sends an asynchronous POST request to a HTTP server.
--
-- @param  url string  The url to of the website to fetch.
-- @param  parameters table  The post parameters to be send to the server. Keys and values must be strings.
-- @param  onSuccess=nil function  The function called on success: function( string responseText, number contentLength, table responseHeaders, number statusCode )
-- @param  onFailure=nil function  The function called on failure: function( string errorMessage )
function Post( url,  parameters,  onSuccess,  onFailure) end
