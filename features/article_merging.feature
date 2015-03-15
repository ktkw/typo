Feature: Article Merging

	As a blog administrator
	In order to combine articles that are on the same/simliar topics
	I want to be able to merge articles

	Background: articles/users/comments have been added to database

		Given the blog is set up

		Given the following users exist:
			| profile_id | login	| name 	| password |
			| 11		 | test_a	| tA 	| password |
			| 12		 | test_b	| tB 	| password |
			| 13		 | test_c	| tC 	| password |

		Given the following articles exist:
			| id 	| title		| author | body | published | state 	| user_id	|
			| 21	| TitleA	| test_a | bodA | true		| published	| 11		|
			| 22 	| TitleB	| test_b | bodB | true 		| published | 12		|
			| 23 	| TitleC	| test_c | bodC | true 		| published | 13		|

		Given the following comments exist:
			| id | type		| author | body | article_id | user_id	|
			| 31 | Comment	| test_a | cmA1 | 23		 | 11		|	
			| 32 | Comment	| test_b | cmB1 | 23		 | 12		|
			| 33 | Comment	| test_c | cmC1 | 21		 | 13		|
			| 41 | Comment	| test_c | cmC2 | 22		 | 13		|


	Scenario: non-admin cannot merge articles
		Given that I am logged in as "test_a" with password "password"
		Given that I am on the edit page of article with id "22"
		Then I should not see "Merge Articles"

	Scenario: admin can merge articles
		Given that I am on the edit page of article with id "11"
		Then I should see "Merge Articles"

	Scenario: merged article should contain text of both articles
		Given that the articles with ids "21 and "22" were merged
		And I am on the home page
		Then I should see "TitleA"
		When I press "TitleA"
		Then I should see "bodA"
		And I should see "bodB"

	Scenario: merged article should have one of the authors
		Given that the articles with ids "21 and "22" were merged
		And I am on the home page
		Then I should see "TitleA"
		And "test_a" should be the author of article "TitleA TitleB"

	Scenario: comments of articles need to carry over to the merged article
		Given that the articles with ids "21 and "22" were merged
		And I am on the home page
		When I press "TitleA"
		Then I should see "cmC1"
		And I should see "cmC2"

	Scenario: title should be one of the original ones (pick the first)
		Given that the articles with ids "21 and "22" were merged
		And I am on the home page
		Then I should see "TitleA"
		And I should not see "TitleB"