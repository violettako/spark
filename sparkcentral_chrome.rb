require 'selenium-webdriver'

def setup
  @browser = Selenium::WebDriver.for :chrome

end



def teardown
  @browser.quit
end

def run
  setup
  yield
  teardown
end


run do

  # 1. Go to bing.com
  @browser.navigate.to "https://www.bing.com"

  # 2. Perform search 'sparkcentral'
  @browser.find_element(id: "sb_form").find_element(class: "b_searchbox").send_keys ["sparkcentral"]
  #click magnifying glass
  @browser.find_element(id: "sb_form_go").click
  

  # 4. Verify that all search results on first page contain 'Sparkcentral'
  #get list of results and iterate through each. Print out text of failed one
  search_results = @browser.find_element(id: "b_results").find_elements(class: "b_algo")
  search_results.each do |result|
    if result.text.downcase.include? "sparkcentral"
      next
    else
      failed_one = result.text
      puts "doesn`t #{failed_one}"
    end 
  end 



  
  # 3. Verify that first search result 'Sparkcentral - Official Site', if not it will get an error 
  first_result = search_results.first

  if first_result.text.include? "Sparkcentral - Official Site"
    puts "Sparkcentral official site is the first result!"

  # 5. Verify that 'Product' link in first search result is actually pointing to /product
    product_link = first_result.find_element(link_text: "Product")
    if product_link.attribute(:href) == "https://www.sparkcentral.com/product/"
      product_link.click
      sleep 2
      if @browser.current_url == "https://www.sparkcentral.com/product/"
        puts "Test Passed! :} First link was /product"
      else
      	#'raise' throws RuntimeError
        raise "uh-oh, link redirects to #{@browser.current_url}, not cool"
      end
    else
      #if Sparkcentral isn't first result, print the first line of each result in order
      puts "First 10 results in order:"
      search_results.each do |result|
        header_with_result_text = result.find_elements(tag_name: "h2").first
        puts header_with_result_text
      end
      raise "Sparkcentral is not first search result returned :("
    end

  end

end
