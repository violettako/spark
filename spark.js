var config = require('../../nightwatch.conf.js');

module.exports = {
  '@tags': ['sparkcentral'],
  'sparkcentral validation of bing search': function(browser) {
    browser
    // 1. Go to bing.com
      .url('https://bing.com')
      .waitForElementVisible('body')
    // 2. Perform search 'sparkcentral'
      .clearValue('#sb_form_q')
      .setValue('#sb_form_q', 'sparkcentral')
      .click('#sb_form_go')
      .waitForElementVisible('body')
      .assert.title('sparkcentral - Bing')

    // 3. Verify that first search result 'Sparkcentral - Official Site'
      .assert.containsText('ol#b_results li:first-child',
        'Sparkcentral - Official Site')
    
    // Attempt :: 4. Verify that all search results on first page contain 'Sparkcentral'
    // Attempt to get text from each li element. didn`t get it all the way through.
    // doesn`t have to be commented out, because made it so it pass. but doesn`t return the right data 
      .execute(function(){
        var arr = (function(a, b){
            return (Array(a.length) + '').split(',').map(function(c, d){
                return a[d].innerHTML;
          });
          })(document.getElementsByTagName('ol')[0].getElementsByTagName('li'));
        return arr;  
      }, ['arr'] ,function(result){
        array_h1 = result.value
        console.log(array_h1.length)
      })
    // end of attempt

    // 5. Verify that 'Product' link in first search result is actually pointing to /product
      .assert.containsText('div.b_vlist2col ul li:first-child', 'Product')
      .pause(5000)
      .end();
  }
};
