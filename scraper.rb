# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

require 'scraperwiki'
require 'mechanize'
agent = Mechanize.new
#
# # Read in a page
base_url = "https://write.kogus.org/articles/G6P2yH"
base_page = agent.get(base_url)
#
# # Find somehing on the page using css selectors
# p page.at('div.content')
base_page.at('table').search('tr').each do |tr|
  key = tr.search('td:nth-child(2)').text
  value = tr.search('td:last-child').text
  info = {
    onomatope_jp: key,
    onomatope_en: value
  }
  ScraperWiki.save_sqlite([:onomatope_jp], info,table_name="onomatopes")
end
#
# # Write out to the sqlite database using scraperwiki library
# ScraperWiki.save_sqlite(["name"], {"name" => "susan", "occupation" => "software developer"})
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries.
# You can use whatever gems you want: https://morph.io/documentation/ruby
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".
