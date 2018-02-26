require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Cualquier vaina" do
    visit new_url
    fill_in "user_answer", with: "aaaaaaaaaaaaaa"
    click_on "Play"
    assert_text "Sorry buy AAAAAAAAAAAAAA does not seem to be a valid English word..."
  end
end
