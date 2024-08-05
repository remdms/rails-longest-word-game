require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "div.letter", count: 10
    puts "New grid test passed successfully!"
  end

  test "Trying a random combination of letters" do
    visit new_url
    assert test: "Random letters"
    fill_in "guess", with: "word"
    click_on "Play!"
    assert_text "cannot be built out of"
    puts "Existing word test passed successfully!"
  end
end
