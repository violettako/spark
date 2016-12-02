require "selenium-webdriver"


browser = Selenium::WebDriver.for :safari

# 1. Go to bing.com
browser.navigate.to "http://www.bing.com/"
element = browser.find_element(:name, 'q')


# 2. Perform search 'sparkcentral'
element.send_keys "sparkcentral"
element.submit


# 3. Verify that first search result 'Sparkcentral - Official Site'
# Creating an array to store all the items / li from search 
results = browser.find_element(:id,"b_result").find_elements(:class, "b_algo")

# iterating through each result and checking link 
if results[0].link == "https://www.sparkcentral.com/"
	print "First item in results is official sparkcentral site"
else 
	print "First results is not officaial site, not cool"
end


# 4. Verify that all search results on first page contain 'Sparkcentral'
for item in results
	if item.text == sparkcenral 
		print "All items have sparkcentral in it"
	else print "Missing sparkcentral text in #{item}"
	end
end


# 5. Verify that 'Product' link in first search result is actually pointing to /product
# drilling down in results to deeplink information
deep_li_information = results.find_element(:class, "b_vlist2col b_deep")
if results[0].find_element(:class, "deeplink_title").link  == "https://www.sparkcentral.com/"
	print "First link redirects to /product page"
else 
	print "Failed :: first item is not /product. "
end

