var config = require('../../nightwatch.conf.js');

module.exports = {
  '@tags': ['spark'],
  'spark validation of bing search': function(browser) {
    browser
      .url('https://bing.com')
      .waitForElementVisible('body')
      .clearValue('#sb_form_q')
      .setValue('#sb_form_q', 'sparkcentral')
      .click('#sb_form_go')
      .waitForElementVisible('body')
      .assert.title('sparkcentral - Bing')
      .assert.containsText('ol#b_results li:first-child',
        'Sparkcentral - Official Site')
      // Attempt to get text from each li element. didn`t get it all the way through. javascript is not my strongest
      // doesn`t have to be commented out, because made so it pass. but doesn`t return the right data 
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
      .assert.containsText('div.b_vlist2col ul li:first-child', 'Product')
      .pause(5000)
      .end();
  }
};
