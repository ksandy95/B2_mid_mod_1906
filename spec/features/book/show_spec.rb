require 'rails_helper'

RSpec.describe "Book Index" do
  describe "As a visitor" do
    before :each do
      @author_1 = Author.create(name: "Burt T. Urtle")
      @author_2 = Author.create(name: "Lady Bird Johnson")

      @book_1 = Book.create(title: "Duck and Cover", number_of_pages: 68, publication_year: "1954")
      @book_2 = Book.create(title: "The Great Society", number_of_pages: 495, publication_year: "1972")

      @book_authors_1 = @book_1.book_authors.create!(author_id: @author_1.id)
      @book_authors_2 = @book_1.book_authors.create!(author_id: @author_2.id)
      @book_authors_3 = @book_2.book_authors.create!(author_id: @author_2.id)

    end
    it "When I visit /books, Then I see each book in the system including the books:
     title, number of pages, publication year the name of each author that wrote the book" do
      visit '/books'

      within "#book-#{@book_1.id}" do
        expect(page).to have_content(@book_1.title)
        expect(page).to have_content(@book_1.number_of_pages)
        expect(page).to have_content(@book_1.publication_year)
      end

      within "#book-#{@book_2.id}" do
        expect(page).to have_content(@book_2.title)
        expect(page).to have_content(@book_2.number_of_pages)
        expect(page).to have_content(@book_2.publication_year)
      end

    end

    it "author show page" do
      visit "/books"

      expect(page).to have_link("Burt T. Urtle")

      expect(page).to have_link("Lady Bird Johnson")

      click_on "Burt T. Urtle"

      expect(current_path).to eq("/authors/#{@author_1.id}")
      expect(page).to have_content("Burt T. Urtle")

      expect(page).to have_content(@book_1.title)

      expect(page).to have_content("Average Page Count: #{@author_1.average_page_count}")

    end
  end
end
