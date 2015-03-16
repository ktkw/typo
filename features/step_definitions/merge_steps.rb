
Given /^the following users exist:$/ do |table|
  table.hashes.each do |user|
  	User.create(user)
  end
end

Given /^the following articles exist:$/ do |table|
	table.hashes.each do |article|
		Article.create(article)
  end
end

Given /^the following comments exist:$/ do |table|
  table.hashes.each do |com|
  	Comment.create(com)
  end
end

Given /^that I am logged in as "(.*?)" with password "(.*?)"$/ do |user, pass|
  visit '/accounts/login'
  fill_in 'user_login', :with => user
  fill_in 'user_password', :with => pass
  click_button 'Login'
  page.should have_content('Login successful')
end

Given /^that the articles with ids "(.*?)"(\d+)" were merged$/ do |a1, a2|
  first = Article.find_by_id(a1)
  first.merge_with(a2)
end

Then /^"(.*?)" should be the author of article "(.*?)"$/ do |author, title|
  assert Article.find_all_by_author(author).size == 1
end

Given /^that I go to "(.*?)" from "(.*?)"$/ do |title, date|
  visit "/" + date + "/" + title.downcase
end
