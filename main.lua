--[[]]local function webListener( event )	URLA = event.url    if event.url then        print( "You are visiting: " .. event.url )	    if string.find ( URLA, "url:" ) ~= nil then			native.showAlert( "AES:", string.sub(event.url,5,string.len(event.url)) , { "OK" } )			print ( string.sub(event.url,5,string.len(event.url)) )	    	local aa = string.find ( event.url, "url:" )	    	--lookupBarcode (string.sub(event.url,5,string.len(event.url)) )			--native.showAlert( "Error!", string.sub(event.url,5,string.len(event.url)), { "OK" } )	    end    end    if event.type then        print( "The event.type is " .. event.type ) -- print the type of request    end    if event.errorCode then        --native.showAlert( "Error!", event.errorMessage, { "OK" } )    end   local path = system.pathForFile( "aes.html", system.TemporaryDirectory )    print ( os.remove( path ) )endfunction createindexFile ( event, passPhrase )aa = ""	aa = "<!DOCTYPE html>"	aa  = aa .. "<html>"	aa  = aa .. "<script src=\"http://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/aes.js\"></script>"	aa  = aa .. "<script>"	aa  = aa .. "    var encrypted = CryptoJS.AES.encrypt(\"" .. event .. "\", \"Secret Passphrase\");"	aa  = aa .. "var decrypted = CryptoJS.AES.decrypt(encrypted, \"Secret Passphrase\");"	aa  = aa .. "document.write(decrypted.toString(CryptoJS.enc.Utf8));"	aa  = aa .. "window.location='url:'+encrypted;"	aa  = aa .. "</script>"	aa  = aa .. "</body>"	aa  = aa .. "</html>"	local path = system.pathForFile( "aes.html", system.TemporaryDirectory )	-- io.open opens a file at path. returns nil if no file found	local fh, errStr = io.open( path, "w" )	if fh then		print( "Created file" )	else		print( "Create file failed!" )	end		fh:write(aa)	io.close( fh )endcreateindexFile ( "Secret Text","passPhrase" )local webView = native.newWebView( 0, 0, 1, 1 )webView.alpha = 0webView:addEventListener( "urlRequest", webListener )webView:request( "aes.html", system.TemporaryDirectory )--]]