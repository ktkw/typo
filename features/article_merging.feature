Feature: Article Merging

	As a blog administrator
	In order to combine articles that are on the same/simliar topics
	I want to be able to merge articles

	Background: articles/users/comments have been added to database

		Given the blog is set up

		Given the following users exist:
			| profile_id | login	| name 	| password | state	| email 		|
			| 11		 | test_a	| tA 	| password | active	| fake@fake.com	|
			| 12		 | test_b	| tB 	| password | active	| fake@fake.com	|
			| 13		 | test_c	| tC 	| password | active	| fake@fake.com	|


		Given the following articles exist:
			| id 	| title		| author | body | published | state 	| user_id	| allow_comments 	| type		| published_at 			|
			| 3	 	| TitleA	| test_a | bodA | true		| published	| 11		| true				| Article	| 2015-03-10 21:00:00	|
			| 4  	| TitleB	| test_b | bodB | true 		| published | 12		| true				| Article	| 2015-03-10 20:00:00	|
			| 5  	| TitleC	| test_c | bodC | true 		| published | 13		| true 				| Article	| 2015-03-10 19:00:00	|

		Given the following comments exist:
			| id | type		| author | body | article_id | user_id	| created_at			|
			| 1  | Comment	| test_a | cmA1 | 5			 | 11		| 2015 03-11 21:00:00	|
			| 2  | Comment	| test_a | cmB1 | 5			 | 11		| 2015 03-11 21:00:01	|


	Scenario: non-admin cannot merge articles
		Given that I am logged in as "user1" with password "aaaaaaaa"
		Given I am on the edit page for article id 4
		Then I should not see "Merge Articles"

	Scenario: admin can merge articles
		Given that I am logged in as "admin" with password "aaaaaaaa"
		Given I am on the edit page for article id 3
		Then I should see "Merge Articles"

	Scenario: merged article should contain text of both articles
		Given that I am logged in as "admin" with password "aaaaaaaa"	
		Given that the articles with ids "3 and "4" were merged
		And I am on the home page
		Then I should see "TitleA"
		Then I should see "bodA bodB"

	Scenario: merged article should have one of the authors
		Given that I am logged in as "admin" with password "aaaaaaaa"	
		Given that the articles with ids "3 and "4" were merged
		And I am on the home page
		Then I should see "TitleA"
		And "test_a" should be the author of article "TitleA"

	Scenario: comments of articles need to carry over to the merged article
		Given that I am logged in as "admin" with password "aaaaaaaa"	
		Given that the articles with ids "3 and "5" were merged
		And I am on the home page
		Then show me the page
		Then I should see "2 comments"
