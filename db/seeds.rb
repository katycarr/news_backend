# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# FeedManager.new.pull_stories


# Article.all.each do |article|
#   full_text = Scraper.new.scrape(article.url)
#   article.reading_time = Timer.new.get_time(full_text)
#   article.save
# end

Article.delete_all
Article.reset_pk_sequence
ArticleTopic.delete_all
ArticleTopic.reset_pk_sequence

FeedManager.new.pull_stories
